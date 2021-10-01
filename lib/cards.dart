import 'package:flutter/material.dart';
import 'package:learn_flutter/answer.dart';
import './hand_detector.dart';
import './displaycards.dart';

class Cards extends StatelessWidget {
  final Function changeQ;
  final List<List<String>> listOp;
  final List<String> tableCards;

  Cards(this.changeQ, this.listOp, this.tableCards);

  Widget build(BuildContext context) {
    print(listOp);
    return Column(
      children: [
        DisplayCards(tableCards),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: listOp.map(
              (choice) {
                return Answer(choice, () => changeQ(isCorrect(choice)));
              },
            ).toList()),
      ],
    );
  }

  int isCorrect(List<String> playerCards) {
    final List<String> hand = playerCards + tableCards;
    final PokerHand chosenBestHand =
        PokerHandDetector.bestHandNoLimits(tableCards, playerCards);
    final PokerHand otherBestHand = PokerHandDetector.bestHandNoLimits(
        tableCards, listOp[0] != playerCards ? listOp[0] : listOp[1]);

    if (chosenBestHand.compareTo(otherBestHand) > 0) {
      return 1;
    } else {
      return 0;
    }
  }
}
