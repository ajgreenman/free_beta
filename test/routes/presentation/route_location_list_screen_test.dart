import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/routes/presentation/route_location_list_screen.dart';
import 'package:free_beta/routes/presentation/widgets/route_list.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockRouteApi mockRouteApi;

  setUp(() {
    mockRouteApi = MockRouteApi();
    when(() => mockRouteApi.getActiveRoutes())
        .thenAnswer((_) => Future.value(routes));
    when(() => mockRouteApi.getLocationFilteredRoutes(any(), any(), any()))
        .thenAnswer((_) => RouteFilterModel(
              filteredRoutes: routes,
              routes: routes,
            ));
  });

  Widget buildFrame(WallLocation wallLocation, int index) {
    return ProviderScope(
      overrides: [
        routeApiProvider.overrideWithValue(mockRouteApi),
      ],
      child: MaterialApp(
        home: RouteLocationListScreen(
          wallLocation: wallLocation,
          wallLocationIndex: index,
        ),
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame(WallLocation.boulder, 0));

    await tester.pumpAndSettle();

    expect(find.byType(RouteLocationListScreen), findsOneWidget);
    expect(find.byType(RouteList), findsOneWidget);
  });

  testWidgets('show error card on error', (tester) async {
    when(() => mockRouteApi.getLocationFilteredRoutes(any(), any(), any()))
        .thenThrow(UnimplementedError());
    await tester.pumpWidget(buildFrame(WallLocation.boulder, 0));

    await tester.pumpAndSettle();

    expect(find.byType(RouteLocationListScreen), findsOneWidget);
    expect(find.byType(ErrorCard), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
  });
}

class MockRouteApi extends Mock implements RouteApi {}

var routes = [
  boulderRoute,
  mezzanineRoute,
];

var boulderRoute = RouteModel(
  id: '',
  climbType: ClimbType.boulder,
  routeColor: RouteColor.black,
  wallLocation: WallLocation.boulder,
  wallLocationIndex: 0,
  creationDate: DateTime.now(),
  boulderRating: BoulderRating.v0,
);

var mezzanineRoute = RouteModel(
  id: '',
  climbType: ClimbType.topRope,
  routeColor: RouteColor.green,
  wallLocation: WallLocation.mezzanine,
  wallLocationIndex: 1,
  creationDate: DateTime.now(),
  boulderRating: BoulderRating.v0,
);
