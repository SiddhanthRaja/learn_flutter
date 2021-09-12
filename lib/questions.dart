import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String quesText;

  Question(this.quesText)

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(40.0),
      child: Text(
        quesText,
        style: TextStyle(
            fontSize: 40.0,
            color: Colors.limeAccent,
            backgroundColor: Colors.black54),
        textAlign: TextAlign.center,
      ),
    );
  }
}
