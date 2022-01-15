import 'package:free_beta/app/enums/enums.dart';
import 'package:riverpod/riverpod.dart';

import 'models/route_model.dart';

final routeRemoteDataProvider = Provider((_) => RouteRemoteDataProvider());

class RouteRemoteDataProvider {
  Future<List<RouteModel>> getRoutes() async {
    return [
      RouteModel(
        id: 1,
        name: 'Seahorsin\' around',
        location: Location.low,
        routeColor: RouteColor.black,
        section: Section.low1,
        climbType: ClimbType.boulder,
        difficulty: 'v0-v2',
      ),
      RouteModel(
        id: 2,
        name: 'Jugs and Crimps',
        location: Location.low,
        routeColor: RouteColor.yellow,
        section: Section.low1,
        climbType: ClimbType.boulder,
        difficulty: 'v4-v6',
      ),
      RouteModel(
        id: 3,
        location: Location.low,
        routeColor: RouteColor.black,
        section: Section.low1,
        climbType: ClimbType.boulder,
        difficulty: 'v4-v6',
      ),
      RouteModel(
        id: 4,
        location: Location.low,
        routeColor: RouteColor.black,
        section: Section.low3,
        climbType: ClimbType.boulder,
        difficulty: 'v0-v2',
      ),
      RouteModel(
        id: 5,
        location: Location.low,
        routeColor: RouteColor.seafoam,
        section: Section.low3,
        climbType: ClimbType.boulder,
        difficulty: 'v0-v2',
      ),
      RouteModel(
        id: 6,
        name: 'Campus!',
        location: Location.low,
        routeColor: RouteColor.blue,
        section: Section.low1,
        climbType: ClimbType.boulder,
        difficulty: 'v2-v4',
      ),
      RouteModel(
        id: 7,
        location: Location.low,
        routeColor: RouteColor.pink,
        section: Section.low2,
        climbType: ClimbType.boulder,
        difficulty: 'v2-v4',
      ),
      RouteModel(
        id: 8,
        location: Location.low,
        routeColor: RouteColor.pink,
        section: Section.low1,
        climbType: ClimbType.boulder,
        difficulty: 'v0-v2',
      ),
      RouteModel(
        id: 9,
        location: Location.low,
        routeColor: RouteColor.blue,
        section: Section.low3,
        climbType: ClimbType.boulder,
        difficulty: 'v4-v6',
      ),
      RouteModel(
        id: 10,
        location: Location.high,
        routeColor: RouteColor.red,
        section: Section.high2,
        climbType: ClimbType.autoBelay,
        difficulty: 'Speed',
      ),
      RouteModel(
        id: 11,
        location: Location.high,
        routeColor: RouteColor.seafoam,
        section: Section.high1,
        climbType: ClimbType.topRope,
        difficulty: '5.10',
      ),
      RouteModel(
        id: 1,
        location: Location.mezzanine,
        routeColor: RouteColor.purple,
        section: Section.mezzanine1,
        climbType: ClimbType.autoBelay,
        difficulty: '5.10+',
      ),
      RouteModel(
        id: 12,
        location: Location.high,
        routeColor: RouteColor.purple,
        section: Section.high2,
        climbType: ClimbType.autoBelay,
        difficulty: '5.8',
      ),
      RouteModel(
        id: 13,
        location: Location.high,
        routeColor: RouteColor.pink,
        section: Section.high2,
        climbType: ClimbType.topRope,
        difficulty: '5.8',
      ),
      RouteModel(
        id: 14,
        location: Location.high,
        routeColor: RouteColor.green,
        section: Section.high2,
        climbType: ClimbType.topRope,
        difficulty: '5.9',
      ),
      RouteModel(
        id: 15,
        location: Location.high,
        routeColor: RouteColor.yellow,
        section: Section.high3,
        climbType: ClimbType.topRope,
        difficulty: '5.10',
      ),
      RouteModel(
        id: 16,
        location: Location.low,
        routeColor: RouteColor.purple,
        section: Section.low4,
        climbType: ClimbType.boulder,
        difficulty: 'v2-v4',
      ),
    ];
  }
}
