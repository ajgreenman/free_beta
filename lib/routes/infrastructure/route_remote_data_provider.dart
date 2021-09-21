import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/user/user_route_model.dart';

import 'models/route_model.dart';

class RouteRemoteDataProvider {
  Future<List<RouteModel>> getRoutes() async {
    return [
      RouteModel(
        userRouteModel: UserRouteModel(
          isAttempted: true,
          isCompleted: true,
          isFavorited: false,
          rating: 1,
          notes: 'too easy',
        ),
        location: Location.low,
        routeColor: RouteColor.black,
        section: Section.low1,
        climbType: ClimbType.boulder,
        difficulty: 'v0-v2',
      ),
      RouteModel(
        userRouteModel: UserRouteModel(
          isAttempted: false,
          isCompleted: false,
          isFavorited: false,
          notes: 'A little too hard for right now',
        ),
        location: Location.low,
        routeColor: RouteColor.blue,
        section: Section.low3,
        climbType: ClimbType.boulder,
        difficulty: 'v4-v6',
      ),
      RouteModel(
        userRouteModel: UserRouteModel(
          isAttempted: true,
          isCompleted: true,
          isFavorited: true,
          rating: 3,
          notes: 'Just gotta send it',
        ),
        location: Location.high,
        routeColor: RouteColor.red,
        section: Section.high2,
        climbType: ClimbType.autoBelay,
        difficulty: 'Speed',
      ),
      RouteModel(
        userRouteModel: UserRouteModel(
          isAttempted: true,
          isCompleted: false,
          isFavorited: false,
        ),
        location: Location.high,
        routeColor: RouteColor.seafoam,
        section: Section.high1,
        climbType: ClimbType.topRope,
        difficulty: '5.10',
      ),
      RouteModel(
        userRouteModel: UserRouteModel(
          isAttempted: true,
          isCompleted: true,
          isFavorited: true,
          rating: 2,
          notes: 'Go slow!',
        ),
        location: Location.mezzanine,
        routeColor: RouteColor.purple,
        section: Section.mezzanine1,
        climbType: ClimbType.autoBelay,
        difficulty: '5.10+',
      ),
      RouteModel(
        userRouteModel: UserRouteModel(
          isAttempted: true,
          isCompleted: true,
          isFavorited: false,
          rating: 2,
        ),
        location: Location.high,
        routeColor: RouteColor.pink,
        section: Section.high2,
        climbType: ClimbType.topRope,
        difficulty: '5.8',
      ),
      RouteModel(
        userRouteModel: UserRouteModel(
          isAttempted: true,
          isCompleted: false,
          isFavorited: false,
          rating: 1,
        ),
        location: Location.low,
        routeColor: RouteColor.purple,
        section: Section.low4,
        climbType: ClimbType.boulder,
        difficulty: 'v2-v4',
      ),
    ];
  }
}
