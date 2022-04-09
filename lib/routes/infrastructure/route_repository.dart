import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_remote_data_provider.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:free_beta/user/infrastructure/user_api.dart';
import 'package:riverpod/riverpod.dart';

final routeRepository = Provider((ref) {
  return RouteRepository(
    routeRemoteDataProvider: ref.watch(routeRemoteDataProvider),
    user: ref.watch(authenticationProvider).whenOrNull<User?>(
          data: (user) => user,
        ),
  );
});

class RouteRepository {
  final RouteRemoteDataProvider routeRemoteDataProvider;
  final User? user;

  RouteRepository({
    required this.routeRemoteDataProvider,
    required this.user,
  });

  Future<UserStatsModel> getUserStats() async {
    var routes = await getRoutes();

    return UserStatsModel.fromRouteList(routes);
  }

  Future<List<RouteModel>> getRoutes() async {
    var routes = await routeRemoteDataProvider.getRoutes();

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

  Future<List<RouteModel>> getRemovedRoutes() async {
    var routes = await routeRemoteDataProvider.getRemovedRoutes();

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
