import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_local_data_provider.dart';
import 'package:free_beta/routes/infrastructure/route_remote_data_provider.dart';
import 'package:free_beta/user/user_route_model.dart';
import 'package:riverpod/riverpod.dart';

final routeRepository = Provider((ref) {
  return RouteRepository(
    routeLocalDataProvider: ref.watch(routeLocalDataProvider),
    routeRemoteDataProvider: ref.watch(routeRemoteDataProvider),
  );
});

class RouteRepository {
  final RouteRemoteDataProvider routeRemoteDataProvider;
  final RouteLocalDataProvider routeLocalDataProvider;

  RouteRepository({
    required this.routeRemoteDataProvider,
    required this.routeLocalDataProvider,
  });

  Future<List<RouteModel>> getRoutes() async {
    var routes = await routeRemoteDataProvider.getRoutes();
    var userRoutes = await routeLocalDataProvider.getUserRoutes();
    userRoutes.forEach((userRoute) {
      routes
          .firstWhere((route) => route.id == userRoute.routeId)
          .userRouteModel = userRoute;
    });
    return routes;
  }

  Future<void> saveRoute(UserRouteModel userRouteModel) async {
    await routeLocalDataProvider.saveRoute(userRouteModel);
  }
}
