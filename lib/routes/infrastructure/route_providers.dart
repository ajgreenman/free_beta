import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/infrastructure/route_graph_api.dart';
import 'package:free_beta/routes/infrastructure/route_remote_data_provider.dart';
import 'package:free_beta/routes/infrastructure/route_repository.dart';
import 'package:free_beta/user/infrastructure/models/user_model.dart';
import 'package:free_beta/user/infrastructure/models/user_rating_model.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:free_beta/user/infrastructure/user_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'route_providers.g.dart';

@riverpod
RouteApi routeApi(RouteApiRef ref) {
  return RouteApi(
    routeRepository: ref.watch(routeRepositoryProvider),
  );
}

@riverpod
RouteGraphApi routeGraphApi(RouteGraphApiRef ref) {
  return RouteGraphApi();
}

@riverpod
RouteRepository routeRepository(RouteRepositoryRef ref) {
  return RouteRepository(
    routeRemoteDataProvider: ref.watch(routeRemoteDataProvider),
    user: ref.watch(authenticationStreamProvider).whenOrNull<UserModel?>(
          data: (user) => user,
        ),
  );
}

@riverpod
RouteRemoteDataProvider routeRemoteData(
  RouteRemoteDataRef ref,
) {
  return RouteRemoteDataProvider(
    FirebaseFirestore.instance,
    ref.read(crashlyticsApiProvider),
  );
}

@riverpod
Future<UserStatsModel> fetchUserStats(FetchUserStatsRef ref) async {
  final routeApi = ref.watch(routeApiProvider);
  final includeRemovedRoutes = ref.watch(includeRemovedRoutesProvider);

  if (includeRemovedRoutes) {
    return await routeApi.getAllUserStats();
  } else {
    return await routeApi.getActiveUserStats();
  }
}

@riverpod
Future<List<RouteModel>> fetchAllRoutes(FetchAllRoutesRef ref) async {
  final routeApi = ref.watch(routeApiProvider);

  return await routeApi.getAllRoutes();
}

@riverpod
Future<List<RouteModel>> fetchActiveRoutes(FetchActiveRoutesRef ref) async {
  final routeApi = ref.watch(routeApiProvider);

  return await routeApi.getActiveRoutes();
}

@riverpod
Future<List<RouteModel>> fetchRemovedRoutes(FetchRemovedRoutesRef ref) async {
  final routeApi = ref.watch(routeApiProvider);

  return await routeApi.getRemovedRoutes();
}

@riverpod
Future<RouteFilterModel> fetchFilteredRoutes(FetchFilteredRoutesRef ref) async {
  final routeApi = ref.watch(routeApiProvider);
  final routes = await ref.watch(fetchActiveRoutesProvider.future);
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
}

@riverpod
Future<RouteFilterModel> fetchFilteredRemovedRoutes(
    FetchFilteredRemovedRoutesRef ref) async {
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
}

@riverpod
FutureOr<RouteFilterModel> fetchLocationFilteredRoutes(
    FetchLocationFilteredRoutesRef ref) async {
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

@riverpod
Future<List<UserRatingModel>> fetchRatingUserGraph(
  FetchRatingUserGraphRef ref, {
  required ClimbType climbType,
}) async {
  final includeRemovedRoutes = ref.watch(includeRemovedRoutesProvider);

  List<RouteModel> unfilteredRoutes;
  if (includeRemovedRoutes) {
    unfilteredRoutes = await ref.watch(fetchAllRoutesProvider.future);
  } else {
    unfilteredRoutes = await ref.watch(fetchActiveRoutesProvider.future);
  }

  final includeGraphDetails = ref.watch(includeGraphDetailsProvider);

  final routeGraphApi = ref.watch(routeGraphApiProvider);

  return routeGraphApi.getUserRatings(
    climbType: climbType,
    unfilteredRoutes: unfilteredRoutes,
    includeGraphDetails: includeGraphDetails,
  );
}

final includeRemovedRoutesProvider = StateProvider<bool>((_) => false);
final includeGraphDetailsProvider = StateProvider<bool>((_) => false);
final routeTextFilterProvider = StateProvider<String?>((_) => null);
final routeClimbTypeFilterProvider = StateProvider<ClimbType?>((_) => null);
final routeRouteColorFilterProvider = StateProvider<RouteColor?>((_) => null);
final routeAttemptedFilterProvider = StateProvider<bool?>((_) => null);
final routeWallLocationFilterProvider =
    StateProvider<WallLocation?>((_) => null);
final routeWallLocationIndexFilterProvider = StateProvider<int?>((_) => null);
