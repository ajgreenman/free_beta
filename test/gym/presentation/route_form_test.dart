import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/infrastructure/media_api.dart';
import 'package:free_beta/gym/presentation/route_form.dart';
import 'package:free_beta/gym/presentation/widgets/gym_section.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockMediaApi mockMediaApi;
  late MockRouteApi mockRouteApi;

  setUp(() {
    mockMediaApi = MockMediaApi();
    registerFallbackValue(ImageSource.camera);
    when(() => mockMediaApi.fetchImage(any()))
        .thenAnswer((_) => Future.value(''));

    mockRouteApi = MockRouteApi();
    registerFallbackValue(routeModel);
    registerFallbackValue(RouteFormModel());
    when(() => mockRouteApi.addRoute(any())).thenAnswer((_) => Future.value());
    when(() => mockRouteApi.updateRoute(any(), any()))
        .thenAnswer((_) => Future.value());
  });

  Widget buildFrame(RouteModel? routeModel) {
    return ProviderScope(
      overrides: [
        routeApiProvider.overrideWithValue(mockRouteApi),
        mediaApiProvider.overrideWithValue(mockMediaApi),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: RouteForm(
            setDirtyForm: () {},
            editRouteModel: routeModel,
          ),
        ),
      ),
    );
  }

  group('new route', () {
    testWidgets('smoke test', (tester) async {
      await tester.pumpWidget(buildFrame(null));

      expect(find.byType(Form), findsOneWidget);
      expect(find.byKey(Key('RouteForm-name')), findsOneWidget);
      expect(find.byKey(Key('RouteForm-images')), findsOneWidget);
      expect(find.byKey(Key('RouteForm-video')), findsOneWidget);
      expect(find.byKey(Key('RouteForm-location')), findsOneWidget);
      expect(find.byKey(Key('RouteForm-color')), findsOneWidget);
      expect(find.byKey(Key('RouteForm-type')), findsOneWidget);
      expect(find.byKey(Key('RouteForm-creationDate')), findsOneWidget);
      expect(find.byKey(Key('RouteForm-createRoute')), findsOneWidget);
    });

    testWidgets('setting every value allows you to submit form',
        (tester) async {
      await tester.pumpWidget(buildFrame(null));

      await _setImage(tester);

      await _setLocationAndIndex(tester);

      await _setColor(tester);

      await _setTypeAndRating(tester);

      await _setCreationDate(tester);

      await _createRoute(tester);

      var confirmationDialog = find.byType(AlertDialog);
      expect(confirmationDialog, findsOneWidget);
      verify(() => mockRouteApi.addRoute(any())).called(1);
    });
  });

  group('edit route', () {
    testWidgets('smoke test', (tester) async {
      await tester.pumpWidget(buildFrame(routeModel));

      expect(find.byType(Form), findsOneWidget);
      expect(find.byKey(Key('RouteForm-name')), findsOneWidget);
      expect(find.byKey(Key('RouteForm-images')), findsOneWidget);
      expect(find.byKey(Key('RouteForm-video')), findsOneWidget);
      expect(find.byKey(Key('RouteForm-location')), findsOneWidget);
      expect(find.byKey(Key('RouteForm-color')), findsOneWidget);
      expect(find.byKey(Key('RouteForm-type')), findsOneWidget);
      expect(find.byKey(Key('RouteForm-creationDate')), findsOneWidget);
      expect(find.byKey(Key('RouteForm-removalDate')), findsOneWidget);
      expect(find.byKey(Key('RouteForm-editRoute')), findsOneWidget);
    });

    testWidgets('modifying value allows you to submit form', (tester) async {
      await tester.pumpWidget(buildFrame(routeModel));

      var yosemiteRatingInput = find.byKey(Key('RouteForm-yosemiteRating'));
      expect(yosemiteRatingInput, findsOneWidget);

      await tester.ensureVisible(yosemiteRatingInput);
      await tester.pumpAndSettle();

      await tester.tap(yosemiteRatingInput);
      await tester.pumpAndSettle();

      var speedRating = find.byKey(Key('RouteForm-rating-speed'));
      expect(speedRating, findsOneWidget);

      await tester.tap(speedRating, warnIfMissed: false);
      await tester.pumpAndSettle();

      await _editRoute(tester);

      var confirmationDialog = find.byType(AlertDialog);
      expect(confirmationDialog, findsOneWidget);
      verify(() => mockRouteApi.updateRoute(any(), any())).called(1);
    });
  });
}

Future<void> _setImage(WidgetTester tester) async {
  var imageInput = find.byKey(Key('RouteForm-images'));
  expect(imageInput, findsOneWidget);

  await tester.tap(imageInput);
  await tester.pumpAndSettle();

  expect(find.byType(AlertDialog), findsOneWidget);

  await tester.tap(find.text('Photos'));
  await tester.pumpAndSettle();
}

Future<void> _setLocationAndIndex(WidgetTester tester) async {
  expect(find.byKey(Key('RouteForm-section')), findsNothing);

  var locationInput = find.byKey(Key('RouteForm-location'));
  expect(locationInput, findsOneWidget);

  await tester.tap(locationInput);
  await tester.pumpAndSettle();

  var boulderLocation = find.byKey(Key('RouteForm-location-boulder'));
  expect(boulderLocation, findsOneWidget);

  await tester.tap(boulderLocation, warnIfMissed: false);
  await tester.pumpAndSettle();

  var sectionInput = find.byKey(Key('RouteForm-section'));
  expect(sectionInput, findsOneWidget);

  await tester.tap(sectionInput);
  await tester.pumpAndSettle();

  var firstSection = find.byType(GymSection).first;
  expect(firstSection, findsOneWidget);

  await tester.tap(firstSection);
  await tester.pumpAndSettle();
}

Future<void> _setColor(WidgetTester tester) async {
  var colorDropdown = find.byKey(Key('RouteForm-color'));
  expect(colorDropdown, findsOneWidget);

  await tester.ensureVisible(colorDropdown);
  await tester.pumpAndSettle();

  await tester.tap(colorDropdown);
  await tester.pumpAndSettle();

  var colorInput = find.byKey(Key('RouteForm-color-black'));
  expect(colorInput, findsOneWidget);

  await tester.tap(colorInput, warnIfMissed: false);
  await tester.pumpAndSettle();
}

Future<void> _setTypeAndRating(WidgetTester tester) async {
  var typeInput = find.byKey(Key('RouteForm-type'));
  expect(typeInput, findsOneWidget);

  await tester.ensureVisible(typeInput);
  await tester.pumpAndSettle();

  await tester.tap(typeInput);
  await tester.pumpAndSettle();

  var boulderLocation = find.byKey(Key('RouteForm-type-boulder'));
  expect(boulderLocation, findsOneWidget);

  await tester.tap(boulderLocation, warnIfMissed: false);
  await tester.pumpAndSettle();

  var boulderRatingInput = find.byKey(Key('RouteForm-boulderRating'));
  expect(boulderRatingInput, findsOneWidget);

  await tester.tap(boulderRatingInput);
  await tester.pumpAndSettle();

  var v0Rating = find.byKey(Key('RouteForm-rating-v0'));
  expect(v0Rating, findsOneWidget);

  await tester.tap(v0Rating, warnIfMissed: false);
  await tester.pumpAndSettle();
}

Future<void> _setCreationDate(WidgetTester tester) async {
  var creationDateButton = find.byKey(Key('RouteForm-creationDate'));
  expect(creationDateButton, findsOneWidget);

  await tester.ensureVisible(creationDateButton);
  await tester.pumpAndSettle();

  await tester.tap(creationDateButton);
  await tester.pumpAndSettle();

  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();
}

Future<void> _createRoute(WidgetTester tester) async {
  var createRouteButton = find.byKey(Key('RouteForm-createRoute'));
  expect(createRouteButton, findsOneWidget);

  await tester.ensureVisible(createRouteButton);
  await tester.pumpAndSettle();

  await tester.tap(createRouteButton);
  await tester.pumpAndSettle();
}

Future<void> _editRoute(WidgetTester tester) async {
  var editRouteButton = find.byKey(Key('RouteForm-editRoute'));
  expect(editRouteButton, findsOneWidget);

  await tester.ensureVisible(editRouteButton);
  await tester.pumpAndSettle();

  await tester.tap(editRouteButton);
  await tester.pumpAndSettle();
}

class MockRouteApi extends Mock implements RouteApi {}

class MockMediaApi extends Mock implements MediaApi {}

var routeModel = RouteModel(
  id: '',
  climbType: ClimbType.topRope,
  routeColor: RouteColor.black,
  wallLocation: WallLocation.boulder,
  wallLocationIndex: 0,
  creationDate: DateTime.now().subtract(Duration(days: 1)),
  removalDate: DateTime.now(),
  yosemiteRating: YosemiteRating.competition,
);
