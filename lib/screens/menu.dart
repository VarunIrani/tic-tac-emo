import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_emo/players.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text(
              '🙌 Tic Tac Emo 🙌'.toUpperCase(),
              style: TextStyle(fontSize: 32),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Type Player Emoji 👇',
                    style: TextStyle(fontSize: 22),
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
                      style: TextStyle(fontSize: 22),
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
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        style: TextStyle(fontSize: 22),
                        cursorColor: Colors.black,
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
                      style: TextStyle(fontSize: 22),
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
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        style: TextStyle(fontSize: 22),
                        cursorColor: Colors.black,
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
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
