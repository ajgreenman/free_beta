import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';

class UserStatsModel {
  UserStatsModel._({
    required this.overall,
    required this.ropes,
    required this.boulders,
    required this.topRopes,
    required this.autoBelays,
    required this.leads,
  });

  final RouteStatsModel overall;
  final RouteStatsModel ropes;
  final RouteStatsModel boulders;
  final RouteStatsModel topRopes;
  final RouteStatsModel autoBelays;
  final RouteStatsModel leads;

  factory UserStatsModel.fromRouteList(List<RouteModel> routes) {
    var boulders =
        routes.where((route) => route.climbType == ClimbType.boulder).toList();
    var topRopes =
        routes.where((route) => route.climbType == ClimbType.topRope).toList();
    var autoBelays = routes
        .where((route) => route.climbType == ClimbType.autoBelay)
        .toList();
    var leads =
        routes.where((route) => route.climbType == ClimbType.lead).toList();

    return UserStatsModel._(
      overall: RouteStatsModel.fromRouteList(routes),
      ropes: RouteStatsModel.fromRouteList(topRopes + autoBelays + leads),
      boulders: RouteStatsModel.fromRouteList(boulders),
      topRopes: RouteStatsModel.fromRouteList(topRopes),
      autoBelays: RouteStatsModel.fromRouteList(autoBelays),
      leads: RouteStatsModel.fromRouteList(leads),
    );
  }

  RouteStatsModel getCombinedRouteModel(List<ClimbType> climbTypes) {
    List<RouteStatsModel> includedRouteStats = [];
    if (climbTypes.contains(ClimbType.topRope)) {
      includedRouteStats.add(topRopes);
    }
    if (climbTypes.contains(ClimbType.autoBelay)) {
      includedRouteStats.add(autoBelays);
    }
    if (climbTypes.contains(ClimbType.lead)) {
      includedRouteStats.add(leads);
    }
    return RouteStatsModel._(
      total: includedRouteStats.fold(0, (value, model) => value + model.total),
      attempted:
          includedRouteStats.fold(0, (value, model) => value + model.attempted),
      completed:
          includedRouteStats.fold(0, (value, model) => value + model.completed),
      favorited:
          includedRouteStats.fold(0, (value, model) => value + model.favorited),
      height:
          includedRouteStats.fold(0, (value, model) => value + model.height),
    );
  }
}

class RouteStatsModel {
  RouteStatsModel._({
    required this.total,
    required this.attempted,
    required this.completed,
    required this.favorited,
    required this.height,
  });

  final int total;
  final int attempted;
  final int completed;
  final int favorited;
  final int height;

  factory RouteStatsModel.fromRouteList(List<RouteModel> routes) {
    var attempted = routes
        .where((route) => route.userRouteModel?.isAttempted ?? false)
        .length;
    var completed = routes
        .where((route) => route.userRouteModel?.isCompleted ?? false)
        .length;
    var favorited = routes
        .where((route) => route.userRouteModel?.isFavorited ?? false)
        .length;

    var height = 0;
    routes.forEach((route) {
      if (route.userRouteModel?.isCompleted ?? false) {
        height += route.wallLocation.wallHeight;
      }
    });

    return RouteStatsModel._(
      total: routes.length,
      attempted: attempted,
      completed: completed,
      favorited: favorited,
      height: height,
    );
  }
}
