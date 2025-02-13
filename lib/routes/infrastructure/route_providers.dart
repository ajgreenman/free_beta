import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/infrastructure/route_graph_api.dart';
import 'package:free_beta/routes/infrastructure/route_list_scroll_controller.dart';
import 'package:free_beta/routes/infrastructure/route_remote_data_provider.dart';
import 'package:free_beta/routes/infrastructure/route_repository.dart';
import 'package:free_beta/user/infrastructure/models/user_model.dart';
import 'package:free_beta/user/infrastructure/models/user_rating_model.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:free_beta/user/infrastructure/user_providers.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'route_providers.g.dart';

@Riverpod(dependencies: [routeRepository])
RouteApi routeApi(Ref ref) {
  return RouteApi(
    routeRepository: ref.watch(routeRepositoryProvider),
  );
}

@riverpod
RouteGraphApi routeGraphApi(Ref ref) {
  return RouteGraphApi();
}

@Riverpod(dependencies: [routeRemoteData, authenticationStream])
RouteRepository routeRepository(Ref ref) {
  return RouteRepository(
    routeRemoteDataProvider: ref.watch(routeRemoteDataProvider),
    user: ref.watch(authenticationStreamProvider).whenOrNull<UserModel?>(
          data: (user) => user,
        ),
  );
}

@Riverpod(dependencies: [crashlyticsApi])
RouteRemoteDataProvider routeRemoteData(
  Ref ref,
) {
  return RouteRemoteDataProvider(
    FirebaseFirestore.instance,
    ref.read(crashlyticsApiProvider),
  );
}

@riverpod
RouteListScrollController routeListScrollController(
  Ref ref,
) {
  return RouteListScrollController();
}

@Riverpod(dependencies: [routeApi])
Future<UserStatsModel> fetchUserStats(Ref ref) async {
  final routeApi = ref.watch(routeApiProvider);
  final includeRemovedRoutes = ref.watch(includeRemovedRoutesProvider);

  if (includeRemovedRoutes) {
    return await routeApi.getAllUserStats();
  } else {
    return await routeApi.getActiveUserStats();
  }
}

@Riverpod(dependencies: [routeApi])
Future<List<RouteModel>> fetchAllRoutes(Ref ref) async {
  final routeApi = ref.watch(routeApiProvider);

  return await routeApi.getAllRoutes();
}

@Riverpod(dependencies: [routeApi])
Future<List<RouteModel>> fetchActiveRoutes(Ref ref) async {
  final routeApi = ref.watch(routeApiProvider);

  return await routeApi.getActiveRoutes();
}

@Riverpod(dependencies: [routeApi])
Future<List<RouteModel>> fetchRemovedRoutes(Ref ref) async {
  final routeApi = ref.watch(routeApiProvider);

  return await routeApi.getRemovedRoutes();
}

@Riverpod(dependencies: [routeApi, fetchActiveRoutes])
Future<RouteFilterModel> fetchFilteredRoutes(Ref ref) async {
  final routeApi = ref.watch(routeApiProvider);
  final routes = await ref.watch(fetchActiveRoutesProvider.future);
  final textFilter = ref.watch(routeTextFilterProvider);
  final climbTypeFilter = ref.watch(routeClimbTypeFilterProvider);
  final routeColorFilter = ref.watch(routeColorFilterProvider);
  final routeAttemptedFilter = ref.watch(routeAttemptedFilterProvider);
  return routeApi.getFilteredRoutes(
    routes,
    textFilter,
    climbTypeFilter,
    routeColorFilter,
    routeAttemptedFilter,
  );
}

@Riverpod(dependencies: [routeApi, fetchRemovedRoutes])
Future<RouteFilterModel> fetchFilteredRemovedRoutes(Ref ref) async {
  final routeApi = ref.watch(routeApiProvider);
  final routes = await ref.watch(fetchRemovedRoutesProvider.future);
  final textFilter = ref.watch(routeTextFilterProvider);
  final climbTypeFilter = ref.watch(routeClimbTypeFilterProvider);
  final routeColorFilter = ref.watch(routeColorFilterProvider);
  final routeAttemptedFilter = ref.watch(routeAttemptedFilterProvider);
  return routeApi.getFilteredRoutes(
    routes,
    textFilter,
    climbTypeFilter,
    routeColorFilter,
    routeAttemptedFilter,
  );
}

@Riverpod(dependencies: [routeApi, fetchActiveRoutes])
FutureOr<RouteFilterModel> fetchLocationFilteredRoutes(Ref ref) async {
  final routeApi = ref.watch(routeApiProvider);
  final routes = await ref.watch(fetchActiveRoutesProvider.future);
  final wallLocationFilter = ref.watch(routeWallLocationFilterProvider);
  final wallLocationIndexFilter =
      ref.watch(routeWallLocationIndexFilterProvider);
  return routeApi.getLocationFilteredRoutes(
    routes,
    wallLocationFilter,
    wallLocationIndexFilter,
  );
}

@Riverpod(dependencies: [fetchAllRoutes, fetchActiveRoutes])
Future<List<UserRatingModel>> fetchRatingUserGraph(
  Ref ref, {
  required bool isBoulder,
}) async {
  final includeRemovedRoutes = ref.watch(includeRemovedRoutesProvider);

  List<RouteModel> unfilteredRoutes;
  if (includeRemovedRoutes) {
    unfilteredRoutes = await ref.watch(fetchAllRoutesProvider.future);
  } else {
    unfilteredRoutes = await ref.watch(fetchActiveRoutesProvider.future);
  }

  final routeGraphApi = ref.watch(routeGraphApiProvider);

  if (isBoulder) {
    return routeGraphApi.getBoulderUserRatings(
        unfilteredRoutes: unfilteredRoutes);
  }

  return routeGraphApi.getRopeUserRatings(
    climbTypes: ref.watch(includedClimbTypesProvider),
    unfilteredRoutes: unfilteredRoutes,
  );
}

@riverpod
List<ClimbType> includedClimbTypes(Ref ref) {
  var climbTypes = <ClimbType>[];
  if (ref.watch(includeTopRopeInGraphProvider)) {
    climbTypes.add(ClimbType.topRope);
  }
  if (ref.watch(includeAutoBelayInGraphProvider)) {
    climbTypes.add(ClimbType.autoBelay);
  }
  if (ref.watch(includeLeadInGraphProvider)) {
    climbTypes.add(ClimbType.lead);
  }
  return climbTypes;
}

@riverpod
class IncludeRemovedRoutes extends _$IncludeRemovedRoutes {
  @override
  bool build() => false;

  void update(bool value) => state = value;
}

@Riverpod(dependencies: [])
class IncludeGraphDetails extends _$IncludeGraphDetails {
  @override
  bool build() => false;

  void update(bool value) => state = value;
}

@riverpod
class IncludeTopRopeInGraph extends _$IncludeTopRopeInGraph {
  @override
  bool build() => true;

  void toggle() => state = !state;
}

@riverpod
class IncludeAutoBelayInGraph extends _$IncludeAutoBelayInGraph {
  @override
  bool build() => true;

  void toggle() => state = !state;
}

@riverpod
class IncludeLeadInGraph extends _$IncludeLeadInGraph {
  @override
  bool build() => false;

  void toggle() => state = !state;
}

@riverpod
class RouteTextFilter extends _$RouteTextFilter {
  @override
  String? build() => null;

  void update(String value) => state = value;
}

@riverpod
class RouteClimbTypeFilter extends _$RouteClimbTypeFilter {
  @override
  ClimbType? build() => null;

  void update(ClimbType? value) => state = value;
}

@riverpod
class RouteColorFilter extends _$RouteColorFilter {
  @override
  RouteColor? build() => null;

  void update(RouteColor? value) => state = value;
}

@riverpod
class RouteAttemptedFilter extends _$RouteAttemptedFilter {
  @override
  bool? build() => null;

  void update(bool? value) => state = value;
}

@Riverpod(keepAlive: true)
class RouteWallLocationFilter extends _$RouteWallLocationFilter {
  @override
  WallLocation? build() => null;

  void update(WallLocation value) => state = value;
}

@Riverpod(keepAlive: true)
class RouteWallLocationIndexFilter extends _$RouteWallLocationIndexFilter {
  @override
  int? build() => null;

  void update(int value) => state = value;
}
