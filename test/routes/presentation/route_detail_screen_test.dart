import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/text_field.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/presentation/route_detail_screen.dart';
import 'package:free_beta/user/infrastructure/models/user_model.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:free_beta/user/infrastructure/user_api.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockRouteApi mockRouteApi;

  setUp(() {
    mockRouteApi = MockRouteApi();
    registerFallbackValue(userRouteModel);
  });

  Widget buildFrame({isHelp = false}) {
    return ProviderScope(
      overrides: [
        authenticationProvider.overrideWithValue(AsyncData(userModel)),
        routeApiProvider.overrideWithValue(mockRouteApi),
        fetchRoutesProvider.overrideWithValue(AsyncData([])),
        fetchUserStatsProvider
            .overrideWithValue(AsyncData(UserStatsModel.fromRouteList([]))),
      ],
      child: MaterialApp(
        home: RouteDetailScreen(
          routeModel: routeModel,
          isHelp: isHelp,
        ),
      ),
    );
  }

  group('RouteDetailScreen', () {
    testWidgets('smoke test', (tester) async {
      await tester.pumpWidget(buildFrame());

      expect(find.byType(RouteDetailScreen), findsOneWidget);
      expect(find.text('This is a sample route, your changes cannot be saved.'),
          findsNothing);
    });

    testWidgets('isHelp shows HelpWarning card', (tester) async {
      await tester.pumpWidget(buildFrame(isHelp: true));
      expect(find.text('This is a sample route, your changes cannot be saved.'),
          findsOneWidget);
    });

    testWidgets('dialog appears on save', (tester) async {
      when(() => mockRouteApi.saveRoute(any()))
          .thenAnswer((_) => Future.value());

      await tester.pumpWidget(buildFrame());

      var favoritedCheckbox = find.byKey(Key('Checkbox-favorited'));
      expect(favoritedCheckbox, findsOneWidget);

      await tester.tap(favoritedCheckbox);
      await tester.pumpAndSettle();

      var scrollView = find.byType(SingleChildScrollView);
      expect(scrollView, findsOneWidget);

      await tester.drag(scrollView, const Offset(0.0, -500.0));
      await tester.pump();

      var saveButton = find.byKey(Key('ElevatedButton-save'));
      expect(saveButton, findsOneWidget);

      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Saved!'), findsOneWidget);
      verify(() => mockRouteApi.saveRoute(any())).called(1);
    });

    testWidgets('AreYouSure dialog shows exiting dirty form', (tester) async {
      when(() => mockRouteApi.saveRoute(any()))
          .thenAnswer((_) => Future.value());

      await tester.pumpWidget(buildFrame());

      var addAttemptButton = find.byKey(Key('FreeBetaNumberInput-add'));
      expect(addAttemptButton, findsOneWidget);

      await tester.tap(addAttemptButton);
      await tester.pumpAndSettle();

      var subAttemptButton = find.byKey(Key('FreeBetaNumberInput-subtract'));
      expect(subAttemptButton, findsOneWidget);

      await tester.tap(subAttemptButton);
      await tester.pumpAndSettle();

      var completedCheckbox = find.byKey(Key('Checkbox-completed'));
      expect(completedCheckbox, findsOneWidget);

      await tester.tap(completedCheckbox);
      await tester.pumpAndSettle();

      var favoritedCheckbox = find.byKey(Key('Checkbox-favorited'));
      expect(favoritedCheckbox, findsOneWidget);

      await tester.tap(favoritedCheckbox);
      await tester.pumpAndSettle();

      var notesField = find.byType(FreeBetaTextField);
      expect(notesField, findsOneWidget);

      await tester.enterText(notesField, 'test');
      await tester.pumpAndSettle();

      var backButton = find.byType(FreeBetaBackButton);
      expect(backButton, findsOneWidget);

      await tester.tap(backButton);
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Are you sure?'), findsOneWidget);

      var saveAndExitButton = find.text('Save & Exit');
      expect(saveAndExitButton, findsOneWidget);

      await tester.tap(saveAndExitButton);
      await tester.pumpAndSettle();

      verify(() => mockRouteApi.saveRoute(any())).called(1);
    });
  });
}

class MockRouteApi extends Mock implements RouteApi {}

var userRouteModel = UserRouteModel(
  routeId: 'abcd1234',
  userId: 'user1234',
  isCompleted: false,
  isFavorited: false,
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
  isAnonymous: true,
);
