import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/routes/presentation/route_progress_icon.dart';

void main() {
  group('RouteProgressIcon', () {
    testWidgets('unattempted', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RouteProgressIcon(
            isAttempted: false,
            isCompleted: false,
          ),
        ),
      );

      expect(find.byType(Icon), findsOneWidget);
    });
    testWidgets('attempted', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RouteProgressIcon(
            isAttempted: true,
            isCompleted: false,
          ),
        ),
      );

      expect(find.byType(Icon), findsOneWidget);
    });
    testWidgets('completed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RouteProgressIcon(
            isAttempted: true,
            isCompleted: true,
          ),
        ),
      );

      expect(find.byType(Icon), findsOneWidget);
    });
  });
}
