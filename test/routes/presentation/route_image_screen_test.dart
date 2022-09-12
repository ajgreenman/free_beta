import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/routes/presentation/route_image_screen.dart';

void main() {
  Widget buildFrame({
    required List<String> images,
    required VoidCallback onLeft,
    required VoidCallback onRight,
  }) {
    return MaterialApp(
      home: RouteImageScreen(
        images: images,
        initialIndex: 0,
        onSwipeLeft: onLeft,
        onSwipeRight: onRight,
      ),
    );
  }

  group('RouteImageScreen', () {
    testWidgets('smoke test', (tester) async {
      var count = 0;
      await tester.pumpWidget(
        buildFrame(
          images: ['image.png'],
          onLeft: () => count--,
          onRight: () => count++,
        ),
      );

      expect(find.byType(RouteImageScreen), findsOneWidget);
    });
  });
}
