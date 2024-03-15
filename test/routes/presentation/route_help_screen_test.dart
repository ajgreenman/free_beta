import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/routes/presentation/route_card.dart';
import 'package:free_beta/routes/presentation/route_help_screen.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockNavigatorObserver = MockNavigatorObserver();

    registerFallbackValue(MockRoute());
  });

  Widget buildFrame() {
    return ProviderScope(
      child: MaterialApp(
        home: RouteHelpScreen(),
        navigatorObservers: [mockNavigatorObserver],
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame());

    expect(find.byType(InfoCard), findsOneWidget);
    expect(find.byType(RouteCard), findsNWidgets(5));
  });

  testWidgets('tapping RouteCard opens RouteDetailScreen', (tester) async {
    await tester.pumpWidget(buildFrame());

    var firstRouteCard = find.byType(RouteCard).first;
    expect(firstRouteCard, findsOneWidget);

    await tester.tap(firstRouteCard);
    await tester.pumpAndSettle();

    verify(() => mockNavigatorObserver.didPush(any(), any())).called(2);
  });
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.noSuchMethod(Invocation.method(#didPush, [route, previousRoute]));
  }
}

class MockRoute extends Mock implements Route<dynamic> {}
