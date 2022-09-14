import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/user/infrastructure/models/user_model.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:free_beta/user/presentation/user_stats_screen.dart';
import 'package:free_beta/user/presentation/widgets/user_stats_card.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockCrashlyticsApi mockCrashlyticsApi;

  setUp(() {
    mockCrashlyticsApi = MockCrashlyticsApi();
    when(() => mockCrashlyticsApi.logError(any(), any(), any(), any()))
        .thenAnswer((_) => Future.value());
  });

  Widget buildFrame(AsyncValue<UserStatsModel> value) {
    return ProviderScope(
      overrides: [
        fetchUserStatsProvider.overrideWithValue(value),
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
    await tester.pumpWidget(buildFrame(AsyncData(userStatsModel)));

    expect(find.byKey(Key('UserStatsCard-success')), findsOneWidget);
    expect(find.byKey(Key('UserStatsCard-skeleton')), findsNothing);
    expect(find.byKey(Key('UserStatsCard-error')), findsNothing);
  });

  testWidgets('loading shows skeleton', (tester) async {
    await tester.pumpWidget(buildFrame(AsyncLoading()));

    expect(find.byKey(Key('UserStatsCard-success')), findsNothing);
    expect(find.byKey(Key('UserStatsCard-skeleton')), findsOneWidget);
    expect(find.byKey(Key('UserStatsCard-error')), findsNothing);
  });

  testWidgets('error shows error', (tester) async {
    await tester.pumpWidget(buildFrame(AsyncError('')));

    expect(find.byKey(Key('UserStatsCard-success')), findsNothing);
    expect(find.byKey(Key('UserStatsCard-skeleton')), findsNothing);
    expect(find.byKey(Key('UserStatsCard-error')), findsOneWidget);
  });

  testWidgets('tapping section shows stats', (tester) async {
    await tester.pumpWidget(buildFrame(AsyncData(userStatsModel)));

    var boulderButton = find.byKey(Key('UserStatsCard-section-boulders'));
    expect(boulderButton, findsOneWidget);

    await tester.tap(boulderButton);
    await tester.pumpAndSettle();

    expect(find.byType(UserStatsScreen), findsOneWidget);
  });
}

class MockCrashlyticsApi extends Mock implements CrashlyticsApi {}

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
