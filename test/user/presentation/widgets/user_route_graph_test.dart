import 'package:charts_flutter/flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/user/infrastructure/models/user_rating_model.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:free_beta/user/presentation/widgets/user_route_graph.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockCrashlyticsApi mockCrashlyticsApi;

  setUp(() {
    mockCrashlyticsApi = MockCrashlyticsApi();
    when(() => mockCrashlyticsApi.logError(any(), any(), any(), any()))
        .thenAnswer((_) => Future.value());
  });

  Widget buildFrame(AsyncValue<List<Series<UserRatingModel, String>>> value) {
    return ProviderScope(
      overrides: [
        fetchRatingUserGraph(ClimbType.boulder).overrideWithValue(value),
        fetchRoutesProvider.overrideWithValue(AsyncData([routeModel])),
        crashlyticsApiProvider.overrideWithValue(mockCrashlyticsApi),
      ],
      child: MaterialApp(
        home: UserRouteGraph(
          climbType: ClimbType.boulder,
        ),
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame(AsyncData([])));

    expect(find.byType(BarChart), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byKey(Key('UserRouteGraph-error')), findsNothing);
  });

  testWidgets('loading shows progress indicator', (tester) async {
    await tester.pumpWidget(buildFrame(
      AsyncLoading(),
    ));

    expect(find.byType(BarChart), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byKey(Key('UserRouteGraph-error')), findsNothing);
  });

  testWidgets('error shows error card', (tester) async {
    await tester.pumpWidget(buildFrame(
      AsyncError(''),
    ));

    expect(find.byType(BarChart), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byKey(Key('UserRouteGraph-error')), findsOneWidget);
  });

  testWidgets('smoke test with real graph (yosemite)', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fetchRoutesProvider.overrideWithValue(
            AsyncData([routeModel, routeModel]),
          ),
          crashlyticsApiProvider.overrideWithValue(mockCrashlyticsApi),
        ],
        child: MaterialApp(
          home: UserRouteGraph(
            climbType: ClimbType.topRope,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(BarChart), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byKey(Key('UserRouteGraph-error')), findsNothing);
  });

  testWidgets('smoke test with real graph (boulder)', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fetchRoutesProvider.overrideWithValue(
            AsyncData([boulderRouteModel]),
          ),
          crashlyticsApiProvider.overrideWithValue(mockCrashlyticsApi),
        ],
        child: MaterialApp(
          theme: FreeBetaTheme.blueTheme,
          home: UserRouteGraph(
            climbType: ClimbType.boulder,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(BarChart), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byKey(Key('UserRouteGraph-error')), findsNothing);
  });
}

class MockCrashlyticsApi extends Mock implements CrashlyticsApi {}

var userRouteModel = UserRouteModel(
  routeId: 'abcd1234',
  userId: 'user1234',
  isCompleted: true,
  isFavorited: true,
);

var routeModel = RouteModel.fromFirebase('id', {
  'routeColor': 'yellow',
  'difficulty': '5.9',
  'images': [
    'https://firebasestorage.googleapis.com/v0/b/free-beta-d83c0.appspot.com/o/uploads%2FFile:%20\'%2Fprivate%2Fvar%2Fmobile%2FContainers%2FData%2FApplication%2F836DBD5F-8F61-4647-B080-F581325900CE%2Ftmp%2Fimage_picker_A5F519E1-AF13-483D-81C8-BA60BD2AF216-8669-00000167C2597C9C.jpg\'?alt=media&token=3ac1b090-a6ab-40b4-8a99-15b795b6ed3b',
    'https://firebasestorage.googleapis.com/v0/b/free-beta-d83c0.appspot.com/o/uploads%2FFile:%20\'%2Fprivate%2Fvar%2Fmobile%2FContainers%2FData%2FApplication%2F836DBD5F-8F61-4647-B080-F581325900CE%2Ftmp%2Fimage_picker_C6A5BA27-7674-4ED8-8208-B010A700ABD5-8669-00000167CDD678D0.jpg\'?alt=media&token=4d6c06bd-3e35-4adf-9316-f1c11a6fc955'
  ],
  'betaVideo': null,
  'name': 'Cunning Canary',
  'isActive': true,
  'creationDate': Timestamp(1661313600, 0),
  'wallLocationIndex': 0,
  'climbType': 'topRope',
  'wallLocation': 'tall',
});

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
