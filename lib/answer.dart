import 'package:flutter/material.dart';

class Answer extends StatelessWidget {

  final Function pointer;

  Answer(this.pointer);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18.0 ,
      child:
      ElevatedButton(
        onPressed: () {
          print("I am op1");
          pointer;
        },
        child: Text("Opt 1"),
      ),


        );
  }
}
