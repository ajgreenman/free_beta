import 'dart:async';

import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_repository.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:riverpod/riverpod.dart';

final routeApiProvider = Provider(
  (ref) => RouteApi(
    routeRepository: ref.watch(routeRepository),
  ),
);

final routeTypeFilterProvider = StateProvider<ClimbType?>((_) => null);
final routeColorFilterProvider = StateProvider<RouteColor?>((_) => null);

final fetchRoutesProvider = FutureProvider((ref) async {
  final routeApi = ref.watch(routeApiProvider);

  return await routeApi.getRoutes();
});

final fetchFilteredRoutesProvider =
    FutureProvider<List<RouteModel>>((ref) async {
  final routes = await ref.watch(fetchRoutesProvider.future);

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

class RouteApi {
  final RouteRepository routeRepository;

  RouteApi({required this.routeRepository});

  Future<List<RouteModel>> getRoutes() async {
    return routeRepository.getRoutes();
  }

  Future<void> saveRoute(UserRouteModel userRouteModel) async {
    return routeRepository.saveRoute(userRouteModel);
  }

  Future<void> addRoute(RouteFormModel routeFormModel) async {
    return routeRepository.addRoute(routeFormModel);
  }
}
