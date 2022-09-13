import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
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
    AsyncValue<List<RouteModel>> routes,
    AsyncValue<RouteFilterModel> filteredRoutes,
  ) {
    return ProviderScope(
      overrides: [
        fetchRoutesProvider.overrideWithValue(routes),
        fetchFilteredRoutes.overrideWithValue(filteredRoutes),
        crashlyticsApiProvider.overrideWithValue(mockCrashlyticsApi),
      ],
      child: MaterialApp(
        home: RouteListScreen(
          refreshProvider: fetchRoutesProvider,
          routeProvider: fetchFilteredRoutes,
        ),
      ),
    );
  }

  group('RouteListScreen', () {
    testWidgets('smoke test', (tester) async {
      await tester.pumpWidget(
        buildFrame(
          AsyncData([routeModel]),
          AsyncData(filteredRoutes),
        ),
      );
      expect(find.byType(RouteListScreen), findsOneWidget);
      expect(find.byType(RouteList), findsOneWidget);
      expect(find.text('Sorry, no available routes'), findsNothing);
    });

    testWidgets('empty list shows message', (tester) async {
      await tester.pumpWidget(
        buildFrame(
          AsyncData([]),
          AsyncData(emptyFilteredRoutes),
        ),
      );
      expect(find.byType(RouteListScreen), findsOneWidget);
      expect(find.byType(RouteList), findsOneWidget);
      expect(find.text('Sorry, no available routes'), findsOneWidget);
    });

    testWidgets('show ProgresIndicator on loading', (tester) async {
      await tester.pumpWidget(
        buildFrame(
          AsyncLoading(),
          AsyncLoading(),
        ),
      );
      expect(find.byType(RouteListScreen), findsOneWidget);
      expect(find.byType(RouteList), findsNothing);
      expect(find.byType(ErrorCard), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('show ErrorCard on error', (tester) async {
      await tester.pumpWidget(
        buildFrame(
          AsyncError('error'),
          AsyncError('error'),
        ),
      );
      expect(find.byType(RouteListScreen), findsOneWidget);
      expect(find.byType(RouteList), findsNothing);
      expect(find.byType(ErrorCard), findsOneWidget);
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

var filteredRoutes = RouteFilterModel(
  routes: [routeModel],
  filteredRoutes: [routeModel],
);

var emptyFilteredRoutes = RouteFilterModel(
  routes: [],
  filteredRoutes: [],
);
