import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(TicTacEmo());
}

class TicTacEmo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
