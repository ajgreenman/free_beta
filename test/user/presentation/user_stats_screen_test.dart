import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:free_beta/user/presentation/user_stats_screen.dart';
import 'package:free_beta/user/presentation/widgets/user_graph_section.dart';
import 'package:free_beta/user/presentation/widgets/user_stats_section.dart';

void main() {
  Widget buildFrame() {
    return ProviderScope(
      overrides: [
        fetchRatingUserGraphProvider(isBoulder: false).overrideWith((_) => []),
        fetchActiveRoutesProvider.overrideWith((_) => [routeModel]),
      ],
      child: MaterialApp(
        home: UserStatsScreen(
          isBoulder: false,
          userStatsModel: userStatsModel,
        ),
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame());

    expect(find.byType(UserStatsSection), findsOneWidget);
    expect(find.byType(UserGraphSection), findsOneWidget);
  });
}

var userStatsModel = UserStatsModel.fromRouteList([routeModel]);

var userRouteModel = UserRouteModel(
  routeId: 'abcd1234',
  userId: 'user1234',
  isCompleted: true,
  isFavorited: true,
);

var routeModel = RouteModel(
  id: 'abcd1234',
  climbType: ClimbType.boulder,
  routeColor: RouteColor.black,
  wallLocation: WallLocation.boulder,
  wallLocationIndex: 1,
  creationDate: DateTime.now(),
  boulderRating: BoulderRating.v0,
  userRouteModel: userRouteModel,
);
