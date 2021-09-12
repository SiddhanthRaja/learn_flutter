import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int total;

  Result(this.total);

  String get comment {
    var comm = "Yay, you won the game!";

    if (total <= 10) {
      comm = "You lost, better luck next time!";
    }

    return comm;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(comment + "\n\n" + "Your score is $total",
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.pink)),
    );
  }
}
