import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/infrastructure/email_api.dart';
import 'package:free_beta/user/infrastructure/models/feedback_form_model.dart';
import 'package:free_beta/user/presentation/contact_developer_screen.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockEmailApi mockEmailApi;

  setUp(() {
    mockEmailApi = MockEmailApi();
    registerFallbackValue(feedbackFormModel);

    when(() => mockEmailApi.sendEmail(any()))
        .thenAnswer((_) => Future.value(true));
  });

  Widget buildFrame() {
    return ProviderScope(
      overrides: [
        emailApiProvider.overrideWithValue(mockEmailApi),
      ],
      child: MaterialApp(
        home: ContactDeveloperScreen(),
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame());

    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('successful form entry', (tester) async {
    await tester.pumpWidget(buildFrame());

    await _fillOutForm(tester);

    await _tapSend(tester);

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Success'), findsOneWidget);
    expect(find.text('Error'), findsNothing);
  });

  testWidgets('error form entry', (tester) async {
    when(() => mockEmailApi.sendEmail(any()))
        .thenAnswer((_) => Future.value(false));
    await tester.pumpWidget(buildFrame());

    await _fillOutForm(tester);

    await _tapSend(tester);

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Success'), findsNothing);
    expect(find.text('Error'), findsOneWidget);
  });
}

Future<void> _tapSend(WidgetTester tester) async {
  var scrollView = find.byType(SingleChildScrollView);
  expect(scrollView, findsOneWidget);

  await tester.drag(scrollView, const Offset(0.0, -500.0));
  await tester.pump();

  var sendButton = find.byKey(Key('ContactDeveloperScreen-send'));
  expect(sendButton, findsOneWidget);

  await tester.tap(sendButton);
  await tester.pumpAndSettle();
}

Future<void> _fillOutForm(WidgetTester tester) async {
  var nameField = find.byKey(Key('ContactDeveloperScreen-name'));
  expect(nameField, findsOneWidget);

  await tester.enterText(nameField, 'test');
  await tester.pumpAndSettle();
  var emailField = find.byKey(Key('ContactDeveloperScreen-email'));
  expect(emailField, findsOneWidget);

  await tester.enterText(emailField, 'test@test.test');
  await tester.pumpAndSettle();

  var commentsField = find.byKey(Key('ContactDeveloperScreen-comments'));
  expect(commentsField, findsOneWidget);

  await tester.enterText(commentsField, 'test');
  await tester.pumpAndSettle();
}

class MockEmailApi extends Mock implements EmailApi {}

var feedbackFormModel = FeedbackFormModel(
  name: 'Test',
  category: FeedbackCategory.suggestion,
  comments: 'Test',
);
