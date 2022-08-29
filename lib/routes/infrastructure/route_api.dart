import 'dart:async';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_repository.dart';
import 'package:free_beta/user/infrastructure/models/user_rating_model.dart';
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
final routeWallLocationFilterProvider =
    StateProvider<WallLocation?>((_) => null);
final routeWallLocationIndexFilterProvider = StateProvider<int?>((_) => null);

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

final fetchLocationFilteredRoutes =
    FutureProvider<RouteFilterModel>((ref) async {
  final routeApi = ref.watch(routeApiProvider);
  final routes = await ref.watch(fetchRoutesProvider.future);
  final wallLocationFilter = ref.watch(routeWallLocationFilterProvider);
  final wallLocationIndexFilter =
      ref.watch(routeWallLocationIndexFilterProvider);
  return routeApi.getLocationFilteredRoutes(
    routes,
    wallLocationFilter,
    wallLocationIndexFilter,
  );
});

final fetchYosemiteRatingUserGraph =
    FutureProvider.family<List<Series<UserRatingModel, String>>, ClimbType>(
        (ref, climbType) async {
  final unfilteredRoutes = await ref.watch(fetchRoutesProvider.future);
  var routes = unfilteredRoutes
      .sortRoutes()
      .where((route) => route.climbType == climbType)
      .toList();

  if (climbType == ClimbType.boulder) return _getBoulderRatingGraph(routes);

  return [
    _createSeries(
      id: 'Unattempted',
      data: _getUserYosemiteRatings(routes, (route) => route.isUnattempted),
      color: RouteColor.red,
      domainFn: (userRatingModel, _) =>
          userRatingModel.yosemiteRating!.displayName,
    ),
    _createSeries(
      id: 'InProgress',
      data: _getUserYosemiteRatings(routes, (route) => route.isInProgress),
      color: RouteColor.yellow,
      domainFn: (userRatingModel, _) =>
          userRatingModel.yosemiteRating!.displayName,
    ),
    _createSeries(
      id: 'Completed',
      data: _getUserYosemiteRatings(routes, (route) => route.isCompleted),
      color: RouteColor.green,
      domainFn: (userRatingModel, _) =>
          userRatingModel.yosemiteRating!.displayName,
    ),
  ];
});

List<Series<UserRatingModel, String>> _getBoulderRatingGraph(
    List<RouteModel> routes) {
  return [
    _createSeries(
      id: 'Unattempted',
      data: _getUserBoulderRatings(routes, (route) => route.isUnattempted),
      color: RouteColor.red,
      domainFn: (userRatingModel, _) =>
          userRatingModel.boulderRating!.displayName,
    ),
    _createSeries(
      id: 'InProgress',
      data: _getUserBoulderRatings(routes, (route) => route.isInProgress),
      color: RouteColor.yellow,
      domainFn: (userRatingModel, _) =>
          userRatingModel.boulderRating!.displayName,
    ),
    _createSeries(
      id: 'Completed',
      data: _getUserBoulderRatings(routes, (route) => route.isCompleted),
      color: RouteColor.green,
      domainFn: (userRatingModel, _) =>
          userRatingModel.boulderRating!.displayName,
    ),
  ];
}

Series<UserRatingModel, String> _createSeries({
  required String id,
  required List<UserRatingModel> data,
  required RouteColor color,
  required String Function(UserRatingModel, int?) domainFn,
}) {
  return Series<UserRatingModel, String>(
    id: id,
    data: data,
    domainFn: domainFn,
    measureFn: (userRatingModel, _) => userRatingModel.count,
    colorFn: (_, __) => ColorUtil.fromDartColor(
      color.displayColor.withOpacity(0.7),
    ),
  );
}

List<UserRatingModel> _getUserBoulderRatings(
  List<RouteModel> routes,
  bool Function(RouteModel) routeCondition,
) {
  return BoulderRating.values
      .where((value) => value.isIncludedInGraph)
      .map(
        (boulderRating) => UserRatingModel.withBoulder(
          boulderRating: boulderRating,
          count: routes
              .where((route) => route.boulderRating == boulderRating)
              .where(routeCondition)
              .length,
        ),
      )
      .toList();
}

List<UserRatingModel> _getUserYosemiteRatings(
  List<RouteModel> routes,
  bool Function(RouteModel) routeCondition,
) {
  return CondensedYosemiteRating.values
      .map(
        (yosemiteRating) => UserRatingModel.withYosemite(
          yosemiteRating: yosemiteRating,
          count: routes
              .where((route) =>
                  route.yosemiteRating!.condensedRating == yosemiteRating)
              .where(routeCondition)
              .length,
        ),
      )
      .toList();
}

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
