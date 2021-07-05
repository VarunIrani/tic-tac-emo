import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:tic_tac_emo/players.dart';
import 'package:tic_tac_emo/utils.dart';

class TicTacEmo extends StatefulWidget {
  @override
  _TicTacEmoState createState() => _TicTacEmoState();
}

class _TicTacEmoState extends State<TicTacEmo> {
  final int countMatrix = 3;
  final double size = 92;
  int player1Score = 0, player2Score = 0;

  String lastMove = Players.none;
  late List<List<String>> matrix;
  late ColorScheme colorScheme;

  @override
  void initState() {
    super.initState();
    setEmptyFields();
  }

  void setEmptyFields() => setState(() => matrix = List.generate(
      countMatrix, (_) => List.generate(countMatrix, (_) => Players.none)));

  @override
  Widget build(BuildContext context) {
    colorScheme = ThemeProvider.themeOf(context).data.colorScheme;
    final TextTheme textTheme = ThemeProvider.themeOf(context).data.textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed("/");
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: colorScheme.secondary,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Player ${Players.X}",
                    style: textTheme.headline5!
                        .copyWith(color: colorScheme.onBackground),
                  ),
                  Text(
                    player1Score.toString(),
                    style: textTheme.headline5!
                        .copyWith(color: colorScheme.onBackground),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Player ${Players.O}",
                    style: textTheme.headline5!
                        .copyWith(color: colorScheme.onBackground),
                  ),
                  Text(
                    player2Score.toString(),
                    style: textTheme.headline5!
                        .copyWith(color: colorScheme.onBackground),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: Utils.modelBuilder(matrix, (x, value) => buildRow(x)),
          ),
          Center(
            child: Text(
              "Player ${lastMove == Players.X ? Players.O : Players.X}'s Turn",
              style: textTheme.headline6!
                  .copyWith(color: colorScheme.secondary),
            ),
          ),
        ],
      ),
    );
  }

  buildRow(int x) {
    final values = matrix[x];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Utils.modelBuilder(values, (y, value) => buildField(x, y)),
    );
  }

  buildField(int x, int y) {
    // Player
    final value = matrix[x][y];

    return Container(
      margin: EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: () => selectField(value, x, y),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(size, size),
          primary: getFieldColor(value),
        ),
        child: Text(
          value,
          style: TextStyle(fontSize: 42),
        ),
      ),
    );
  }

  selectField(String value, int x, int y) {
    if (value == Players.none) {
      final newValue = lastMove == Players.X ? Players.O : Players.X;
      setState(() {
        lastMove = newValue!;
        matrix[x][y] = newValue;
      });
    }

    if (isWinner(x, y)) {
      if (lastMove == Players.X)
        player1Score++;
      else if (lastMove == Players.O) player2Score++;

      showEndDialog("Player $lastMove Won!");
    } else if (isDrawGame()) {
      showEndDialog("Undecided Game");
    }
  }

  Color getFieldColor(String value) {
    if (value == Players.X) {
      return Color(0xffac89de);
    } else if (value == Players.O) {
      return Color(0xffc66088);
    } else {
      return colorScheme.brightness == Brightness.dark
          ? Colors.white24
          : Colors.white;
    }
  }

  getBackgroundColor() {
    final thisMove = lastMove == Players.X ? Players.O : Players.X;
    return getFieldColor(thisMove!).withAlpha(150);
  }

  Future showEndDialog(String title) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text("Would you like to play again or reset the score?"),
        actions: [
          TextButton(
            onPressed: () {
              setEmptyFields();
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Play Again"),
            ),
          ),
          TextButton(
            onPressed: () {
              setEmptyFields();
              resetScores();
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Reset Score"),
            ),
          ),
        ],
      ),
    );
  }

  bool isWinner(int x, int y) {
    int row = 0, col = 0, diag = 0, rdiag = 0;

    final player = matrix[x][y];
    final n = countMatrix;

    for (int i = 0; i < n; i++) {
      if (matrix[x][i] == player) row++;
      if (matrix[i][y] == player) col++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - i - 1] == player) rdiag++;
    }

    return row == n || col == n || diag == n || rdiag == n;
  }

  bool isDrawGame() =>
      matrix.every((row) => row.every((value) => value != Players.none));

  void resetScores() => setState(() => {player1Score = 0, player2Score = 0});
}
