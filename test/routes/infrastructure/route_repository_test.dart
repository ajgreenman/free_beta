import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_remote_data_provider.dart';
import 'package:free_beta/routes/infrastructure/route_repository.dart';
import 'package:free_beta/user/infrastructure/models/user_model.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockRouteRemoteDataProvider mockRouteRemoteDataProvider;

  setUp(() {
    mockRouteRemoteDataProvider = MockRouteRemoteDataProvider();

    registerFallbackValue(userRouteModel);
    registerFallbackValue(routeModel);
    registerFallbackValue(routeFormModel);
  });

  group('RouteRepository', () {
    test('getUserStats returns no results when user is null', () async {
      when(() => mockRouteRemoteDataProvider.getActiveRoutes())
          .thenAnswer((_) => Future.value([]));

      var routeRepository = RouteRepository(
        routeRemoteDataProvider: mockRouteRemoteDataProvider,
        user: null,
      );

      var stats = await routeRepository.getUserStats(RouteType.active);
      expect(stats.overall.total, 0);
      verifyNever(() => mockRouteRemoteDataProvider.getUserRoutes(any()));
    });

    test('getUserStats returns results when user is not null', () async {
      when(() => mockRouteRemoteDataProvider.getActiveRoutes())
          .thenAnswer((_) => Future.value([routeModel]));
      when(() => mockRouteRemoteDataProvider.getUserRoutes(any()))
          .thenAnswer((_) => Future.value([userRouteModel]));

      var routeRepository = RouteRepository(
        routeRemoteDataProvider: mockRouteRemoteDataProvider,
        user: userModel,
      );

      var stats = await routeRepository.getUserStats(RouteType.active);

      expect(stats.overall.total, 1);
      expect(stats.boulders.total, 1);
      verify(() => mockRouteRemoteDataProvider.getUserRoutes(any())).called(1);
    });

    test('getRemovedRoutes returns removed routes', () async {
      when(() => mockRouteRemoteDataProvider.getRemovedRoutes())
          .thenAnswer((_) => Future.value([removedRouteModel]));
      when(() => mockRouteRemoteDataProvider.getUserRoutes(any()))
          .thenAnswer((_) => Future.value([userRouteModel]));

      var routeRepository = RouteRepository(
        routeRemoteDataProvider: mockRouteRemoteDataProvider,
        user: userModel,
      );

      var removedRoutes = await routeRepository.getRoutes(RouteType.inactive);

      expect(removedRoutes.length, 1);
      verify(() => mockRouteRemoteDataProvider.getRemovedRoutes()).called(1);
    });

    test('saveRoute calls data provider', () async {
      when(() => mockRouteRemoteDataProvider.saveUserRoute(any()))
          .thenAnswer((_) => Future.value());

      var routeRepository = RouteRepository(
        routeRemoteDataProvider: mockRouteRemoteDataProvider,
        user: userModel,
      );

      await routeRepository.saveRoute(userRouteModel);

      verify(() => mockRouteRemoteDataProvider.saveUserRoute(any())).called(1);
    });

    test('addRoute calls data provider', () async {
      when(() => mockRouteRemoteDataProvider.addRoute(any()))
          .thenAnswer((_) => Future.value());

      var routeRepository = RouteRepository(
        routeRemoteDataProvider: mockRouteRemoteDataProvider,
        user: userModel,
      );

      await routeRepository.addRoute(routeFormModel);

      verify(() => mockRouteRemoteDataProvider.addRoute(any())).called(1);
    });

    test('updateRoute calls data provider', () async {
      when(() => mockRouteRemoteDataProvider.updateRoute(any(), any()))
          .thenAnswer((_) => Future.value());

      var routeRepository = RouteRepository(
        routeRemoteDataProvider: mockRouteRemoteDataProvider,
        user: userModel,
      );

      await routeRepository.updateRoute(routeModel, routeFormModel);

      verify(() => mockRouteRemoteDataProvider.updateRoute(any(), any()))
          .called(1);
    });

    test('deleteRoute calls data provider', () async {
      when(() => mockRouteRemoteDataProvider.deleteRoute(any()))
          .thenAnswer((_) => Future.value());

      var routeRepository = RouteRepository(
        routeRemoteDataProvider: mockRouteRemoteDataProvider,
        user: userModel,
      );

      await routeRepository.deleteRoute(routeModel);

      verify(() => mockRouteRemoteDataProvider.deleteRoute(any())).called(1);
    });
  });
}

class MockRouteRemoteDataProvider extends Mock
    implements RouteRemoteDataProvider {}

var userModel = UserModel(
  email: 'test@test.test',
  uid: 'user1234',
  isAnonymous: true,
);

var userRouteModel = UserRouteModel(
  routeId: 'abcd1234',
  userId: 'user1234',
  isCompleted: true,
  isFavorited: true,
);

var routeModel = RouteModel(
  id: 'abcd1234',
  climbType: ClimbType.boulder,
  routeColor: RouteColor.black,
  wallLocation: WallLocation.boulder,
  wallLocationIndex: 1,
  creationDate: DateTime.now(),
  boulderRating: BoulderRating.v0,
  userRouteModel: userRouteModel,
);

var removedRouteModel = RouteModel(
  id: 'abcd1234',
  climbType: ClimbType.boulder,
  routeColor: RouteColor.black,
  wallLocation: WallLocation.boulder,
  wallLocationIndex: 1,
  creationDate: DateTime.now(),
  removalDate: DateTime.now(),
  boulderRating: BoulderRating.v0,
  userRouteModel: userRouteModel,
);

var routeFormModel = RouteFormModel();
