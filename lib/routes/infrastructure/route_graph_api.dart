import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/user/infrastructure/models/user_rating_model.dart';
import 'package:free_beta/user/infrastructure/models/user_types_model.dart';

class RouteGraphApi {
  List<UserRatingModel> getUserRatings({
    required ClimbType climbType,
    required List<RouteModel> unfilteredRoutes,
    required bool includeGraphDetails,
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

  UserTypesModel getUserTypes({
    required List<RouteModel> unfilteredRoutes,
  }) {
    var routes = unfilteredRoutes.sortRoutes().toList();

    return UserTypesModel(
      total: routes.length,
      boulders:
          routes.where((route) => route.climbType == ClimbType.boulder).length,
      topRopes:
          routes.where((route) => route.climbType == ClimbType.topRope).length,
      autoBelays: routes
          .where((route) => route.climbType == ClimbType.autoBelay)
          .length,
      leads: routes.where((route) => route.climbType == ClimbType.lead).length,
    );
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
        .where((rating) => rating != CondensedYosemiteRating.speed)
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
