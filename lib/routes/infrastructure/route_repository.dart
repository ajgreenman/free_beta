import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_local_data_provider.dart';
import 'package:free_beta/routes/infrastructure/route_remote_data_provider.dart';
import 'package:remote_state/remote_state.dart';

class RouteRepository {
  final RouteRemoteDataProvider routeRemoteDataProvider;
  final RouteLocalDataProvider routeLocalDataProvider;

  RouteRepository({
    required this.routeRemoteDataProvider,
    required this.routeLocalDataProvider,
  });

  Future<RemoteState<List<RouteModel>>> getRoutes() async {
    try {
      var routes = await routeRemoteDataProvider.getRoutes();
      var userRoutes = await routeLocalDataProvider.getUserRoutes();
      userRoutes.forEach((userRoute) {
        routes
            .firstWhere((route) => route.id == userRoute.routeId)
            .userRouteModel = userRoute;
      });
      return RemoteState.success(routes);
    } catch (error, stackTrace) {
      return RemoteState.error(error, stackTrace);
    }
  }
}
