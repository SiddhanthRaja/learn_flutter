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
    print(option);
    final ButtonStyle custom = ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        textStyle: TextStyle(fontSize: 30.0),
        shadowColor: Colors.pinkAccent);

    return Row(children: [
      Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom: 20.0),
        margin: EdgeInsets.only(top: 40.0, right: 10.0),
        child: ElevatedButton(
          child: Text(option[0]),
          style: custom,
          onPressed: () => pointer(),
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom: 20.0),
        margin: EdgeInsets.only(top: 30.0, right: 0.0),
        child: ElevatedButton(
          child: Text(option[1]),
          style: custom,
          onPressed: () => pointer(),
        ),
      ),
    ]);
  }
}
