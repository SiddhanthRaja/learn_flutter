import 'package:flutter/material.dart';

class DisplayCards extends StatelessWidget {
  final List<String> displayList;

  DisplayCards(this.displayList);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle custom = ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        textStyle: TextStyle(fontSize: 20.0),
        shadowColor: Colors.pinkAccent);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: displayList.map(
        (choice) {
          return Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              child: Text(choice),
              style: custom,
              onPressed: null,
            ),
          );
        },
      ).toList(),
    );
  }
}
