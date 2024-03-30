import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';

void main() {
  test('condensed rating returns correct value', () {
    expect(
      YosemiteRating.six.condensedRating,
      CondensedYosemiteRating.six,
    );
    expect(
      YosemiteRating.seven.condensedRating,
      CondensedYosemiteRating.seven,
    );
    expect(
      YosemiteRating.eight.condensedRating,
      CondensedYosemiteRating.eight,
    );
    expect(
      YosemiteRating.ninePlus.condensedRating,
      CondensedYosemiteRating.nine,
    );
    expect(
      YosemiteRating.tenPlus.condensedRating,
      CondensedYosemiteRating.ten,
    );
    expect(
      YosemiteRating.elevenPlus.condensedRating,
      CondensedYosemiteRating.eleven,
    );
    expect(
      YosemiteRating.twelvePlus.condensedRating,
      CondensedYosemiteRating.twelve,
    );
    expect(
      YosemiteRating.thirteenPlus.condensedRating,
      CondensedYosemiteRating.thirteen,
    );
    expect(
      YosemiteRating.speed.condensedRating,
      CondensedYosemiteRating.speed,
    );
    expect(
      YosemiteRating.consensus.condensedRating,
      CondensedYosemiteRating.consensus,
    );
    expect(
      YosemiteRating.competition.condensedRating,
      CondensedYosemiteRating.competition,
    );
  });
}
