import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function pointer;
  final List<String> option;

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

    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom: 40.0),
        child: ElevatedButton(
          child: Text(option[0]),
          style: custom,
          onPressed: () => pointer(),
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom: 40.0),
        child: ElevatedButton(
          child: Text(option[1]),
          style: custom,
          onPressed: () => pointer(),
        ),
      ),
    ]);


  }
}
