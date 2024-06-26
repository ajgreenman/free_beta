import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/user/infrastructure/models/user_rating_model.dart';

class RouteGraphApi {
  List<UserRatingModel> getBoulderUserRatings({
    required List<RouteModel> unfilteredRoutes,
  }) {
    var routes = unfilteredRoutes
        .sortRoutes()
        .where((route) => route.climbType == ClimbType.boulder)
        .toList();

    return _getBoulderRatingGraph(routes);
  }

  List<UserRatingModel> getRopeUserRatings({
    required List<ClimbType> climbTypes,
    required List<RouteModel> unfilteredRoutes,
  }) {
    var routes = unfilteredRoutes
        .sortRoutes()
        .where((route) => climbTypes.contains(route.climbType))
        .toList();

    return _getYosemiteRatingGraph(routes);
  }

  List<UserRatingModel> _getBoulderRatingGraph(List<RouteModel> routes) {
    return BoulderRating.values.where((value) => value.isIncludedInGraph).map(
      (boulderRating) {
        var ratingRoutes = routes.where(
          (route) => route.boulderRating == boulderRating,
        );
        return UserRatingModel.withBoulder(
          boulderUserRatingModel: BoulderUserRatingModel(
            boulderRating: boulderRating,
            userProgressModel:
                UserProgressModel.fromRoutes(routes: ratingRoutes),
          ),
        );
      },
    ).toList();
  }

  List<UserRatingModel> _getYosemiteRatingGraph(
    List<RouteModel> routes,
  ) {
    return CondensedYosemiteRating.values
        .where((rating) => rating.isIncludedInGraph)
        .map((condensedYosemiteRating) {
      var ratingRoutes = routes.where(
        (route) =>
            route.yosemiteRating!.condensedRating == condensedYosemiteRating,
      );
      return UserRatingModel.withYosemite(
        yosemiteUserRatingModel: YosemiteUserRatingModel(
          condensedYosemiteRating: condensedYosemiteRating,
          userProgressModel: UserProgressModel.fromRoutes(routes: ratingRoutes),
          detailedUserProgressModels: condensedYosemiteRating.uncondensedRatings
              .map(
                (yosemiteRating) => DetailedYosemiteUserRatingModel(
                  yosemiteRating: yosemiteRating,
                  userProgressModel: UserProgressModel.fromRoutes(
                    routes: ratingRoutes.where(
                        (route) => route.yosemiteRating! == yosemiteRating),
                  ),
                ),
              )
              .toList(),
        ),
      );
    }).toList();
  }
}
