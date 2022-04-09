import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';

class UserStatsModel {
  UserStatsModel._({
    required this.overall,
    required this.boulders,
    required this.topRopes,
    required this.autoBelays,
    required this.leads,
  });

  final RouteStatsModel overall;
  final RouteStatsModel boulders;
  final RouteStatsModel topRopes;
  final RouteStatsModel autoBelays;
  final RouteStatsModel leads;

  factory UserStatsModel.fromRouteList(List<RouteModel> routes) {
    var boulders =
        routes.where((route) => route.climbType == ClimbType.boulder);
    var topRopes =
        routes.where((route) => route.climbType == ClimbType.topRope);
    var autoBelays =
        routes.where((route) => route.climbType == ClimbType.autoBelay);
    var leads = routes.where((route) => route.climbType == ClimbType.lead);

    return UserStatsModel._(
      overall: RouteStatsModel.fromRouteList(routes),
      boulders: RouteStatsModel.fromRouteList(boulders),
      topRopes: RouteStatsModel.fromRouteList(topRopes),
      autoBelays: RouteStatsModel.fromRouteList(autoBelays),
      leads: RouteStatsModel.fromRouteList(leads),
    );
  }
}

class RouteStatsModel {
  RouteStatsModel._({
    required this.total,
    required this.attempted,
    required this.completed,
    required this.favorited,
  });

  final int total;
  final int attempted;
  final int completed;
  final int favorited;

  factory RouteStatsModel.fromRouteList(Iterable<RouteModel> routes) {
    var attempted = routes
        .where((route) => route.userRouteModel?.isAttempted ?? false)
        .length;
    var completed = routes
        .where((route) => route.userRouteModel?.isCompleted ?? false)
        .length;
    var favorited = routes
        .where((route) => route.userRouteModel?.isFavorited ?? false)
        .length;

    return RouteStatsModel._(
      total: routes.length,
      attempted: attempted,
      completed: completed,
      favorited: favorited,
    );
  }
}
