import 'package:charts_flutter/flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/infrastructure/route_remote_data_provider.dart';
import 'package:free_beta/routes/infrastructure/route_repository.dart';
import 'package:free_beta/user/infrastructure/models/user_model.dart';
import 'package:free_beta/user/infrastructure/models/user_rating_model.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:free_beta/user/infrastructure/user_providers.dart';

final routeApiProvider = Provider(
  (ref) => RouteApi(
    routeRepository: ref.watch(routeRepositoryProvider),
  ),
);

final routeRepositoryProvider = Provider((ref) {
  return RouteRepository(
    routeRemoteDataProvider: ref.watch(routeRemoteDataProvider),
    user: ref.watch(authenticationProvider).whenOrNull<UserModel?>(
          data: (user) => user,
        ),
  );
});

final routeRemoteDataProvider = Provider(
    (ref) => RouteRemoteDataProvider(ref.read(crashlyticsApiProvider)));

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

final fetchRatingUserGraph =
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
