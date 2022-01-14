import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_repository.dart';
import 'package:riverpod/riverpod.dart';

final routeServiceFacadeProvider = Provider((ref) {
  return RouteServiceFacade(
    routeRepository: ref.watch(routeRepository),
  );
});

class RouteServiceFacade {
  final RouteRepository routeRepository;

  RouteServiceFacade({required this.routeRepository});

  Future<List<RouteModel>> getRoutes() {
    return routeRepository.getRoutes();
  }
}
