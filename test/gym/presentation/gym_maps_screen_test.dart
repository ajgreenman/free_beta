import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/gym/presentation/gym_maps_screen.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';
import 'package:free_beta/routes/presentation/route_location_list_screen.dart';

void main() {
  Widget buildFrame() {
    return ProviderScope(
      child: MaterialApp(
        home: GymMapsScreen(),
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame());

    expect(find.byType(WallSectionMap), findsNWidgets(3));
  });

  testWidgets('tapping card opens RouteLocationList', (tester) async {
    await tester.pumpWidget(buildFrame());

    var locationCard = find.byKey(Key('GymMapsScreen-locationCard-boulder'));
    expect(locationCard, findsOneWidget);

    await tester.tap(locationCard);
    await tester.pumpAndSettle();

    expect(find.byType(RouteLocationListScreen), findsOneWidget);
  });

  testWidgets('tapping section opens RouteLocationList', (tester) async {
    await tester.pumpWidget(buildFrame());

    var locationSection = find.byKey(Key('GymMapsScreen-section-boulder'));
    expect(locationSection, findsOneWidget);

    await tester.tap(locationSection);
    await tester.pumpAndSettle();

    expect(find.byType(RouteLocationListScreen), findsOneWidget);
  });
}
