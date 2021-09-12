import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function pointer;
  final String option;

  Answer(
    this.option,
    this.pointer,
  );

  @override
  Widget build(BuildContext context) {
    final ButtonStyle custom = ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        textStyle: TextStyle(fontSize: 125.0),
        shadowColor: Colors.pinkAccent);
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 40.0),
      child: ElevatedButton(
        child: Text(option),
        style: custom,
        onPressed: () => pointer(),
      ),
    );
  }
}
