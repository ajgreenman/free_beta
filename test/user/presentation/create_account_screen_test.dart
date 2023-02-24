import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/user/infrastructure/models/user_model.dart';
import 'package:free_beta/user/infrastructure/user_api.dart';
import 'package:free_beta/user/infrastructure/user_providers.dart';
import 'package:free_beta/user/presentation/create_account_screen.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockCrashlyticsApi mockCrashlyticsApi;
  late MockUserApi mockUserApi;

  setUp(() {
    mockCrashlyticsApi = MockCrashlyticsApi();
    when(() => mockCrashlyticsApi.logError(any(), any(), any(), any()))
        .thenAnswer((_) => Future.value());

    mockUserApi = MockUserApi();
    when(() => mockUserApi.checkGymPassword(any()))
        .thenAnswer((_) => Future.value(true));
    when(() => mockUserApi.signUp(any(), any()))
        .thenAnswer((_) => Future.value(true));
  });

  Widget buildFrame(UserModel? user) {
    return ProviderScope(
      overrides: [
        authenticationProvider.overrideWith((_) => Stream.value(user)),
        crashlyticsApiProvider.overrideWith((_) => mockCrashlyticsApi),
        userApiProvider.overrideWith((_) => mockUserApi),
      ],
      child: MaterialApp(
        home: CreateAccountScreen(),
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame(anonymousUserModel));
    await tester.pump();

    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('successful create account', (tester) async {
    await tester.pumpWidget(buildFrame(anonymousUserModel));
    await tester.pump();

    await _fillOutForm(tester);

    await _tapCreateAccount(tester);

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Success!'), findsOneWidget);
    expect(find.text('Invalid gym password'), findsNothing);
    expect(find.text('Unable to create account'), findsNothing);
  });

  testWidgets('wrong gym password shows dialog', (tester) async {
    when(() => mockUserApi.checkGymPassword(any()))
        .thenAnswer((_) => Future.value(false));

    await tester.pumpWidget(buildFrame(anonymousUserModel));
    await tester.pump();

    await _fillOutForm(tester);

    await _tapCreateAccount(tester);

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Success!'), findsNothing);
    expect(find.text('Invalid gym password'), findsNWidgets(2));
    expect(find.text('Unable to create account'), findsNothing);
  });

  testWidgets('error on signUp shows dialog', (tester) async {
    when(() => mockUserApi.signUp(any(), any()))
        .thenAnswer((_) => Future.value(false));

    await tester.pumpWidget(buildFrame(anonymousUserModel));
    await tester.pump();

    await _fillOutForm(tester);

    await _tapCreateAccount(tester);

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Success!'), findsNothing);
    expect(find.text('Invalid gym password'), findsNothing);
    expect(find.text('Unable to create account'), findsOneWidget);
  });

  testWidgets('logged in user shows loading', (tester) async {
    await tester.pumpWidget(buildFrame(userModel));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}

Future<void> _tapCreateAccount(WidgetTester tester) async {
  var createAccountButton = find.byKey(Key('CreateAccountScreen-create'));
  expect(createAccountButton, findsOneWidget);

  await tester.tap(createAccountButton);
  await tester.pumpAndSettle();
}

Future<void> _fillOutForm(WidgetTester tester) async {
  var emailInput = find.byKey(Key('CreateAccountScreen-email'));
  expect(emailInput, findsOneWidget);

  await tester.enterText(emailInput, 'test@test.com');
  await tester.pumpAndSettle();

  var passwordInput = find.byKey(Key('CreateAccountScreen-password'));
  expect(passwordInput, findsOneWidget);

  await tester.enterText(passwordInput, 'abcd1234');
  await tester.pumpAndSettle();

  var confirmInput = find.byKey(Key('CreateAccountScreen-confirm'));
  expect(confirmInput, findsOneWidget);

  await tester.enterText(confirmInput, 'abcd1234');
  await tester.pumpAndSettle();

  var gymPasswordInput = find.byKey(Key('CreateAccountScreen-gymPassword'));
  expect(gymPasswordInput, findsOneWidget);

  await tester.enterText(gymPasswordInput, 'hard-rock-life');
  await tester.pumpAndSettle();
}

class MockCrashlyticsApi extends Mock implements CrashlyticsApi {}

class MockUserApi extends Mock implements UserApi {}

var anonymousUserModel = UserModel(
  email: 'test@test.com',
  uid: '1234',
  isAnonymous: true,
);

var userModel = UserModel(
  email: 'test@test.com',
  uid: '1234',
  isAnonymous: false,
);
