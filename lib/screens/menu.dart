import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:tic_tac_emo/players.dart';
import 'package:tic_tac_emo/themes.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final TextEditingController player1EmoController =
      new TextEditingController();
  final TextEditingController player2EmoController =
      new TextEditingController();

  String player1 = '', player2 = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    player1EmoController.dispose();
    player2EmoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        ThemeProvider.themeOf(context).data.colorScheme;
    final TextTheme textTheme = ThemeProvider.themeOf(context).data.textTheme;
    bool isLightTheme = colorScheme.brightness == Brightness.light;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                Icon(
                  Icons.dark_mode,
                  color: colorScheme.onBackground,
                ),
                Switch(
                  activeColor: colorScheme.primary,
                  value: isLightTheme,
                  onChanged: (bool value) {
                    if (isLightTheme)
                      ThemeProvider.controllerOf(context)
                          .setTheme(MyAppThemes.darkThemeID);
                    else
                      ThemeProvider.controllerOf(context)
                          .setTheme(MyAppThemes.lightThemeID);

                    isLightTheme = !isLightTheme;
                  },
                ),
                Icon(
                  Icons.brightness_7,
                  color: colorScheme.onBackground,
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text(
              '🙌 Tic Tac Emo 🙌'.toUpperCase(),
              style: textTheme.headline4!.copyWith(
                color: colorScheme.onBackground,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Type Player Emoji 👇',
                    style: textTheme.headline5!.copyWith(
                      color: colorScheme.onBackground,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Player 1',
                      style: textTheme.headline6!.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              RegExp(
                                  "[\\s0-9a-zA-Z!@#\$%^&*()~`<>,./?'\"\\[\\]{}|\\\\-_=:;]"),
                              replacementString: '')
                        ],
                        onChanged: (value) {
                          setState(() {
                            player1 = value;
                          });
                        },
                        controller: player1EmoController,
                        decoration: new InputDecoration(
                          enabledBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                              color: colorScheme.onBackground,
                            ),
                          ),
                        ),
                        style: textTheme.headline6!.copyWith(
                          color: colorScheme.brightness == Brightness.light
                              ? Colors.black
                              : Colors.white,
                        ),
                        cursorColor: colorScheme.primary,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Player Emo';
                          } else if (value == player2) {
                            return 'Emo should be different';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Player 2',
                      style: textTheme.headline6!.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              RegExp(
                                  "[\\s0-9a-zA-Z!@#\$%^&*()~`<>,./?'\"\\[\\]{}|\\\\-_=;:]"),
                              replacementString: '')
                        ],
                        onChanged: (value) {
                          setState(() {
                            player2 = value;
                          });
                        },
                        controller: player2EmoController,
                        decoration: new InputDecoration(
                          enabledBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                              color: colorScheme.onBackground,
                            ),
                          ),
                        ),
                        style: textTheme.headline6!.copyWith(
                          color: colorScheme.onSurface,
                        ),
                        cursorColor: colorScheme.primary,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Player Emo';
                          } else if (value == player1) {
                            return 'Emo should be different';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Players.setPlayers(player1, player2);
                Navigator.popAndPushNamed(context, "/game");
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Start Game",
                style: textTheme.headline6!.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
