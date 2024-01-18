import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/user/infrastructure/models/user_rating_model.dart';

extension UserRatingModelListExtensions on List<UserRatingModel> {
  List<BoulderUserRatingModel> get boulderRatings => this
      .where((element) => element.boulderUserRatingModel != null)
      .map((e) => e.boulderUserRatingModel!)
      .toList();

  List<YosemiteUserRatingModel> get yosemiteRatings => this
      .where((element) => element.yosemiteUserRatingModel != null)
      .map((e) => e.yosemiteUserRatingModel!)
      .toList();

  UserProgressModel getProgressModel(ClimbType climbType) {
    if (climbType == ClimbType.boulder) {
      return _boulderProgress;
    }

    return _yosemiteProgress;
  }

  UserProgressModel get _boulderProgress => UserProgressModel(
        unattempted: _unattemptedBoulders,
        inProgress: _inProgressBoulders,
        completed: _completedBoulders,
      );

  UserProgressModel get _yosemiteProgress => UserProgressModel(
        unattempted: _unattemptedYosemites,
        inProgress: _inProgressYosemites,
        completed: _completedYosemites,
      );

  double get _unattemptedBoulders => boulderRatings.fold<double>(
        0.0,
        (previousValue, element) =>
            previousValue + element.userProgressModel.unattempted,
      );

  double get _inProgressBoulders => boulderRatings.fold<double>(
        0.0,
        (previousValue, element) =>
            previousValue + element.userProgressModel.inProgress,
      );

  double get _completedBoulders => boulderRatings.fold<double>(
        0.0,
        (previousValue, element) =>
            previousValue + element.userProgressModel.completed,
      );

  double get _unattemptedYosemites => yosemiteRatings.fold<double>(
        0.0,
        (previousValue, element) =>
            previousValue + element.userProgressModel.unattempted,
      );

  double get _inProgressYosemites => yosemiteRatings.fold<double>(
        0.0,
        (previousValue, element) =>
            previousValue + element.userProgressModel.inProgress,
      );

  double get _completedYosemites => yosemiteRatings.fold<double>(
        0.0,
        (previousValue, element) =>
            previousValue + element.userProgressModel.completed,
      );
}
