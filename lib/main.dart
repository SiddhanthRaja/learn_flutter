import 'package:flutter/material.dart';
import 'package:learn_flutter/questions.dart';
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


class _SidAppState extends State<SidApp>{
  var _quesList = [
    {"quesText": "Q100", "options" : [
        {"opt":"A", "score":20},{"opt":"B", "score":10},{"opt":"C", "score":5},{"opt":"D", "score":2}]  },
    {"quesText": "Q101", "options" : [
      {"opt":"X", "score":20},{"opt":"Y", "score":10},{"opt":"Z", "score":5},{"opt":"W", "score":2}]  },
    {"quesText": "Q102", "options" : [
      {"opt":"1", "score":20},{"opt":"2", "score":10},{"opt":"3", "score":5},{"opt":"4", "score":2}]  },
  ];

  var _index = 0;
  var _total = 0;


  changeQ(int score){
    setState(()
    {_index = _index+1;
    _total = _total + score;
    });
    print("I am Q" + _index.toString());
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    final List<Map> listOp = _quesList[_index]["options"] as List<Map>;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Sid's App",style: TextStyle(color: Colors.deepOrange, backgroundColor: Colors.greenAccent) ),),
        body: _index<= (_quesList.length -2) ? Column(
          children: [

            Question(_quesList[_index]["quesText"] as String ),

            Answer(listOp[0]["opt"],() => changeQ(listOp[0]["score"]) ,),
            Answer(listOp[1]["opt"],() => changeQ(listOp[1]["score"]) ,),
            Answer(listOp[2]["opt"],() => changeQ(listOp[2]["score"]) ,),
            Answer(listOp[3]["opt"],() => {_total += (listOp[3]["score"]) as int }),


            ]) : Center(child: Text("You have completed the Quiz\n\n" + "Your score is $_total"),)

      ),


    );

  }
}