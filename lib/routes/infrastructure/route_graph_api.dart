import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/user/infrastructure/models/user_rating_model.dart';

class RouteGraphApi {
  List<UserRatingModel> getUserRatings({
    required ClimbType climbType,
    required List<RouteModel> unfilteredRoutes,
  }) {
    var routes = unfilteredRoutes
        .sortRoutes()
        .where((route) => route.climbType == climbType)
        .toList();

    if (climbType == ClimbType.boulder) {
      return _getBoulderRatingGraph(routes);
    }

    return _getYosemiteRatingGraph(routes);
  }

  List<UserRatingModel> _getBoulderRatingGraph(List<RouteModel> routes) {
    return BoulderRating.values.where((value) => value.isIncludedInGraph).map(
      (boulderRating) {
        var ratingRoutes = routes.where(
          (route) => route.boulderRating == boulderRating,
        );
        return UserRatingModel.withBoulder(
          boulderRating: boulderRating,
          unattempted: ratingRoutes
              .where((route) => route.isUnattempted)
              .length
              .toDouble(),
          inProgress: ratingRoutes
              .where((route) => route.isInProgress)
              .length
              .toDouble(),
          completed: ratingRoutes
              .where((route) => route.isCompleted)
              .length
              .toDouble(),
        );
      },
    ).toList();
  }

  List<UserRatingModel> _getYosemiteRatingGraph(List<RouteModel> routes) {
    return CondensedYosemiteRating.values
        .where((rating) => rating != CondensedYosemiteRating.speed)
        .map((yosemiteRating) {
      var ratingRoutes = routes.where(
        (route) => route.yosemiteRating!.condensedRating == yosemiteRating,
      );
      return UserRatingModel.withYosemite(
        yosemiteRating: yosemiteRating,
        unattempted: ratingRoutes
            .where((route) => route.isUnattempted)
            .length
            .toDouble(),
        inProgress:
            ratingRoutes.where((route) => route.isInProgress).length.toDouble(),
        completed:
            ratingRoutes.where((route) => route.isCompleted).length.toDouble(),
      );
    }).toList();
  }
}
