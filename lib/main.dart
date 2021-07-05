import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_emo/players.dart';
import 'package:tic_tac_emo/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Players.setPlayers("🎹", "😂");
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TicTacEmo(),
    ),
  );
}

class TicTacEmo extends StatefulWidget {
  @override
  _TicTacEmoState createState() => _TicTacEmoState();
}

class _TicTacEmoState extends State<TicTacEmo> {
  final int countMatrix = 3;
  final double size = 92;

  String lastMove = Players.none;
  late List<List<String>> matrix;

  @override
  void initState() {
    super.initState();
    setEmptyFields();
  }

  void setEmptyFields() => setState(() => matrix = List.generate(
      countMatrix, (_) => List.generate(countMatrix, (_) => Players.none)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: Utils.modelBuilder(matrix, (x, value) => buildRow(x)),
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
      final newValue = lastMove == Players.X ? Players.O: Players.X;
      setState(() {
        lastMove = newValue!;
        matrix[x][y] = newValue;
      });
    }
  }

  Color getFieldColor(String value) {
    if (value == Players.X) {
      return Colors.redAccent;
    } else if (value == Players.O) {
      return Colors.blueAccent;
    } else {
      return Colors.white;
    }
  }

  getBackgroundColor() {
    final thisMove = lastMove == Players.X ? Players.O : Players.X;
    return getFieldColor(thisMove!).withAlpha(150);
  }
}
