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
  runApp(
    ThemeProvider(
      themes: [
        MyAppThemes.lightTheme,
        MyAppThemes.darkTheme,
      ],
      defaultThemeId: MyAppThemes.lightThemeID,
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.themeOf(themeContext).data,
            routes: {
              '/': (_) => MainMenuScreen(),
              '/game': (_) => TicTacEmo(),
            },
            initialRoute: "/",
          ),
        ),
      ),
    ),
  );
}
