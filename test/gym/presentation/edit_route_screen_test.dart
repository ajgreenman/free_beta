import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/gym/presentation/edit_route_screen.dart';
import 'package:free_beta/gym/presentation/route_form.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockRouteApi mockRouteApi;

  setUp(() {
    mockRouteApi = MockRouteApi();
    registerFallbackValue(routeModel);
    registerFallbackValue(routeFormModel);

    when(() => mockRouteApi.updateRoute(any(), any()))
        .thenAnswer((_) => Future.value());
  });

  Widget buildFrame() {
    return ProviderScope(
      overrides: [
        routeApiProvider.overrideWithValue(mockRouteApi),
      ],
      child: MaterialApp(
        home: EditRouteScreen(routeModel: routeModel),
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame());

    expect(find.byType(RouteForm), findsOneWidget);
    expect(find.byKey(Key('RouteForm-createRoute')), findsNothing);
    expect(find.byKey(Key('RouteForm-editRoute')), findsOneWidget);
  });

  testWidgets('tapping back with clean form pops', (tester) async {
    await tester.pumpWidget(buildFrame());

    await tester.tap(find.byType(FreeBetaBackButton));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Are you sure?'), findsNothing);
  });

  testWidgets('tapping back with dirty form opens dialog', (tester) async {
    await tester.pumpWidget(buildFrame());

    var nameInput = find.byKey(Key('RouteForm-name'));
    expect(nameInput, findsOneWidget);

    await tester.enterText(nameInput, 'Test');
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FreeBetaBackButton));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Are you sure?'), findsOneWidget);

    await tester.tap(find.text('Exit'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('tapping delete opens dialog', (tester) async {
    when(() => mockRouteApi.deleteRoute(any()))
        .thenAnswer((_) => Future.value());

    await tester.pumpWidget(buildFrame());

    var deleteButton = find.byKey(Key('EditRouteScreen-delete'));
    expect(deleteButton, findsOneWidget);

    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Are you sure?'), findsOneWidget);
    expect(find.text('Route deleted!'), findsNothing);

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Are you sure?'), findsNothing);
    expect(find.text('Route deleted!'), findsOneWidget);
  });

  testWidgets('edit route calls update route and shows dialog', (tester) async {
    await tester.pumpWidget(buildFrame());

    var creationDateButton = find.byKey(Key('RouteForm-creationDate'));
    expect(creationDateButton, findsOneWidget);

    await tester.ensureVisible(creationDateButton);
    await tester.pumpAndSettle();

    await tester.tap(creationDateButton);
    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    var removalDateButton = find.byKey(Key('RouteForm-removalDate'));
    expect(removalDateButton, findsOneWidget);

    await tester.ensureVisible(removalDateButton);
    await tester.pumpAndSettle();

    await tester.tap(removalDateButton);
    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    var editRouteButton = find.byKey(Key('RouteForm-editRoute'));
    expect(editRouteButton, findsOneWidget);

    await tester.tap(editRouteButton);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    verify(() => mockRouteApi.updateRoute(any(), any())).called(1);
  });
}

class MockRouteApi extends Mock implements RouteApi {}

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
  removalDate: DateTime.now(),
  boulderRating: BoulderRating.v0,
  userRouteModel: userRouteModel,
);

var routeFormModel = RouteFormModel.fromRouteModel(routeModel);
