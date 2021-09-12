import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/cards.dart';
import 'package:learn_flutter/result.dart';
import './answer.dart';

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
  var _quesList = [
    {
      "quesText": "Q100",
      "options": [
        {"opt": "A", "score": 20},
        {"opt": "B", "score": 10},
        {"opt": "C", "score": 5}
      ]
    },
    {
      "quesText": "Q101",
      "options": [
        {"opt": "X", "score": 20},
        {"opt": "Y", "score": 10},
        {"opt": "Z", "score": 5}
      ]
    },
    {
      "quesText": "Q102",
      "options": [
        {"opt": "1", "score": 20},
        {"opt": "2", "score": 10},
        {"opt": "3", "score": 5}
      ]
    },
    {
      "quesText": "Q103",
      "options": [
        {"opt": "1", "score": 20},
        {"opt": "2", "score": 10},
        {"opt": "3", "score": 5}
      ]
    },
  ];

  var _index = 0;
  var _total = 0;

  changeQ(int score) {
    setState(() {
      _index = _index + 1;
      _total = _total + score;
    });
    print("I am Q" + _index.toString());
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    final List<Map> listOp =
        _quesList[_index]["options"] as List<Map<String, Object>>;

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Sid's App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.deepOrange,
                  backgroundColor: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
          body: _index <= (_quesList.length - 2)
              ? Cards(changeQ, listOp)
              : Result(_total)),
    );
  }
}
