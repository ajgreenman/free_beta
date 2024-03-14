import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/user/infrastructure/models/user_model.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:free_beta/user/presentation/user_stats_screen.dart';
import 'package:free_beta/user/presentation/widgets/user_stats_card.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockCrashlyticsApi mockCrashlyticsApi;
  late MockRouteApi mockRouteApi;

  setUp(() {
    mockCrashlyticsApi = MockCrashlyticsApi();
    when(() => mockCrashlyticsApi.logError(any(), any(), any(), any()))
        .thenAnswer((_) => Future.value());

    mockRouteApi = MockRouteApi();
    when(() => mockRouteApi.getAllUserStats())
        .thenAnswer((_) => Future.value(userStatsModel));
    when(() => mockRouteApi.getActiveUserStats())
        .thenAnswer((_) => Future.value(userStatsModel));
  });

  Widget buildFrame() {
    return ProviderScope(
      overrides: [
        routeApiProvider.overrideWithValue(mockRouteApi),
        crashlyticsApiProvider.overrideWithValue(mockCrashlyticsApi),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: UserStatsCard(),
        ),
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame());

    await tester.pumpAndSettle();

    expect(find.byKey(Key('UserStatsCard-success')), findsOneWidget);
    expect(find.byKey(Key('UserStatsCard-skeleton')), findsNothing);
    expect(find.byKey(Key('UserStatsCard-error')), findsNothing);
    verify(() => mockRouteApi.getActiveUserStats()).called(1);
  });

  testWidgets('show loading on initial frame', (tester) async {
    await tester.pumpWidget(buildFrame());

    expect(find.byKey(Key('UserStatsCard-success')), findsNothing);
    expect(find.byKey(Key('UserStatsCard-skeleton')), findsOneWidget);
    expect(find.byKey(Key('UserStatsCard-error')), findsNothing);
  });

  testWidgets('show error when api errors', (tester) async {
    when(() => mockRouteApi.getActiveUserStats())
        .thenThrow(UnimplementedError());

    await tester.pumpWidget(buildFrame());

    await tester.pumpAndSettle();

    expect(find.byKey(Key('UserStatsCard-success')), findsNothing);
    expect(find.byKey(Key('UserStatsCard-skeleton')), findsNothing);
    expect(find.byKey(Key('UserStatsCard-error')), findsOneWidget);
    verify(() => mockRouteApi.getActiveUserStats()).called(1);
  });

  testWidgets('tapping section shows stats', (tester) async {
    await tester.pumpWidget(buildFrame());

    await tester.pumpAndSettle();

    var boulderButton = find.byKey(Key('UserStatsCard-section-boulders'));
    expect(boulderButton, findsOneWidget);

    await tester.tap(boulderButton);
    await tester.pumpAndSettle();

    expect(find.byType(UserStatsScreen), findsOneWidget);
    verify(() => mockRouteApi.getActiveUserStats()).called(1);
  });
}

class MockCrashlyticsApi extends Mock implements CrashlyticsApi {}

class MockRouteApi extends Mock implements RouteApi {}

var userStatsModel = UserStatsModel.fromRouteList([routeModel]);

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

var userModel = UserModel(
  email: 'test@test.com',
  uid: '1234',
  isAnonymous: false,
);
