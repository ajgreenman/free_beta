import 'package:collection/collection.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_remote_data_provider.dart';
import 'package:free_beta/user/infrastructure/models/user_model.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';

enum RouteType {
  active,
  inactive,
  all,
}

class RouteRepository {
  final RouteRemoteDataProvider routeRemoteDataProvider;
  final UserModel? user;

  RouteRepository({
    required this.routeRemoteDataProvider,
    required this.user,
  });

  Future<UserStatsModel> getUserStats(RouteType routeType) async {
    var routes = await getRoutes(routeType);

    return UserStatsModel.fromRouteList(routes);
  }

  Future<List<RouteModel>> getRoutes(RouteType routeType) async {
    List<RouteModel> routes;
    switch (routeType) {
      case RouteType.active:
        routes = await routeRemoteDataProvider.getActiveRoutes();
        break;
      case RouteType.inactive:
        routes = await routeRemoteDataProvider.getRemovedRoutes();
        break;
      case RouteType.all:
        routes = await routeRemoteDataProvider.getAllRoutes();
        break;
    }

    if (user != null) {
      var userRoutes = await routeRemoteDataProvider.getUserRoutes(user!.uid);

      userRoutes.forEach((userRoute) {
        var route = routes.firstWhereOrNull(
          (route) => route.id == userRoute.routeId,
        );
        if (route == null) return;

        route.userRouteModel = userRoute;
      });
    }

    return routes.where((route) => !route.isDeleted).toList();
  }

  Future<void> saveRoute(UserRouteModel userRouteModel) async {
    await routeRemoteDataProvider.saveUserRoute(userRouteModel);
  }

  Future<void> addRoute(RouteFormModel routeFormModel) async {
    await routeRemoteDataProvider.addRoute(routeFormModel);
  }

  Future<void> updateRoute(
    RouteModel routeModel,
    RouteFormModel routeFormModel,
  ) async {
    await routeRemoteDataProvider.updateRoute(
      routeModel,
      routeFormModel,
    );
  }

  Future<void> deleteRoute(
    RouteModel routeModel,
  ) async {
    await routeRemoteDataProvider.deleteRoute(
      routeModel,
    );
  }
}
