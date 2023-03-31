import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/routes/presentation/route_list_screen.dart';
import 'package:free_beta/routes/presentation/widgets/route_list.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockCrashlyticsApi mockCrashlyticsApi;

  setUp(() {
    mockCrashlyticsApi = MockCrashlyticsApi();
    when(() => mockCrashlyticsApi.logError(any(), any(), any(), any()))
        .thenAnswer((_) => Future.value());
  });

  Widget buildFrame(
    List<RouteModel> routes,
    RouteFilterModel filteredRoutes,
  ) {
    return ProviderScope(
      overrides: [
        fetchActiveRoutesProvider.overrideWith((_) => routes),
        fetchFilteredRoutesProvider.overrideWith((_) => filteredRoutes),
        crashlyticsApiProvider.overrideWithValue(mockCrashlyticsApi),
      ],
      child: MaterialApp(
        home: RouteListScreen(
          refreshProvider: fetchActiveRoutesProvider,
          routeProvider: fetchFilteredRoutesProvider,
        ),
      ),
    );
  }

  group('RouteListScreen', () {
    testWidgets('smoke test', (tester) async {
      await tester.pumpWidget(
        buildFrame(
          [boulderRouteModel],
          filteredRoutes,
        ),
      );
      expect(find.byType(RouteListScreen), findsOneWidget);
      expect(find.byType(RouteList), findsOneWidget);
      expect(find.text('Sorry, no available routes'), findsNothing);
    });

    testWidgets('empty list shows message', (tester) async {
      await tester.pumpWidget(
        buildFrame(
          [],
          emptyFilteredRoutes,
        ),
      );
      expect(find.byType(RouteListScreen), findsOneWidget);
      expect(find.byType(RouteList), findsOneWidget);
      expect(find.text('Sorry, no available routes'), findsOneWidget);
    });
  });
}

class MockCrashlyticsApi extends Mock implements CrashlyticsApi {}

var userRouteModel = UserRouteModel(
  routeId: 'abcd1234',
  userId: 'user1234',
  isCompleted: true,
  isFavorited: true,
);

var boulderRouteModel = RouteModel(
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

var yosemiteRouteModel = RouteModel(
  id: 'abcd1234',
  climbType: ClimbType.topRope,
  routeColor: RouteColor.black,
  wallLocation: WallLocation.tall,
  wallLocationIndex: 1,
  creationDate: DateTime.now(),
  removalDate: DateTime.now(),
  yosemiteRating: YosemiteRating.eightPlus,
  userRouteModel: userRouteModel,
);

var filteredRoutes = RouteFilterModel(
  routes: [
    boulderRouteModel,
    yosemiteRouteModel,
    yosemiteRouteModel,
    boulderRouteModel,
  ],
  filteredRoutes: [
    boulderRouteModel,
    yosemiteRouteModel,
    yosemiteRouteModel,
    boulderRouteModel,
  ],
);

var emptyFilteredRoutes = RouteFilterModel(
  routes: [],
  filteredRoutes: [],
);
