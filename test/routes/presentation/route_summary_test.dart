import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/color_square.dart';
import 'package:free_beta/gym/infrastructure/gym_providers.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';
import 'package:free_beta/gym/infrastructure/models/wall_section_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/presentation/route_summary.dart';

void main() {
  Widget buildFrame({
    required RouteModel route,
    required List<ResetModel> resets,
    isDetailed = false,
  }) {
    return ProviderScope(
      overrides: [
        resetScheduleProvider.overrideWith((_) => resets),
      ],
      child: MaterialApp(
        home: RouteSummary(route, isDetailed: isDetailed),
      ),
    );
  }

  group('SimpleRouteSummary', () {
    testWidgets('smoke test', (tester) async {
      await tester
          .pumpWidget(buildFrame(route: namelessRouteModel, resets: resets));

      expect(find.text(namelessRouteModel.name), findsNothing);
      expect(
          find.text(namelessRouteModel.climbType.displayName), findsOneWidget);
      expect(find.text(namelessRouteModel.boulderRating!.displayName),
          findsOneWidget);
      expect(find.byType(ColorSquare), findsNothing);
    });

    testWidgets('display name if route has one', (tester) async {
      await tester
          .pumpWidget(buildFrame(route: namedRouteModel, resets: resets));

      expect(find.text(namedRouteModel.name), findsOneWidget);
      expect(find.text(namedRouteModel.climbType.displayName), findsOneWidget);
      expect(find.text(namedRouteModel.boulderRating!.displayName),
          findsOneWidget);
      expect(find.byType(ColorSquare), findsNothing);
    });
  });

  group('DetailedRouteSummary', () {
    testWidgets('smoke test', (tester) async {
      await tester.pumpWidget(
        buildFrame(route: namelessRouteModel, resets: resets, isDetailed: true),
      );

      expect(find.text(namelessRouteModel.name), findsNothing);
      expect(
          find.text(namelessRouteModel.climbType.displayName), findsOneWidget);
      expect(find.text(namelessRouteModel.boulderRating!.displayName),
          findsOneWidget);
      expect(find.byType(ColorSquare), findsOneWidget);
    });

    testWidgets('display name if route has one', (tester) async {
      await tester.pumpWidget(
        buildFrame(route: namedRouteModel, resets: resets, isDetailed: true),
      );

      expect(find.text(namedRouteModel.name), findsNothing);
      expect(find.text(namedRouteModel.climbType.displayName), findsOneWidget);
      expect(find.text(namedRouteModel.boulderRating!.displayName),
          findsOneWidget);
      expect(find.byType(ColorSquare), findsOneWidget);
    });

    testWidgets('route icon shows correctly with no resets', (tester) async {
      await tester.pumpWidget(
        buildFrame(route: namelessRouteModel, resets: [], isDetailed: true),
      );

      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('route icon shows correctly with a current reset',
        (tester) async {
      await tester.pumpWidget(
        buildFrame(
          route: namelessRouteModel,
          resets: [today],
          isDetailed: true,
        ),
      );

      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('route icon shows correctly with a past reset', (tester) async {
      await tester.pumpWidget(
        buildFrame(
          route: namelessRouteModel,
          resets: [yesterday],
          isDetailed: true,
        ),
      );

      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('route icon shows correctly with a future reset (in section)',
        (tester) async {
      await tester.pumpWidget(
        buildFrame(
          route: RouteModel(
            id: 'abcd1234',
            climbType: ClimbType.boulder,
            routeColor: RouteColor.black,
            wallLocation: WallLocation.boulder,
            wallLocationIndex: 2,
            creationDate: yesterday.date,
            boulderRating: BoulderRating.v0,
          ),
          resets: [yesterday, tomorrow],
          isDetailed: true,
        ),
      );

      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets(
        'route icon shows correctly with a future reset (not in section)',
        (tester) async {
      await tester.pumpWidget(
        buildFrame(
          route: RouteModel(
            id: 'abcd1234',
            climbType: ClimbType.boulder,
            routeColor: RouteColor.black,
            wallLocation: WallLocation.boulder,
            wallLocationIndex: 3,
            creationDate: yesterday.date,
            boulderRating: BoulderRating.v0,
          ),
          resets: [yesterday, tomorrow],
          isDetailed: true,
        ),
      );

      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('route icon shows correctly with no future reset',
        (tester) async {
      await tester.pumpWidget(
        buildFrame(
          route: RouteModel(
            id: 'abcd1234',
            climbType: ClimbType.boulder,
            routeColor: RouteColor.black,
            wallLocation: WallLocation.boulder,
            wallLocationIndex: 3,
            creationDate: yesterday.date,
            boulderRating: BoulderRating.v0,
          ),
          resets: [yesterday],
          isDetailed: true,
        ),
      );

      expect(find.byType(Icon), findsNothing);
    });
  });
}

var namelessRouteModel = RouteModel(
  id: 'abcd1234',
  climbType: ClimbType.boulder,
  routeColor: RouteColor.black,
  wallLocation: WallLocation.boulder,
  wallLocationIndex: 1,
  creationDate: yesterday.date,
  boulderRating: BoulderRating.v0,
);

var namedRouteModel = RouteModel(
  id: 'abcd1234',
  name: 'adskf',
  climbType: ClimbType.boulder,
  routeColor: RouteColor.black,
  wallLocation: WallLocation.boulder,
  wallLocationIndex: 1,
  creationDate: today.date,
  boulderRating: BoulderRating.v0,
  removalDate: tomorrow.date,
);

var yesterday = ResetModel(
  id: '',
  date: DateTime.now().subtract(Duration(days: 1)),
  sections: [
    WallSectionModel(
      wallLocation: WallLocation.boulder,
      wallSection: 1,
    ),
  ],
);

var today = ResetModel(
  id: '',
  date: DateTime.now(),
  sections: [],
);

var tomorrow = ResetModel(
  id: '',
  date: DateTime.now().add(Duration(days: 1)),
  sections: [
    WallSectionModel(
      wallLocation: WallLocation.boulder,
      wallSection: 2,
    ),
  ],
);

var resets = [
  ResetModel(
    id: '',
    date: DateTime.now().subtract(Duration(days: 2)),
    sections: [],
  ),
  yesterday,
  today,
  tomorrow,
];
