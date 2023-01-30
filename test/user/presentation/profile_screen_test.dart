import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/routes/presentation/route_list_screen.dart';
import 'package:free_beta/user/infrastructure/models/user_model.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:free_beta/user/infrastructure/user_providers.dart';
import 'package:free_beta/user/presentation/contact_developer_screen.dart';
import 'package:free_beta/user/presentation/profile_screen.dart';
import 'package:free_beta/user/presentation/widgets/user_stats_card.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockCrashlyticsApi mockCrashlyticsApi;

  setUp(() {
    mockCrashlyticsApi = MockCrashlyticsApi();
    when(() => mockCrashlyticsApi.logError(any(), any(), any(), any()))
        .thenAnswer((_) => Future.value());
  });

  Widget buildFrame(UserModel? user) {
    return ProviderScope(
      overrides: [
        fetchUserStatsProvider.overrideWithValue(AsyncData(userStatsModel)),
        authenticationProvider.overrideWithValue(AsyncData(user)),
        crashlyticsApiProvider.overrideWithValue(mockCrashlyticsApi),
      ],
      child: MaterialApp(
        home: ProfileScreen(),
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame(null));

    expect(find.byType(UserStatsCard), findsOneWidget);
    expect(find.byType(InfoCard), findsNWidgets(2));
    expect(find.byType(RouteListScreen), findsNothing);
  });

  testWidgets('tap remove routes', (tester) async {
    await tester.pumpWidget(buildFrame(userModel));

    var removeRouteCard = find.byKey(Key('ProfileScreen-removedRoutes'));
    expect(removeRouteCard, findsOneWidget);

    await tester.ensureVisible(removeRouteCard);
    await tester.pumpAndSettle();

    await tester.tap(removeRouteCard);
    await tester.pumpAndSettle();

    expect(find.byType(UserStatsCard), findsNothing);
    expect(find.byType(InfoCard), findsNothing);
    expect(find.byType(RouteListScreen), findsOneWidget);
  });

  testWidgets('tap contact developer', (tester) async {
    await tester.pumpWidget(buildFrame(userModel));

    var contactButton = find.byKey(Key('ProfileScreen-contact'));
    expect(contactButton, findsOneWidget);

    await tester.ensureVisible(contactButton);
    await tester.pumpAndSettle();

    await tester.tap(contactButton);
    await tester.pumpAndSettle();

    expect(find.byType(UserStatsCard), findsNothing);
    expect(find.byType(InfoCard), findsNothing);
    expect(find.byType(ContactDeveloperScreen), findsOneWidget);
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
