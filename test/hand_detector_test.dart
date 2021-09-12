import 'package:learn_flutter/hand_detector.dart';
import 'package:test/test.dart';
import 'package:trotter/trotter.dart';

void main() {
  test('test hand detection', () {
    expect(PokerHandDetector.detectHand(["2h", "2d", "2s", "ks", "qd"]).type, PokerHandType.THREE_OF_A_KIND);
    expect(PokerHandDetector.detectHand(["2h", "2d", "2s", "ks", "kd"]).type, PokerHandType.FULL_HOUSE);
  });

  test('compare hands', () {
    var cards1 = ["3d", "4s", "5d", "jd", "2c"];
    var cards2 = ["3d", "4d", "5d", "jd", "2d"];

    PokerHand hand1 = PokerHandDetector.detectHand(cards1);
    PokerHand hand2 = PokerHandDetector.detectHand(cards2);

    print(hand1);
    print(hand2);

    print("is hand1 better than hand2 = ${hand1.compareTo(hand2) > 0}");
  });

}
