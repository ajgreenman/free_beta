import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/presentation/widgets/dots.dart';

void main() {
  group('FreeBetaDots', () {
    testWidgets('smoke test', (tester) async {
      var length = 5;
      await tester.pumpWidget(
        MaterialApp(
          home: FreeBetaDots(current: 0, length: length),
        ),
      );

      expect(find.byType(Container), findsNWidgets(length));
    });
    testWidgets('with colors', (tester) async {
      var length = 6;
      await tester.pumpWidget(
        MaterialApp(
          home: FreeBetaDots.withColors(
            key: Key(''),
            current: 0,
            length: length,
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(length));
    });
  });
}
