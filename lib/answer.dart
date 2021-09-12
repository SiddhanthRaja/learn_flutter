import 'package:flutter/material.dart';

class Answer extends StatelessWidget {

  final Function pointer;
  final String option;

  Answer(this.option,this.pointer);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle custom = ElevatedButton.styleFrom(onPrimary: Colors.white, textStyle: TextStyle(fontSize: 25.0),shadowColor: Colors.pinkAccent);
    return Container(
      width: double.infinity ,
      child:
      ElevatedButton(

          child: Text(option),
          style: custom,
          onPressed: () => pointer(),



      ),


        );
  }
}
