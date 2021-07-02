import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:tic_tac_emo/screens/game.dart';
import 'package:tic_tac_emo/screens/menu.dart';
import 'package:tic_tac_emo/themes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themes: [
        MyAppThemes.lightTheme,
        MyAppThemes.darkTheme,
      ],
      defaultThemeId: MyAppThemes.darkThemeID,
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            title: 'Tic Tac Toe',
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            theme: ThemeProvider.themeOf(themeContext).data,
            routes: {
              '/': (context) => MenuScreen(),
              '/game': (context) => GameScreen(),
            },
          ),
        ),
      ),
    );
  }
}
