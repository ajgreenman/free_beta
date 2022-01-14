import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_repository.dart';
import 'package:riverpod/riverpod.dart';

final routeApiProvider = Provider((ref) {
  return RouteServiceFacade(
    routeRepository: ref.watch(routeRepository),
  );
});

final routeTypeFilterProvider = StateProvider<ClimbType?>((_) => null);
final routeColorFilterProvider = StateProvider<RouteColor?>((_) => null);

final fetchRoutesProvider = FutureProvider((ref) async {
  final routeServiceFacade = ref.watch(routeApiProvider);

  var routes = await routeServiceFacade.getRoutes();
  Iterable<RouteModel> filteredRoutes = routes;

  final routeTypeFilter = ref.watch(routeTypeFilterProvider);
  if (routeTypeFilter != null) {
    filteredRoutes = routes.where(
      (route) => route.climbType == routeTypeFilter,
    );
  }

  final routeColorFilter = ref.watch(routeColorFilterProvider);
  if (routeColorFilter != null) {
    filteredRoutes = filteredRoutes.where(
      (route) => route.routeColor == routeColorFilter,
    );
  }

  return filteredRoutes.toList();
});

class RouteServiceFacade {
  final RouteRepository routeRepository;

  RouteServiceFacade({required this.routeRepository});

  Future<List<RouteModel>> getRoutes() async {
    return routeRepository.getRoutes();
  }
}
