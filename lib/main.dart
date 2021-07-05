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
      backgroundColor: Colors.blue,
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
        onPressed: () {
          print("$x, $y");
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(size, size),
          primary: Colors.white,
        ),
        child: Text(
          value,
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
