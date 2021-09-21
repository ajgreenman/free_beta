import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_remote_data_provider.dart';
import 'package:remote_state/remote_state.dart';

class RouteRepository {
  final RouteRemoteDataProvider routeRemoteDataProvider;

  RouteRepository({required this.routeRemoteDataProvider});

  Future<RemoteState<List<RouteModel>>> getRoutes() async {
    return RemoteState.guard(() => routeRemoteDataProvider.getRoutes());
  }
}
