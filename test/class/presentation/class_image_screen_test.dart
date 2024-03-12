import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/class/presentation/class_image.dart';
import 'package:free_beta/class/presentation/class_image_screen.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockNavigatorObserver = MockNavigatorObserver();

    registerFallbackValue(MockRoute());
  });

  Widget buildFrame() {
    return MaterialApp(
      home: ClassImageScreen(imageUrl: ''),
      navigatorObservers: [mockNavigatorObserver],
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame());

    expect(find.byType(ClassImage), findsOneWidget);
  });

  testWidgets('pop screen on tap', (tester) async {
    await tester.pumpWidget(buildFrame());

    var classImage = find.byType(ClassImage);
    expect(classImage, findsOneWidget);

    await tester.tap(classImage);
    await tester.pump();

    verify(() => mockNavigatorObserver.didPop(any(), any())).called(1);
  });
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.noSuchMethod(Invocation.method(#didPop, [route, previousRoute]));
  }
}

class MockRoute extends Mock implements Route<dynamic> {}
