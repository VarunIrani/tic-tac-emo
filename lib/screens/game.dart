import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:tic_tac_toe/utils.dart';

import 'package:tic_tac_toe/players.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static final countMatrix = 3;
  static final double size = 92;
  late List<List<String>> matrix;
  int playerXScore = 0;
  int playerOScore = 0;

  String lastMove = Players.none;

  @override
  void initState() {
    super.initState();
    setEmptyFields();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = ThemeProvider.themeOf(context).data;
    return Scaffold(
      backgroundColor: appTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "🙌 Tic Tac Emo 🙌".toUpperCase(),
          style: TextStyle(
            color: appTheme.colorScheme.onBackground,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.colorScheme.onBackground,
          ),
          onPressed: () {
            Navigator.of(context).popAndPushNamed('/');
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Score',
                style: appTheme.textTheme.headline4!.copyWith(color: appTheme.colorScheme.onBackground),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Player ${Players.X}",
                        style: appTheme.textTheme.headline5!.copyWith(color: appTheme.colorScheme.onBackground),
                      ),
                      Text(
                        playerXScore.toString(),
                        style: appTheme.textTheme.headline5!.copyWith(color: appTheme.colorScheme.onBackground),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Player ${Players.O}",
                        style: appTheme.textTheme.headline5!.copyWith(color: appTheme.colorScheme.onBackground),
                      ),
                      Text(
                        playerOScore.toString(),
                        style: appTheme.textTheme.headline5!.copyWith(color: appTheme.colorScheme.onBackground),
                      ),
                    ],
                  ),
                ],
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: Utils.modelBuilder(matrix, (x, value) => buildRow(x)),
          ),
          Row(
            children: [
              Text(
                "Player ${lastMove == Players.X ? Players.O : Players.X}'s Turn",
                style: appTheme.textTheme.headline6!.copyWith(color: appTheme.colorScheme.onBackground),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }

  void setEmptyFields() => setState(
        () => matrix = List.generate(
          countMatrix,
          (_) => List.generate(countMatrix, (_) => Players.none),
        ),
      );

  Widget buildRow(int x) {
    final values = matrix[x];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Utils.modelBuilder(values, (y, value) => buildField(x, y)),
    );
  }

  Widget buildField(int x, int y) {
    final value = matrix[x][y];
    Color color = getFieldColor(value);
    return Container(
      margin: EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          minimumSize: Size(size, size),
        ),
        onPressed: () => selectField(value, x, y),
        child: Text(
          value,
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }

  Color getFieldColor(String value) {
    if (value == Players.X) {
      return Color(0xffac89de);
    } else if (value == Players.O) {
      return Color(0xffc66088);
    } else {
      return Colors.white;
    }
  }

  Color getBackgroundColor() {
    final thisMove = lastMove == Players.X ? Players.O : Players.X;
    return getFieldColor(thisMove!).withAlpha(150);
  }

  void selectField(String value, int x, int y) {
    if (value == Players.none) {
      final newValue = lastMove == Players.X ? Players.O : Players.X;
      setState(() {
        lastMove = newValue!;
        matrix[x][y] = newValue;
      });

      if (isWinner(x, y)) {
        newValue == Players.X ? playerXScore++ : playerOScore++;
        showEndDialog('Player $newValue Won!');
      } else if (isEnd()) {
        showEndDialog('Undecided Game');
      }
    }
  }

  Future showEndDialog(String title) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(title),
          content:
              Text('Would you like to reset the score or continue playing?'),
          actions: [
            TextButton(
              onPressed: () {
                setEmptyFields();
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Play Again',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setEmptyFields();
                playerXScore = 0;
                playerOScore = 0;
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Reset Score',
                ),
              ),
            )
          ],
        ),
      );

  bool isWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rDiag = 0;
    final player = matrix[x][y];
    final n = countMatrix;

    for (int i = 0; i < n; i++) {
      if (matrix[x][i] == player) col++;
      if (matrix[i][y] == player) row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - i - 1] == player) rDiag++;
    }

    return col == n || row == n || diag == n || rDiag == n;
  }

  bool isEnd() =>
      matrix.every((row) => row.every((value) => value != Players.none));
}
