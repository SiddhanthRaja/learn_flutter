import 'dart:math';
import './displaycards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/cards.dart';
import 'package:learn_flutter/result.dart';

void main() {
  runApp(SidApp());
}

class SidApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SidAppState();
  }
}

class _SidAppState extends State<SidApp> {
  static const DECK = [
    '2h',
    '3h',
    '4h',
    '5h',
    '6h',
    '7h',
    '8h',
    '9h',
    '10h',
    'jh',
    'qh',
    'kh',
    'ah',
    '2d',
    '3d',
    '4d',
    '5d',
    '6d',
    '7d',
    '8d',
    '9d',
    '10d',
    'jd',
    'qd',
    'kd',
    'ad',
    '2c',
    '3c',
    '4c',
    '5c',
    '6c',
    '7c',
    '8c',
    '9c',
    '10c',
    'jc',
    'qc',
    'kc',
    'ac',
    '2s',
    '3s',
    '4s',
    '5s',
    '6s',
    '7s',
    '8s',
    '9s',
    '10s',
    'js',
    'qs',
    'ks',
    'as',
  ];

  static getRandomCards(List<String> deck, int numItems) {
    var rand = Random();
    List<String> dupDeck = deck.toList();
    List<String> randomList = [];

    for (int i = 0; i < numItems; i++) {
      int randIndex = rand.nextInt(dupDeck.length);

      randomList.add(dupDeck[randIndex]);
      dupDeck.removeAt(randIndex);
    }

    print(randomList);
    return randomList;
  }

  static roundMaker(int numRounds) {
    var quesList = [];
    for (int i = 0; i < numRounds; i++) {
      final List<String> roundCards = getRandomCards(DECK, 11) as List<String>;
      quesList.add(
        {
          "quesText": "Round $i",
          "tableCards": roundCards.sublist(0, 5),
          "options": [roundCards.sublist(5, 7), roundCards.sublist(7, 9)],
        },
      );
    }
    return quesList;
  }

  final _roundList = roundMaker(5);

  var _index = 0;
  var _total = 0;

  void changeQ(int score) {
    setState(() {
      _index = _index + 1;
      _total = _total + score;
    });
  }

  void reset() {
    setState(() {
      _index = 0;
      _total = 0;
    });
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              "Sid's App",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.deepOrange,
                backgroundColor: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: _index <= (_roundList.length - 1)
              ? (Cards(
                  changeQ,
                  new List<List<String>>.from(_roundList[_index]["options"]),
                  _roundList[_index]["tableCards"] as List<String>))
              : Result(_total, reset)),
    );
  }
}
