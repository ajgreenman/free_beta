import 'dart:async';

import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_repository.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';

class RouteApi {
  final RouteRepository routeRepository;

  RouteApi({required this.routeRepository});

  Future<UserStatsModel> getAllUserStats() async {
    return routeRepository.getUserStats(RouteType.all);
  }

  Future<UserStatsModel> getActiveUserStats() async {
    return routeRepository.getUserStats(RouteType.active);
  }

  Future<UserStatsModel> getRemovedUserStats() async {
    return routeRepository.getUserStats(RouteType.inactive);
  }

  Future<List<RouteModel>> getAllRoutes() async {
    return routeRepository.getRoutes(RouteType.all);
  }

  Future<List<RouteModel>> getActiveRoutes() async {
    return routeRepository.getRoutes(RouteType.active);
  }

  Future<List<RouteModel>> getRemovedRoutes() async {
    return routeRepository.getRoutes(RouteType.inactive);
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

  RouteFilterModel getLocationFilteredRoutes(
    List<RouteModel> unfilteredRoutes,
    WallLocation? wallLocationFilter,
    int? wallLocationIndexFilter,
  ) {
    Iterable<RouteModel> filteredRoutes = unfilteredRoutes;
    if (wallLocationFilter != null) {
      filteredRoutes = filteredRoutes
          .where((route) => route.wallLocation == wallLocationFilter);
    }
    if (wallLocationIndexFilter != null) {
      filteredRoutes = filteredRoutes
          .where((route) => route.wallLocationIndex == wallLocationIndexFilter);
    }

    return RouteFilterModel(
      routes: unfilteredRoutes,
      filteredRoutes: filteredRoutes.toList(),
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
          var rating =
              route.boulderRating?.name ?? route.yosemiteRating?.name ?? '';
          return route.name.toLowerCase().contains(filterText) ||
              route.routeColor.displayName.toLowerCase().contains(filterText) ||
              rating.toLowerCase().contains(filterText) ||
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
