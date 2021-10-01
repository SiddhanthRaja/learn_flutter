import 'dart:math';
import 'package:trotter/trotter.dart';

///
/// Based on solutions from https://rosettacode.org/wiki/Poker_hand_analyser#JavaScript
///
/// A faster and weird implementation is here
///   https://www.codeproject.com/Articles/569271/A-Poker-hand-analyzer-in-JavaScript-using-bit-math
///   https://knowles.co.za/analyzing-a-poker-hand-analyzer/
///   https://www.codeproject.com/Tips/1068755/Quick-card-Poker-Ranking-in-Java
///
/// Check this for future purposes if performance is an issue
///
/// But this simple one seems to be fast enough for now
///
class PokerHandDetector {
  static const FACES = [
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    'j',
    'q',
    'k',
    'a'
  ];
  static const SUITS = ['h', 'd', 'c', 's'];

  /// ["ah", "3c", "2d", "js", "jd"]
  static PokerHand detectHand(List<String> hand) {
    // print("--hand--");
    // print(hand);
    final List<String> cards = List<String>.from(hand)
      ..retainWhere((card) => card != 'joker');
    int jokerCount = hand.length - cards.length;

    final List<int> faces = cards
        .map(
            (c) => c == null ? -1 : FACES.indexOf(c.substring(0, c.length - 1)))
        .toList();
    final List<int> suits = cards
        .map((c) => c == null ? -1 : SUITS.indexOf(c.substring(c.length - 1)))
        .toList();

    if (cards.toSet().length != cards.length ||
        faces.contains(-1) ||
        suits.contains(-1)) {
      return PokerHand(PokerHandType.INVALID, [], []);
    }

    // print("faces = $faces");
    // print("suits = $suits");

    bool flush = suits.toSet().length == 1;
    List<GroupRank> groupsData = _computeGroups(faces);

//    List<int> groups = groupsData[0];
//    List<int> groupRanks = groupsData[1];

    // calculating straight. shifted accounts for the low a, 2, 3, 4, 5 straight
    List<int> shifted = faces.map((x) => (x + 1) % 13).toList();
    int faceDistance = faces.reduce(max) - faces.reduce(min);
    int shiftedFaceDistance = shifted.reduce(max) - shifted.reduce(min);
    int distance = min(faceDistance, shiftedFaceDistance);
    bool straight = groupsData[0].groupSize == 1 && distance < 5;

    groupsData[0].groupSize += jokerCount;

    PokerHandType pokerHandType;

    if (groupsData[0].groupSize == 5)
      pokerHandType = PokerHandType.FIVE_OF_A_KIND;
    else if (straight && flush)
      pokerHandType = PokerHandType.STRAIGHT_FLUSH;
    else if (groupsData[0].groupSize == 4)
      pokerHandType = PokerHandType.FOUR_OF_A_KIND;
    else if (groupsData[0].groupSize == 3 && groupsData[1].groupSize == 2)
      pokerHandType = PokerHandType.FULL_HOUSE;
    else if (flush)
      pokerHandType = PokerHandType.FLUSH;
    else if (straight)
      pokerHandType = PokerHandType.STRAIGHT;
    else if (groupsData[0].groupSize == 3)
      pokerHandType = PokerHandType.THREE_OF_A_KIND;
    else if (groupsData[0].groupSize == 2 && groupsData[1].groupSize == 2)
      pokerHandType = PokerHandType.TWO_PAIR;
    else if (groupsData[0].groupSize == 2)
      pokerHandType = PokerHandType.PAIR;
    else
      pokerHandType = PokerHandType.HIGH_CARD;

    // print(pokerHandType);

    return PokerHand(pokerHandType, groupsData, hand);
  }

  static List<GroupRank> _computeGroups(List<int> facesOriginal) {
    List<int> faces = List<int>.from(facesOriginal)..sort();
    List<GroupRank> groupRanks = [];

    int? prevX;
    int groupCounter = 0;

    for (var i = 0; i < faces.length; ++i) {
      var x = faces[i];

      if (prevX == null) {
        // first card
        groupCounter++;
      } else if (prevX != x) {
        // till last card
        groupRanks.add(GroupRank(groupCounter, prevX));
        groupCounter = 1;
      } else {
        // till last card
        groupCounter++;
      }

      // last iteration
      if (faces.length == i + 1) {
        groupRanks.add(GroupRank(groupCounter, x));
      }

      prevX = x;
    }
    groupRanks.sort();
    var groupsReversed = groupRanks.reversed.toList();

    // print("groups = $groupsReversed");

    return groupsReversed;
  }

  static PokerHand bestHandNoLimits(
      List<String> tableCards, List<String> playerCards) {
    // print("finding best hand in $cards");
    List<String> cards = [...tableCards, ...playerCards];
    Combinations<String> combos = Combinations(5, cards);
    PokerHand? bestHand;

    for (var combo in combos()) {
      var detectedHand = PokerHandDetector.detectHand(combo);
      if (bestHand == null) {
        bestHand = detectedHand;
      } else {
        if (detectedHand.compareTo(bestHand) > 0) {
          bestHand = detectedHand;
        }
      }
    }

    return bestHand!;
  }
}

class PokerHand implements Comparable<PokerHand> {
  final PokerHandType type;
  final List<GroupRank> groupRanks;
  final List<String> cards;

  String? tag;

  PokerHand(this.type, this.groupRanks, this.cards, {this.tag});

  @override
  String toString() {
    return '$type | groupRanks: $groupRanks | cards: $cards${tag == null ? "" : " | tag $tag"}';
  }

  @override
  int compareTo(PokerHand other) {
    if (other == null) return 1;
    if (type.strength > other.type.strength) {
      return 1;
    } else if (other.type.strength > type.strength) {
      return -1;
    }

    // hand strength is equal, compare card ranks
    if (type == PokerHandType.STRAIGHT) {
      // handle special case in STRAIGHT
      // 6, 5, 4, 3, 2 is better than 5, 4, 3, 2, a but worse than 10, j, q, k, a
      //
      // the respective groupRanks look
      //  6, 5, 4, 3, 2          5, 4, 3, 2, a             10, j, q, k, a
      //     ||                       ||                        ||
      //     \/                       \/                        \/
      // [4, 3, 2, 1, 0]        [12, 3, 2, 1, 0]          [12, 11, 10, 9, 8]
      //
      // so [4, 3, 2, 1, 0] and [12, 3, 2, 1, 0]
      // [12, 3, 2, 1, 0] is the lowest straight always!
      //
      // BUT [12, 11, 10, 9, 8] is the highest.
      //
      // since 12 is bigger, by default our logic will incorrectly guess this straight as bigger.. always.
      // instead, there is only one exception when 12 is bigger.. that is when it is followed by 11
      if (this.isLowestStraight || other.isLowestStraight) {
        if (this.isLowestStraight && !other.isLowestStraight) {
          return -1;
        } else if (!this.isLowestStraight && other.isLowestStraight) {
          return 1;
        } else {
          return 0;
        }
      }
    }
    for (var i = 0; i < groupRanks.length; ++i) {
      int selfGroupRank = groupRanks[i].rank;
      int otherGroupRank = other.groupRanks[i].rank;

      if (selfGroupRank > otherGroupRank) {
        return 1;
      } else if (otherGroupRank > selfGroupRank) {
        return -1;
      }
    }

    return 0;
  }

  bool get isLowestStraight =>
      this.groupRanks[0].rank == 12 && this.groupRanks[1].rank == 3;
}

class PokerHandType {
  final String name;
  final int strength;

  const PokerHandType(this.name, this.strength);

  static const PokerHandType FIVE_OF_A_KIND = PokerHandType('5 of a Kind', 100);
  static const PokerHandType STRAIGHT_FLUSH =
      PokerHandType('Straight Flush', 80);
  static const PokerHandType FOUR_OF_A_KIND = PokerHandType('4 of a Kind', 70);
  static const PokerHandType FULL_HOUSE = PokerHandType('Full House', 60);
  static const PokerHandType FLUSH = PokerHandType('Flush', 50);
  static const PokerHandType STRAIGHT = PokerHandType('Straight', 40);
  static const PokerHandType THREE_OF_A_KIND = PokerHandType('3 of a Kind', 30);
  static const PokerHandType TWO_PAIR = PokerHandType('Two Pair', 20);
  static const PokerHandType PAIR = PokerHandType('Pair', 10);
  static const PokerHandType HIGH_CARD = PokerHandType('High Card', 0);
  static const PokerHandType INVALID = PokerHandType('Invalid', -1);

  @override
  String toString() {
    return 'PokerHand{type: $name, rank: $strength}';
  }
}

class GroupRank implements Comparable<GroupRank> {
  int groupSize;
  int rank;

  GroupRank(this.groupSize, this.rank);

  @override
  int compareTo(GroupRank other) {
    if (other == null) return 1;
    if (groupSize > other.groupSize) {
      return 1;
    } else if (other.groupSize > groupSize) {
      return -1;
    } else {
      if (rank > other.rank) {
        return 1;
      } else if (other.rank > rank) {
        return -1;
      }
    }
    return 0;
  }

  @override
  String toString() {
    return "{$groupSize x ${PokerHandDetector.FACES[rank]}}";
  }

  static bool doesGroupListContainRank(List<GroupRank> groupRanks, int rank) {
    if (groupRanks == null) {
      return false;
    }
    for (var gr in groupRanks) {
      if (gr.rank == rank) {
        return true;
      }
    }
    return false;
  }
}
