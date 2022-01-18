import 'package:free_beta/app/enums/enums.dart';
import 'package:riverpod/riverpod.dart';

import 'models/route_model.dart';

final routeRemoteDataProvider = Provider((_) => RouteRemoteDataProvider());

class RouteRemoteDataProvider {
  static final climbImage =
      'https://firebasestorage.googleapis.com/v0/b/free-beta.appspot.com/o/climb.png?alt=media&token=9e291836-6637-4aea-826a-f096a1ad91ab';

  Future<List<RouteModel>> getRoutes() async {
    return [
      RouteModel(
        id: '1',
        name: 'Seahorsin\' around',
        routeColor: RouteColor.black,
        climbType: ClimbType.boulder,
        difficulty: 'v0-v2',
        creationDate: DateTime(2021, 12, 1),
      ),
      RouteModel(
        id: '2',
        name: 'Jugs and Crimps',
        routeColor: RouteColor.yellow,
        climbType: ClimbType.boulder,
        difficulty: 'v4-v6',
        creationDate: DateTime(2021, 12, 1),
      ),
      RouteModel(
        id: '4',
        routeColor: RouteColor.black,
        climbType: ClimbType.boulder,
        difficulty: 'v0-v2',
        creationDate: DateTime(2021, 12, 1),
      ),
      RouteModel(
        id: '5',
        name: 'Unnamed',
        routeColor: RouteColor.yellow,
        climbType: ClimbType.boulder,
        difficulty: 'v2-v4',
        creationDate: DateTime(2021, 12, 23),
        images: [climbImage],
      ),
      RouteModel(
        id: '6',
        name: 'Campus!',
        routeColor: RouteColor.seafoam,
        climbType: ClimbType.boulder,
        difficulty: 'v2-v4',
        creationDate: DateTime(2021, 12, 1),
        images: [
          climbImage,
          climbImage,
        ],
      ),
      RouteModel(
        id: '7',
        routeColor: RouteColor.pink,
        climbType: ClimbType.boulder,
        difficulty: 'v2-v4',
        creationDate: DateTime(2021, 12, 1),
      ),
      RouteModel(
        id: '8',
        routeColor: RouteColor.pink,
        climbType: ClimbType.boulder,
        difficulty: 'v0-v2',
        creationDate: DateTime(2021, 12, 1),
      ),
      RouteModel(
        id: '9',
        routeColor: RouteColor.blue,
        climbType: ClimbType.boulder,
        difficulty: 'v4-v6',
        creationDate: DateTime(2021, 12, 1),
      ),
      RouteModel(
        id: '10Bdafd',
        routeColor: RouteColor.red,
        climbType: ClimbType.autoBelay,
        difficulty: 'Speed',
        creationDate: DateTime(2021, 12, 1),
      ),
      RouteModel(
        id: '11',
        routeColor: RouteColor.seafoam,
        climbType: ClimbType.topRope,
        difficulty: '5.10',
        creationDate: DateTime(2021, 12, 1),
      ),
      RouteModel(
        id: '12',
        routeColor: RouteColor.purple,
        climbType: ClimbType.autoBelay,
        difficulty: '5.10+',
        creationDate: DateTime(2021, 12, 1),
      ),
      RouteModel(
        id: '13',
        routeColor: RouteColor.purple,
        climbType: ClimbType.autoBelay,
        difficulty: '5.8',
        creationDate: DateTime(2021, 12, 1),
      ),
      RouteModel(
        id: '14',
        routeColor: RouteColor.pink,
        climbType: ClimbType.topRope,
        difficulty: '5.8',
        creationDate: DateTime(2021, 12, 1),
      ),
      RouteModel(
        id: '15',
        routeColor: RouteColor.green,
        climbType: ClimbType.topRope,
        difficulty: '5.9',
        creationDate: DateTime(2021, 12, 1),
        removalDate: DateTime(2022, 1, 1),
      ),
      RouteModel(
        id: '16',
        routeColor: RouteColor.yellow,
        climbType: ClimbType.topRope,
        difficulty: '5.10',
        creationDate: DateTime(2021, 12, 1),
      ),
      RouteModel(
        id: '17',
        routeColor: RouteColor.purple,
        climbType: ClimbType.boulder,
        difficulty: 'v2-v4',
        creationDate: DateTime(2021, 12, 1),
        removalDate: DateTime(2022, 1, 1),
      ),
    ];
  }
}
