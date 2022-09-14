import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
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
    registerFallbackValue(boulderRouteModel);
    registerFallbackValue(routeFormModel);

    when(() => mockRouteApi.updateRoute(any(), any()))
        .thenAnswer((_) => Future.value());
  });

  Widget buildFrame(RouteModel route) {
    return ProviderScope(
      overrides: [
        routeApiProvider.overrideWithValue(mockRouteApi),
      ],
      child: MaterialApp(
        home: EditRouteScreen(routeModel: route),
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame(boulderRouteModel));

    expect(find.byType(RouteForm), findsOneWidget);
    expect(find.byKey(Key('RouteForm-createRoute')), findsNothing);
    expect(find.byKey(Key('RouteForm-editRoute')), findsOneWidget);
  });

  testWidgets('tapping back with clean form pops', (tester) async {
    await tester.pumpWidget(buildFrame(boulderRouteModel));

    await tester.tap(find.byType(FreeBetaBackButton));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Are you sure?'), findsNothing);
  });

  testWidgets('tapping back with dirty form opens dialog - exit',
      (tester) async {
    await tester.pumpWidget(buildFrame(yosemiteRouteModel));

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

  testWidgets('tapping back with dirty form opens dialog - cancel',
      (tester) async {
    await tester.pumpWidget(buildFrame(yosemiteRouteModel));

    var nameInput = find.byKey(Key('RouteForm-name'));
    expect(nameInput, findsOneWidget);

    await tester.enterText(nameInput, 'Test');
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FreeBetaBackButton));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Are you sure?'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('tapping delete opens dialog - delete', (tester) async {
    when(() => mockRouteApi.deleteRoute(any()))
        .thenAnswer((_) => Future.value());

    await tester.pumpWidget(buildFrame(boulderRouteModel));

    await _tapDeleteButton(tester);

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Are you sure?'), findsOneWidget);
    expect(find.text('Route deleted!'), findsNothing);

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Are you sure?'), findsNothing);
    expect(find.text('Route deleted!'), findsOneWidget);
  });

  testWidgets('tapping delete opens dialog - cancel', (tester) async {
    when(() => mockRouteApi.deleteRoute(any()))
        .thenAnswer((_) => Future.value());

    await tester.pumpWidget(buildFrame(boulderRouteModel));

    await _tapDeleteButton(tester);

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Are you sure?'), findsOneWidget);
    expect(find.text('Route deleted!'), findsNothing);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Are you sure?'), findsNothing);
    expect(find.text('Route deleted!'), findsNothing);
  });

  testWidgets('edit route calls update route and shows dialog', (tester) async {
    await tester.pumpWidget(buildFrame(boulderRouteModel));

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

Future<void> _tapDeleteButton(WidgetTester tester) async {
  var deleteButton = find.byKey(Key('EditRouteScreen-delete'));
  expect(deleteButton, findsOneWidget);

  await tester.tap(deleteButton);
  await tester.pumpAndSettle();
}

class MockRouteApi extends Mock implements RouteApi {}

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

var boulderRouteModel = RouteModel.fromFirebase('id', {
  'routeColor': 'yellow',
  'difficulty': 'consensus',
  'images': [
    'https://firebasestorage.googleapis.com/v0/b/free-beta-d83c0.appspot.com/o/uploads%2FFile:%20\'%2Fprivate%2Fvar%2Fmobile%2FContainers%2FData%2FApplication%2F836DBD5F-8F61-4647-B080-F581325900CE%2Ftmp%2Fimage_picker_A5F519E1-AF13-483D-81C8-BA60BD2AF216-8669-00000167C2597C9C.jpg\'?alt=media&token=3ac1b090-a6ab-40b4-8a99-15b795b6ed3b',
    'https://firebasestorage.googleapis.com/v0/b/free-beta-d83c0.appspot.com/o/uploads%2FFile:%20\'%2Fprivate%2Fvar%2Fmobile%2FContainers%2FData%2FApplication%2F836DBD5F-8F61-4647-B080-F581325900CE%2Ftmp%2Fimage_picker_C6A5BA27-7674-4ED8-8208-B010A700ABD5-8669-00000167CDD678D0.jpg\'?alt=media&token=4d6c06bd-3e35-4adf-9316-f1c11a6fc955'
  ],
  'betaVideo': null,
  'name': 'Cunning Canary',
  'isActive': true,
  'creationDate': Timestamp(1661313600, 0),
  'wallLocationIndex': 0,
  'climbType': 'boulder',
  'wallLocation': 'boulder',
});

var yosemiteRouteModel = RouteModel.fromFirebase('id', {
  'routeColor': 'yellow',
  'difficulty': '5.13+',
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

var routeFormModel = RouteFormModel.fromRouteModel(boulderRouteModel);
