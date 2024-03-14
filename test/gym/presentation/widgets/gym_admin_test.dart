import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/gym/presentation/widgets/gym_admin.dart';
import 'package:free_beta/user/infrastructure/user_providers.dart';
import 'package:free_beta/user/infrastructure/user_remote_data_provider.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockNavigatorObserver mockNavigatorObserver;
  late MockUserRemoteDataProvider mockUserRemoteDataProvider;

  setUp(() {
    mockNavigatorObserver = MockNavigatorObserver();
    mockUserRemoteDataProvider = MockUserRemoteDataProvider();

    registerFallbackValue(MockRoute());
  });

  Widget buildFrame() {
    return ProviderScope(
      overrides: [
        userApiProvider.overrideWithValue(mockUserRemoteDataProvider),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: GymAdmin(),
        ),
        navigatorObservers: [mockNavigatorObserver],
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame());

    expect(find.text('Gym Admin'), findsOneWidget);
    expect(find.byType(InfoCard), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(2));
  });

  testWidgets('tapping create route pushes CreateRouteScreen', (tester) async {
    await tester.pumpWidget(buildFrame());

    var createRouteButton = find.byKey(Key('GymAdmin-create'));
    expect(createRouteButton, findsOneWidget);

    await tester.tap(createRouteButton);
    await tester.pumpAndSettle();

    verify(() => mockNavigatorObserver.didPush(any(), any())).called(2);
  });

  testWidgets('tapping delete account shows dialog', (tester) async {
    await tester.pumpWidget(buildFrame());

    var deleteAccountButton = find.byKey(Key('GymAdmin-delete'));
    expect(deleteAccountButton, findsOneWidget);

    await tester.tap(deleteAccountButton);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('tapping delete on delete dialog calls userApi', (tester) async {
    when(() => mockUserRemoteDataProvider.deleteAccount())
        .thenAnswer((_) => Future.value());

    await tester.pumpWidget(buildFrame());

    var deleteAccountButton = find.byKey(Key('GymAdmin-delete'));
    expect(deleteAccountButton, findsOneWidget);

    await tester.tap(deleteAccountButton);
    await tester.pumpAndSettle();

    var deleteButton = find.text('Delete');
    expect(deleteButton, findsOneWidget);

    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    verify(() => mockUserRemoteDataProvider.deleteAccount()).called(1);
  });

  testWidgets('tapping cancel on delete dialog does not call userApi',
      (tester) async {
    await tester.pumpWidget(buildFrame());

    var deleteAccountButton = find.byKey(Key('GymAdmin-delete'));
    expect(deleteAccountButton, findsOneWidget);

    await tester.tap(deleteAccountButton);
    await tester.pumpAndSettle();

    var cancelButton = find.text('Cancel');
    expect(cancelButton, findsOneWidget);

    await tester.tap(cancelButton);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    verifyNever(() => mockUserRemoteDataProvider.deleteAccount());
  });
}

class MockUserRemoteDataProvider extends Mock
    implements UserRemoteDataProvider {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.noSuchMethod(Invocation.method(#didPush, [route, previousRoute]));
  }
}

class MockRoute extends Mock implements Route<dynamic> {}
