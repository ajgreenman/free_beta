import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/user/user_route_model.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sqflite/sqflite.dart';

final routeLocalDataProvider = Provider((_) => RouteLocalDataProvider());

class RouteLocalDataProvider {
  static const USER_ROUTE_TABLE_NAME = 'userRoutes';

  Future<void> saveRoute(RouteModel route) async {
    final userRouteDatabase = await _getDatabase();

    await userRouteDatabase.insert(
      USER_ROUTE_TABLE_NAME,
      route.userRouteModel!.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<UserRouteModel>> getUserRoutes() async {
    final userRouteDatabase = await _getDatabase();

    var userRoutes = await userRouteDatabase.query(USER_ROUTE_TABLE_NAME);

    return List.generate(
      userRoutes.length,
      (routeId) => UserRouteModel.fromJson(userRoutes[routeId]),
    );
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(
        await getDatabasesPath(),
        USER_ROUTE_TABLE_NAME + '.db',
      ),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $USER_ROUTE_TABLE_NAME(routeId INTEGER PRIMARY KEY, isAttempted INTEGER, isCompleted INTEGER, isFavorited INTEGER, rating INTEGER, notes TEXT)',
        );
      },
      version: 1,
    );
  }
}
