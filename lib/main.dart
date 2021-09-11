import 'package:flutter/material.dart';
import 'package:learn_flutter/questions.dart';

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
  var _quesList = ["Q100","Q101","Q103"];

  var _index = 0;



  changeQ(){
    setState((){_index = _index+1; });
    print("I am Q" + _index.toString());
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Sid's App",style: TextStyle(color: Colors.deepOrange, backgroundColor: Colors.greenAccent) ),),
        body: Column(
            children: [
            Question(_quesList[_index], ),
            ElevatedButton(
              onPressed: () {
                print("I am op1");
                    changeQ();
              },
              child: Text("Opt 1"),),
            ElevatedButton(onPressed: () {
              print("I am op2");
              changeQ();
            },
              child: Text("Opt 2"),)
            ]),
      ),


    );
  }
}