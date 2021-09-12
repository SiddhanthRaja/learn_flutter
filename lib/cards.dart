import 'package:flutter/material.dart';
import 'package:learn_flutter/answer.dart';

class Cards extends StatelessWidget {
  final Function changeQ;
  final List<Map> listOp;

  Cards(this.changeQ, this.listOp);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
//     ...listOp.map((choice) {
//       return Answer(
//         choice["opt"],
//             () => changeQ(choice["score"]),
//       );
//     }).toList(),
        for (var i in listOp.length)
    {
      return Answer(listOp[i]["opt"], () => listOp[i](choice["score"]),
      );
    }

    );
  }
}

