import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/presentation/widgets/detailed_graph_switch.dart';
import 'package:free_beta/app/presentation/widgets/switch.dart';

void main() {
  setUp(() {});

  Widget buildFrame() {
    return ProviderScope(
      overrides: [],
      child: MaterialApp(
        home: IncludeGraphDetailsSwitch(),
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame());

    expect(find.text('Detailed view'), findsOneWidget);
    expect(find.byType(FreeBetaSwitch), findsOneWidget);
  });
}
