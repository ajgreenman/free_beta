import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';

void main() {
  Widget buildFrame() {
    return MaterialApp(
      home: WallSectionMap(
        wallLocation: WallLocation.boulder,
        onPressed: (i) {},
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame());

    expect(find.byType(WallSectionMap), findsOneWidget);
  });
}
