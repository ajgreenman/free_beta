import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_repository.dart';
import 'package:remote_state/remote_state.dart';

class RouteServiceFacade {
  final RouteRepository routeRepository;

  RouteServiceFacade({required this.routeRepository});

  Future<RemoteState<List<RouteModel>>> getRoutes() {
    return routeRepository.getRoutes();
  }
}
