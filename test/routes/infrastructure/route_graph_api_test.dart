import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_graph_api.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';

void main() {
  test('RouteGraphApi returns top rope ratings properly', () {
    var routeGraphApi = RouteGraphApi();
    var userRatings = routeGraphApi.getUserRatings(
      climbType: ClimbType.topRope,
      unfilteredRoutes: [
        boulderRouteModel,
        yosemiteRouteModel,
        yosemiteRouteModel,
        boulderRouteModel,
        hardYosemiteRouteModel,
      ],
    );

    expect(userRatings.length, 3);

    var unattempted = userRatings.first.data;
    expect(unattempted.first.boulderRating, null);
    expect(unattempted.first.yosemiteRating, CondensedYosemiteRating.six);
    expect(unattempted.first.count, 2);

    var completed = userRatings.last.data;
    expect(completed.first.boulderRating, null);
    expect(completed.first.yosemiteRating, CondensedYosemiteRating.six);
    expect(completed.first.count, 0);
  });

  test('RouteGraphApi returns boulder ratings properly', () {
    var routeGraphApi = RouteGraphApi();
    var userRatings = routeGraphApi.getUserRatings(
      climbType: ClimbType.boulder,
      unfilteredRoutes: [
        boulderRouteModel,
        yosemiteRouteModel,
        yosemiteRouteModel,
        boulderRouteModel,
      ],
    );

    expect(userRatings.length, 3);

    var unattempted = userRatings.first.data;
    expect(unattempted.first.boulderRating, BoulderRating.v0);
    expect(unattempted.first.yosemiteRating, null);
    expect(unattempted.first.count, 0);

    var completed = userRatings.last.data;
    expect(completed.first.boulderRating, BoulderRating.v0);
    expect(completed.first.yosemiteRating, null);
    expect(completed.first.count, 2);
  });
}

var completedRouteModel = UserRouteModel(
  routeId: 'abcd1234',
  userId: 'user1234',
  attempts: 1,
  isCompleted: true,
  isFavorited: true,
);

var uncompletedRouteModel = UserRouteModel(
  routeId: 'abcd1234',
  userId: 'user1234',
  isCompleted: false,
  isFavorited: true,
);

var boulderRouteModel = RouteModel(
  id: 'abcd1234',
  climbType: ClimbType.boulder,
  routeColor: RouteColor.black,
  wallLocation: WallLocation.boulder,
  wallLocationIndex: 1,
  creationDate: DateTime.now(),
  removalDate: DateTime.now(),
  boulderRating: BoulderRating.v0,
  userRouteModel: completedRouteModel,
);

var yosemiteRouteModel = RouteModel(
  id: 'abcd1234',
  climbType: ClimbType.topRope,
  routeColor: RouteColor.black,
  wallLocation: WallLocation.tall,
  wallLocationIndex: 1,
  creationDate: DateTime.now(),
  removalDate: DateTime.now(),
  yosemiteRating: YosemiteRating.six,
  userRouteModel: uncompletedRouteModel,
);

var hardYosemiteRouteModel = RouteModel(
  id: 'abcd1234',
  climbType: ClimbType.topRope,
  routeColor: RouteColor.black,
  wallLocation: WallLocation.tall,
  wallLocationIndex: 1,
  creationDate: DateTime.now(),
  removalDate: DateTime.now(),
  yosemiteRating: YosemiteRating.thirteenPlus,
  userRouteModel: uncompletedRouteModel,
);
