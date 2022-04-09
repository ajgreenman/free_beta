import 'dart:async';

import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_repository.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:riverpod/riverpod.dart';

final routeApiProvider = Provider(
  (ref) => RouteApi(
    routeRepository: ref.watch(routeRepository),
  ),
);

final fetchUserStatsProvider = FutureProvider<UserStatsModel>((ref) async {
  final routeApi = ref.watch(routeApiProvider);

  return routeApi.getUserStats();
});

final routeTextFilterProvider = StateProvider<String?>((_) => null);
final routeClimbTypeFilterProvider = StateProvider<ClimbType?>((_) => null);
final routeRouteColorFilterProvider = StateProvider<RouteColor?>((_) => null);
final routeAttemptedFilterProvider = StateProvider<bool?>((_) => null);

final fetchRoutesProvider = FutureProvider((ref) async {
  final routeApi = ref.watch(routeApiProvider);

  return await routeApi.getRoutes();
});

final fetchRemovedRoutesProvider = FutureProvider((ref) async {
  final routeApi = ref.watch(routeApiProvider);

  return await routeApi.getRemovedRoutes();
});

final fetchFilteredRoutes = FutureProvider<RouteFilterModel>((ref) async {
  final routeApi = ref.watch(routeApiProvider);
  final routes = await ref.watch(fetchRoutesProvider.future);
  final textFilter = ref.watch(routeTextFilterProvider);
  final climbTypeFilter = ref.watch(routeClimbTypeFilterProvider);
  final routeColorFilter = ref.watch(routeRouteColorFilterProvider);
  final routeAttemptedFilter = ref.watch(routeAttemptedFilterProvider);
  return routeApi.getFilteredRoutes(
    routes,
    textFilter,
    climbTypeFilter,
    routeColorFilter,
    routeAttemptedFilter,
  );
});

final fetchFilteredRemovedRoutes =
    FutureProvider<RouteFilterModel>((ref) async {
  final routeApi = ref.watch(routeApiProvider);
  final routes = await ref.watch(fetchRemovedRoutesProvider.future);
  final textFilter = ref.watch(routeTextFilterProvider);
  final climbTypeFilter = ref.watch(routeClimbTypeFilterProvider);
  final routeColorFilter = ref.watch(routeRouteColorFilterProvider);
  final routeAttemptedFilter = ref.watch(routeAttemptedFilterProvider);
  return routeApi.getFilteredRoutes(
    routes,
    textFilter,
    climbTypeFilter,
    routeColorFilter,
    routeAttemptedFilter,
  );
});

class RouteApi {
  final RouteRepository routeRepository;

  RouteApi({required this.routeRepository});

  Future<UserStatsModel> getUserStats() async {
    return routeRepository.getUserStats();
  }

  Future<List<RouteModel>> getRoutes() async {
    return routeRepository.getRoutes();
  }

  Future<List<RouteModel>> getRemovedRoutes() async {
    return routeRepository.getRemovedRoutes();
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

  RouteFilterModel getFilteredRoutes(
    List<RouteModel> unfilteredRoutes,
    String? textFilter,
    ClimbType? climbTypeFilter,
    RouteColor? routeColorFilter,
    bool? routeAttemptedFilter,
  ) {
    Iterable<RouteModel> filteredRoutes = unfilteredRoutes;
    if (textFilter != null) {
      var filterText = textFilter.toLowerCase();
      filteredRoutes = unfilteredRoutes.where(
        (route) {
          return route.name.toLowerCase().contains(filterText) ||
              route.routeColor.displayName.toLowerCase().contains(filterText) ||
              route.difficulty.toLowerCase().contains(filterText) ||
              route.climbType.displayName.toLowerCase().contains(filterText);
        },
      );
    }

    if (climbTypeFilter != null) {
      filteredRoutes =
          filteredRoutes.where((route) => route.climbType == climbTypeFilter);
    }

    if (routeColorFilter != null) {
      filteredRoutes =
          filteredRoutes.where((route) => route.routeColor == routeColorFilter);
    }

    if (routeAttemptedFilter != null) {
      filteredRoutes = filteredRoutes.where((route) {
        if (routeAttemptedFilter && route.userRouteModel == null) return false;
        if (!routeAttemptedFilter && route.userRouteModel == null) return true;
        if (routeAttemptedFilter && route.userRouteModel!.isAttempted) {
          return true;
        }
        if (!routeAttemptedFilter && !route.userRouteModel!.isAttempted) {
          return true;
        }
        return false;
      });
    }

    return RouteFilterModel(
      routes: unfilteredRoutes,
      filteredRoutes: filteredRoutes.toList(),
    );
  }
}
