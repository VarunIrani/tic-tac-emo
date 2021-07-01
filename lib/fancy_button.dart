import 'package:flutter/material.dart';
import 'package:tic_tac_toe/players.dart';

class FancyButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String player1;
  final String player2;

  const FancyButton({
    Key? key,
    required this.formKey,
    required this.player1,
    required this.player2,
  }) : super(key: key);

  @override
  _FancyButtonState createState() => _FancyButtonState();
}

class _FancyButtonState extends State<FancyButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: (details) {
        _controller.reverse();
        if (widget.formKey.currentState!.validate()) {
          Navigator.of(context).popAndPushNamed("/game");
          print("${widget.player1} ${widget.player2}");
          Players.setPlayers(widget.player1, widget.player2);
        }
      },
      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            boxShadow: [
              BoxShadow(
                color: Color(0x80000000),
                blurRadius: 12.0,
                offset: Offset(0.0, 5.0),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffac89de),
                Color(0xffc66088),
              ],
            ),
          ),
          child: Center(
            child: Text(
              'Start Game',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
