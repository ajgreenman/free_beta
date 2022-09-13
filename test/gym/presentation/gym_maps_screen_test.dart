import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/gym/presentation/gym_maps_screen.dart';

void main() {
  Widget buildFrame() {
    return MaterialApp(
      home: GymMapsScreen(),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame());

    expect(find.byType(GymMapsScreen), findsOneWidget);
  });
}
