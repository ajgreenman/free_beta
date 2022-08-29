import 'package:free_beta/app/enums/enums.dart';

class UserRatingModel {
  UserRatingModel.withBoulder({
    required this.boulderRating,
    required this.count,
  }) : yosemiteRating = null;

  UserRatingModel.withYosemite({
    required this.yosemiteRating,
    required this.count,
  }) : boulderRating = null;

  final BoulderRating? boulderRating;
  final CondensedYosemiteRating? yosemiteRating;
  final int count;
}
