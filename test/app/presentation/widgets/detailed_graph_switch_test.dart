import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/presentation/widgets/detailed_graph_switch.dart';
import 'package:free_beta/app/presentation/widgets/switch.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';

void main() {
  Widget buildFrame() {
    return ProviderScope(
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

  testWidgets('tapping switch calls provider', (tester) async {
    await tester.pumpWidget(buildFrame());

    var detailsSwitch = find.byKey(Key('details-graph-switch'));
    expect(detailsSwitch, findsOneWidget);

    final element = tester.element(find.byType(IncludeGraphDetailsSwitch));
    final container = ProviderScope.containerOf(element);

    expect(container.read(includeGraphDetailsProvider), false);

    await tester.tap(detailsSwitch);
    await tester.pumpAndSettle();

    expect(container.read(includeGraphDetailsProvider), true);

    await tester.tap(detailsSwitch);
    await tester.pumpAndSettle();

    expect(container.read(includeGraphDetailsProvider), false);
  });
}
