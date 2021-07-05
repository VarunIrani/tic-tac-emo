import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_emo/screens/game.dart';
import 'package:tic_tac_emo/screens/menu.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) => MainMenuScreen(),
        '/game': (_) => TicTacEmo(),
      },
      initialRoute: "/",
    ),
  );
}
