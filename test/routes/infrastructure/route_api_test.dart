import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/infrastructure/route_repository.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late RouteApi routeApi;
  late MockRouteRepository mockRouteRepository;

  setUp(() {
    mockRouteRepository = MockRouteRepository();

    registerFallbackValue(RouteType.active);
    registerFallbackValue(userRouteModel);
    registerFallbackValue(routeFormModel);
    registerFallbackValue(boulderRoute);

    routeApi = RouteApi(
      routeRepository: mockRouteRepository,
    );
  });

  group('RouteApi', () {
    test('getAllUserStats calls repository', () async {
      when(() => mockRouteRepository.getUserStats(any()))
          .thenAnswer((_) => Future.value(userStats));

      var allUserStats = await routeApi.getAllUserStats();

      expect(allUserStats, userStats);
      verify(() => mockRouteRepository.getUserStats(any())).called(1);
    });
    test('getActiveUserStats calls repository', () async {
      when(() => mockRouteRepository.getUserStats(any()))
          .thenAnswer((_) => Future.value(userStats));

      var activeUserStats = await routeApi.getActiveUserStats();

      expect(activeUserStats, userStats);
      verify(() => mockRouteRepository.getUserStats(any())).called(1);
    });
    test('getRemovedUserStats calls repository', () async {
      when(() => mockRouteRepository.getUserStats(any()))
          .thenAnswer((_) => Future.value(userStats));

      var removedUserStats = await routeApi.getRemovedUserStats();

      expect(removedUserStats, userStats);
      verify(() => mockRouteRepository.getUserStats(any())).called(1);
    });
    test('getAllRoutes calls repository', () async {
      when(() => mockRouteRepository.getRoutes(any()))
          .thenAnswer((_) => Future.value(routes));

      var allRoutes = await routeApi.getAllRoutes();

      expect(allRoutes, routes);
      verify(() => mockRouteRepository.getRoutes(any())).called(1);
    });
    test('getActiveRoutes calls repository', () async {
      when(() => mockRouteRepository.getRoutes(any()))
          .thenAnswer((_) => Future.value(routes));

      var activeRoutes = await routeApi.getActiveRoutes();

      expect(activeRoutes, routes);
      verify(() => mockRouteRepository.getRoutes(any())).called(1);
    });
    test('getRemovedRoutes calls repository', () async {
      when(() => mockRouteRepository.getRoutes(any()))
          .thenAnswer((_) => Future.value(routes));

      var removedRoutes = await routeApi.getRemovedRoutes();

      expect(removedRoutes, routes);
      verify(() => mockRouteRepository.getRoutes(any())).called(1);
    });
    test('saveRoute calls repository', () async {
      when(() => mockRouteRepository.saveRoute(any()))
          .thenAnswer((_) => Future.value());

      await routeApi.saveRoute(userRouteModel);

      verify(() => mockRouteRepository.saveRoute(any())).called(1);
    });
    test('addRoute calls repository', () async {
      when(() => mockRouteRepository.addRoute(any()))
          .thenAnswer((_) => Future.value());

      await routeApi.addRoute(routeFormModel);

      verify(() => mockRouteRepository.addRoute(any())).called(1);
    });
    test('updateRoute calls repository', () async {
      when(() => mockRouteRepository.updateRoute(any(), any()))
          .thenAnswer((_) => Future.value());

      await routeApi.updateRoute(boulderRoute, routeFormModel);

      verify(() => mockRouteRepository.updateRoute(any(), any())).called(1);
    });
    test('deleteRoute calls repository', () async {
      when(() => mockRouteRepository.deleteRoute(any()))
          .thenAnswer((_) => Future.value());

      await routeApi.deleteRoute(boulderRoute);

      verify(() => mockRouteRepository.deleteRoute(any())).called(1);
    });
    test('getLocationFilteredRoutes filters by location', () {
      var routeFilterModel =
          routeApi.getLocationFilteredRoutes(routes, WallLocation.mezzanine, 1);

      var expected = RouteFilterModel(
        routes: routes,
        filteredRoutes: [mezzanineRoute],
      );

      expect(routeFilterModel, expected);
    });
    test('getFilteredRoutes filters by text', () {
      var routeFilterModel = routeApi.getFilteredRoutes(
        routes,
        'BLACK',
        null,
        null,
        null,
      );

      var expected = RouteFilterModel(
        routes: routes,
        filteredRoutes: [boulderRoute, boulderRoute],
      );

      expect(routeFilterModel, expected);
    });
    test('getFilteredRoutes filters by type', () {
      var routeFilterModel = routeApi.getFilteredRoutes(
        routes,
        null,
        ClimbType.topRope,
        null,
        null,
      );

      var expected = RouteFilterModel(
        routes: routes,
        filteredRoutes: [mezzanineRoute],
      );

      expect(routeFilterModel, expected);
    });
    test('getFilteredRoutes filters by color', () {
      var routeFilterModel = routeApi.getFilteredRoutes(
        routes,
        null,
        null,
        RouteColor.green,
        null,
      );

      var expected = RouteFilterModel(
        routes: routes,
        filteredRoutes: [mezzanineRoute],
      );

      expect(routeFilterModel, expected);
    });
    test('getFilteredRoutes filters by attempted = true', () {
      var routeFilterModel = routeApi.getFilteredRoutes(
        routes,
        null,
        null,
        null,
        true,
      );

      var expected = RouteFilterModel(
        routes: routes,
        filteredRoutes: [boulderRoute, boulderRoute],
      );

      expect(routeFilterModel, expected);
    });
    test('getFilteredRoutes filters by attempted = false', () {
      var routeFilterModel = routeApi.getFilteredRoutes(
        routes,
        null,
        null,
        null,
        false,
      );

      var expected = RouteFilterModel(
        routes: routes,
        filteredRoutes: [mezzanineRoute],
      );

      expect(routeFilterModel, expected);
    });
  });
}

class MockRouteRepository extends Mock implements RouteRepository {}

var userStats = UserStatsModel.fromRouteList(routes);

var routes = [
  boulderRoute,
  boulderRoute,
  mezzanineRoute,
];

var boulderRoute = RouteModel(
  id: '',
  climbType: ClimbType.boulder,
  routeColor: RouteColor.black,
  wallLocation: WallLocation.boulder,
  wallLocationIndex: 0,
  creationDate: DateTime.now(),
  boulderRating: BoulderRating.v0,
  userRouteModel: userRouteModel,
);

var mezzanineRoute = RouteModel(
  id: '',
  climbType: ClimbType.topRope,
  routeColor: RouteColor.green,
  wallLocation: WallLocation.mezzanine,
  wallLocationIndex: 1,
  creationDate: DateTime.now(),
  boulderRating: BoulderRating.v0,
);

var userRouteModel = UserRouteModel(
  userId: '',
  routeId: '',
  isCompleted: true,
  isFavorited: true,
  attempts: 1,
);

var routeFormModel = RouteFormModel.fromRouteModel(boulderRoute);
