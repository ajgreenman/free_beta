import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/user/infrastructure/models/user_model.dart';
import 'package:free_beta/user/infrastructure/user_api.dart';
import 'package:free_beta/user/infrastructure/user_providers.dart';
import 'package:free_beta/user/presentation/sign_in_screen.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockCrashlyticsApi mockCrashlyticsApi;
  late MockUserApi mockUserApi;

  setUp(() {
    mockCrashlyticsApi = MockCrashlyticsApi();
    when(() => mockCrashlyticsApi.logError(any(), any(), any(), any()))
        .thenAnswer((_) => Future.value());

    mockUserApi = MockUserApi();
    when(() => mockUserApi.signIn(any(), any()))
        .thenAnswer((_) => Future.value(true));
  });

  Widget buildFrame(AsyncValue<UserModel?> user) {
    return ProviderScope(
      overrides: [
        authenticationProvider.overrideWithValue(user),
        crashlyticsApiProvider.overrideWithValue(mockCrashlyticsApi),
        userApiProvider.overrideWithValue(mockUserApi),
      ],
      child: MaterialApp(
        home: SignInScreen(),
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame(AsyncData(anonymousUserModel)));

    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('successful create account', (tester) async {
    await tester.pumpWidget(buildFrame(AsyncData(anonymousUserModel)));

    await _fillOutForm(tester);

    await _tapSignIn(tester);

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Invalid sign in'), findsNothing);
    verify(() => mockUserApi.signIn(any(), any())).called(1);
  });

  testWidgets('error on signIn shows dialog', (tester) async {
    when(() => mockUserApi.signIn(any(), any()))
        .thenAnswer((_) => Future.value(false));

    await tester.pumpWidget(buildFrame(AsyncData(anonymousUserModel)));

    await _fillOutForm(tester);

    await _tapSignIn(tester);

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Invalid sign in'), findsOneWidget);
  });

  testWidgets('logged in user shows loading', (tester) async {
    await tester.pumpWidget(buildFrame(AsyncData(userModel)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('loading value shows loading', (tester) async {
    await tester.pumpWidget(buildFrame(AsyncLoading()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('error value shows error', (tester) async {
    await tester.pumpWidget(buildFrame(AsyncError('')));

    expect(find.byType(ErrorCard), findsOneWidget);
    verify(() => mockCrashlyticsApi.logError(any(), any(), any(), any()))
        .called(1);
  });
}

Future<void> _tapSignIn(WidgetTester tester) async {
  var signInButton = find.byKey(Key('SignInScreen-signIn'));
  expect(signInButton, findsOneWidget);

  await tester.tap(signInButton);
  await tester.pumpAndSettle();
}

Future<void> _fillOutForm(WidgetTester tester) async {
  var emailInput = find.byKey(Key('SignInScreen-email'));
  expect(emailInput, findsOneWidget);

  await tester.enterText(emailInput, 'test@test.com');
  await tester.pumpAndSettle();

  var passwordInput = find.byKey(Key('SignInScreen-password'));
  expect(passwordInput, findsOneWidget);

  await tester.enterText(passwordInput, 'abcd1234');
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
