import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:tic_tac_emo/fancy_button.dart';
import 'package:tic_tac_emo/themes.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController player1EmoController =
      new TextEditingController();
  final TextEditingController player2EmoController =
      new TextEditingController();

  String player1 = '', player2 = '';

  late bool isLightTheme;

  @override
  void dispose() {
    player1EmoController.dispose();
    player2EmoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = ThemeProvider.themeOf(context).data;
    isLightTheme = appTheme.brightness == Brightness.dark ? false : true;
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
                  color: appTheme.colorScheme.onBackground,
                ),
                Switch(
                  activeColor: appTheme.colorScheme.primary,
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
                  color: appTheme.colorScheme.onBackground,
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: appTheme.colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text(
              '🙌 Tic Tac Emo 🙌'.toUpperCase(),
              style: appTheme.textTheme.headline3!
                  .copyWith(color: appTheme.colorScheme.onBackground),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Type Player Emoji 👇',
                    style: appTheme.textTheme.headline6!
                        .copyWith(color: appTheme.colorScheme.onBackground),
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
                      style: appTheme.textTheme.headline6!
                          .copyWith(color: appTheme.colorScheme.onBackground),
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
                                  "[\\s0-9a-zA-Z!@#\$%^&*()~`<>,./?'\"\\[\\]{}|\\\\-_=]"),
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
                              color: appTheme.colorScheme.primary,
                            ),
                          ),
                        ),
                        style: appTheme.textTheme.headline6,
                        cursorColor: appTheme.colorScheme.onBackground,
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
                      style: appTheme.textTheme.headline6!
                          .copyWith(color: appTheme.colorScheme.onBackground),
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
                                  "[\\s0-9a-zA-Z!@#\$%^&*()~`<>,./?'\"\\[\\]{}|\\\\-_=]"),
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
                              color: appTheme.colorScheme.primary,
                            ),
                          ),
                        ),
                        style: appTheme.textTheme.headline6,
                        cursorColor: appTheme.colorScheme.onBackground,
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
          FancyButton(
            formKey: _formKey,
            player1: player1,
            player2: player2,
          ),
        ],
      ),
    );
  }
}
