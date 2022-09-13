import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/infrastructure/media_api.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/gym/presentation/create_route_screen.dart';
import 'package:free_beta/gym/presentation/route_form.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockMediaApi mockMediaApi;
  late MockRouteApi mockRouteApi;

  setUp(() {
    mockMediaApi = MockMediaApi();
    mockRouteApi = MockRouteApi();

    registerFallbackValue(ImageSource.camera);
    registerFallbackValue(routeFormModel);

    when(() => mockMediaApi.fetchImage(any()))
        .thenAnswer((_) => Future.value(''));
    when(() => mockMediaApi.fetchVideo(any()))
        .thenAnswer((_) => Future.value(''));
  });

  Widget buildFrame() {
    return ProviderScope(
      overrides: [
        mediaApiProvider.overrideWithValue(mockMediaApi),
      ],
      child: MaterialApp(
        home: CreateRouteScreen(),
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame());

    expect(find.byType(RouteForm), findsOneWidget);
    expect(find.byKey(Key('RouteForm-createRoute')), findsOneWidget);
    expect(find.byKey(Key('RouteForm-editRoute')), findsNothing);
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

  testWidgets('adding image and video alone will not create a route',
      (tester) async {
    await tester.pumpWidget(buildFrame());

    var imageInput = find.byKey(Key('RouteForm-images'));
    expect(imageInput, findsOneWidget);

    await tester.tap(imageInput);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);

    await tester.tap(find.text('Photos'));
    await tester.pumpAndSettle();

    var videoInput = find.byKey(Key('RouteForm-video'));
    expect(videoInput, findsOneWidget);

    await tester.tap(videoInput);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);

    await tester.tap(find.text('Camera'));
    await tester.pumpAndSettle();

    var createRouteButton = find.byKey(Key('RouteForm-createRoute'));
    expect(createRouteButton, findsOneWidget);

    await tester.ensureVisible(createRouteButton);
    await tester.pumpAndSettle();

    await tester.tap(createRouteButton);
    await tester.pumpAndSettle();

    verifyNever(() => mockRouteApi.addRoute(any()));
  });
}

class MockRouteApi extends Mock implements RouteApi {}

class MockMediaApi extends Mock implements MediaApi {}

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
