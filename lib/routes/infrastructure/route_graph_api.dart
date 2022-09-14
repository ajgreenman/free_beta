import 'package:charts_flutter/flutter.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/user/infrastructure/models/user_rating_model.dart';

class RouteGraphApi {
  List<Series<UserRatingModel, String>> getUserRatings({
    required ClimbType climbType,
    required List<RouteModel> unfilteredRoutes,
  }) {
    var routes = unfilteredRoutes
        .sortRoutes()
        .where((route) => route.climbType == climbType)
        .toList();

    if (climbType == ClimbType.boulder) return _getBoulderRatingGraph(routes);

    return [
      _createSeries(
        id: 'Unattempted',
        data: _getUserYosemiteRatings(routes, (route) => route.isUnattempted),
        color: RouteColor.red,
        domainFn: (userRatingModel, _) =>
            userRatingModel.yosemiteRating!.displayName,
      ),
      _createSeries(
        id: 'InProgress',
        data: _getUserYosemiteRatings(routes, (route) => route.isInProgress),
        color: RouteColor.yellow,
        domainFn: (userRatingModel, _) =>
            userRatingModel.yosemiteRating!.displayName,
      ),
      _createSeries(
        id: 'Completed',
        data: _getUserYosemiteRatings(routes, (route) => route.isCompleted),
        color: RouteColor.green,
        domainFn: (userRatingModel, _) =>
            userRatingModel.yosemiteRating!.displayName,
      ),
    ];
  }

  List<Series<UserRatingModel, String>> _getBoulderRatingGraph(
      List<RouteModel> routes) {
    return [
      _createSeries(
        id: 'Unattempted',
        data: _getUserBoulderRatings(routes, (route) => route.isUnattempted),
        color: RouteColor.red,
        domainFn: (userRatingModel, _) =>
            userRatingModel.boulderRating!.displayName,
      ),
      _createSeries(
        id: 'InProgress',
        data: _getUserBoulderRatings(routes, (route) => route.isInProgress),
        color: RouteColor.yellow,
        domainFn: (userRatingModel, _) =>
            userRatingModel.boulderRating!.displayName,
      ),
      _createSeries(
        id: 'Completed',
        data: _getUserBoulderRatings(routes, (route) => route.isCompleted),
        color: RouteColor.green,
        domainFn: (userRatingModel, _) =>
            userRatingModel.boulderRating!.displayName,
      ),
    ];
  }

  Series<UserRatingModel, String> _createSeries({
    required String id,
    required List<UserRatingModel> data,
    required RouteColor color,
    required String Function(UserRatingModel, int?) domainFn,
  }) {
    return Series<UserRatingModel, String>(
      id: id,
      data: data,
      domainFn: domainFn,
      measureFn: (userRatingModel, _) => userRatingModel.count,
      colorFn: (_, __) => ColorUtil.fromDartColor(
        color.displayColor.withOpacity(0.7),
      ),
    );
  }

  List<UserRatingModel> _getUserBoulderRatings(
    List<RouteModel> routes,
    bool Function(RouteModel) routeCondition,
  ) {
    return BoulderRating.values
        .where((value) => value.isIncludedInGraph)
        .map(
          (boulderRating) => UserRatingModel.withBoulder(
            boulderRating: boulderRating,
            count: routes
                .where((route) => route.boulderRating == boulderRating)
                .where(routeCondition)
                .length,
          ),
        )
        .toList();
  }

  List<UserRatingModel> _getUserYosemiteRatings(
    List<RouteModel> routes,
    bool Function(RouteModel) routeCondition,
  ) {
    return CondensedYosemiteRating.values
        .map(
          (yosemiteRating) => UserRatingModel.withYosemite(
            yosemiteRating: yosemiteRating,
            count: routes
                .where((route) =>
                    route.yosemiteRating!.condensedRating == yosemiteRating)
                .where(routeCondition)
                .length,
          ),
        )
        .toList();
  }
}
