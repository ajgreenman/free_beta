import 'dart:async';

import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
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

final routeTextFilterProvider = StateProvider<String?>((_) => null);

final fetchRoutesProvider = FutureProvider((ref) async {
  final routeApi = ref.watch(routeApiProvider);

  return (await routeApi.getRoutes())
      .where((route) => route.removalDate == null)
      .toList();
});

final fetchRemovedRoutesProvider = FutureProvider((ref) async {
  final routeApi = ref.watch(routeApiProvider);

  return (await routeApi.getRoutes())
      .where((route) => route.removalDate != null)
      .toList();
});

final fetchFilteredRoutes = FutureProvider<RouteFilterModel>((ref) async {
  final routes = await ref.watch(fetchRoutesProvider.future);
  final filter = ref.watch(routeTextFilterProvider);
  return _getFilteredRoutes(routes, filter);
});

final fetchFilteredRemovedRoutes =
    FutureProvider<RouteFilterModel>((ref) async {
  final routes = await ref.watch(fetchRemovedRoutesProvider.future);
  final filter = ref.watch(routeTextFilterProvider);
  return _getFilteredRoutes(routes, filter);
});

RouteFilterModel _getFilteredRoutes(
  List<RouteModel> unfilteredRoutes,
  String? filter,
) {
  Iterable<RouteModel> filteredRoutes = unfilteredRoutes;
  if (filter != null) {
    var filterText = filter.toLowerCase();
    filteredRoutes = unfilteredRoutes.where(
      (route) {
        return route.name.toLowerCase().contains(filterText) ||
            route.routeColor.displayName.toLowerCase().contains(filterText) ||
            route.difficulty.toLowerCase().contains(filterText) ||
            route.climbType.displayName.toLowerCase().contains(filterText);
      },
    );
  }

  return RouteFilterModel(
    filter: filter,
    routes: unfilteredRoutes,
    filteredRoutes: filteredRoutes.toList(),
  );
}

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

  Future<void> updateRoute(
    RouteModel routeModel,
    RouteFormModel routeFormModel,
  ) async {
    return routeRepository.updateRoute(
      routeModel,
      routeFormModel,
    );
  }

  Future<void> deleteRoute(
    RouteModel routeModel,
  ) async {
    return routeRepository.deleteRoute(
      routeModel,
    );
  }
}
