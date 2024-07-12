import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/presentation/widgets/removed_routes_switch.dart';
import 'package:free_beta/app/presentation/widgets/switch.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';

void main() {
  Widget buildFrame() {
    return ProviderScope(
      child: MaterialApp(
        home: RemovedRoutesSwitch(),
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame());

    expect(find.text('Include removed routes: '), findsOneWidget);
    expect(find.byType(FreeBetaSwitch), findsOneWidget);
  });

  testWidgets('tapping switch calls provider', (tester) async {
    await tester.pumpWidget(buildFrame());

    var detailsSwitch = find.byKey(Key('removed-routes-switch'));
    expect(detailsSwitch, findsOneWidget);

    final element = tester.element(find.byType(RemovedRoutesSwitch));
    final container = ProviderScope.containerOf(element);

    expect(container.read(includeRemovedRoutesProvider), false);

    await tester.tap(detailsSwitch);
    await tester.pumpAndSettle();

    expect(container.read(includeRemovedRoutesProvider), true);

    await tester.tap(detailsSwitch);
    await tester.pumpAndSettle();

    expect(container.read(includeRemovedRoutesProvider), false);
  });
}
