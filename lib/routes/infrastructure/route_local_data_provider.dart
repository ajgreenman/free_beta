import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sqflite/sqflite.dart';

final routeLocalDataProvider = Provider((_) => RouteLocalDataProvider());

final fetchUserRoutes = FutureProvider((ref) async {
  var routeDataProvider = ref.watch(routeLocalDataProvider);
  var routes = await routeDataProvider.getUserRoutes();

  var attempted = routes.where((route) => route.isAttempted).length;
  var completed = routes.where((route) => route.isCompleted).length;
  var favorited = routes.where((route) => route.isFavorited).length;

  return UserRoutes(
    attempted: attempted,
    completed: completed,
    favorited: favorited,
  );
});

class RouteLocalDataProvider {
  static const USER_ROUTE_TABLE_NAME = 'userRoutes';

  Future<void> saveRoute(UserRouteModel userRouteModel) async {
    final userRouteDatabase = await _getDatabase();

    await userRouteDatabase.insert(
      USER_ROUTE_TABLE_NAME,
      userRouteModel.toJson(),
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
          'CREATE TABLE $USER_ROUTE_TABLE_NAME(routeId TEXT PRIMARY KEY, isAttempted INTEGER, isCompleted INTEGER, isFavorited INTEGER, rating INTEGER, notes TEXT)',
        );
      },
      version: 1,
    );
  }
}

class UserRoutes {
  UserRoutes({
    required this.attempted,
    required this.completed,
    required this.favorited,
  });

  final int attempted;
  final int completed;
  final int favorited;
}
