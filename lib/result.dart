import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int total;
  final Function reset;

  Result(this.total, this.reset);

  String get comment {
    var comm = "Yay, you won the game!";

    if (total <= 0) {
      comm = "You lost, better luck next time!";
    }

    return comm;
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle custom = ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        textStyle: TextStyle(fontSize: 10.0),
        shadowColor: Colors.pinkAccent);

    return Column(
      children: [
        Center(
          child: Text(comment + "\n\n" + "Your score is $total",
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.pink)),
        ),
        ElevatedButton(
          child: Text("Restart Game"),
          style: custom,
          onPressed: () => reset(),
        ),
      ],
    );
  }
}
