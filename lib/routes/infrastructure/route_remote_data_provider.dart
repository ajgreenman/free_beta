import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:free_beta/user/infrastructure/user_api.dart';
import 'package:riverpod/riverpod.dart';

import 'models/route_model.dart';

final routeRemoteDataProvider = Provider((_) => RouteRemoteDataProvider());

final fetchUserRoutesProvider = FutureProvider((ref) async {
  var routeDataProvider = ref.watch(routeRemoteDataProvider);
  var user = ref.watch(authenticationProvider).maybeWhen(
        data: (user) {
          if (user != null) return user;
        },
        orElse: () => null,
      );
  if (user == null) {
    return null;
  }
  var routes = await routeDataProvider.getUserRoutes(user.uid);

  var attempted = routes.where((route) => route.attempts > 0).length;
  var completed = routes.where((route) => route.isCompleted).length;
  var favorited = routes.where((route) => route.isFavorited).length;

  return UserStatsModel(
    attempted: attempted,
    completed: completed,
    favorited: favorited,
  );
});

class RouteRemoteDataProvider {
  CollectionReference<Map<String, dynamic>> get _firestoreRoutes =>
      FirebaseFirestore.instance.collection('routes');
  CollectionReference<Map<String, dynamic>> get _firestoreUsers =>
      FirebaseFirestore.instance.collection('users');
  static const String _userRouteCollectionName = 'user_routes';

  Future<List<RouteModel>> getRoutes() async {
    List<RouteModel> routes = [];
    await _firestoreRoutes
        .get()
        .then(
          (routeCollection) => routeCollection.docs.forEach(
            (json) => routes.add(
              RouteModel.fromFirebase(json.id, json.data()),
            ),
          ),
        )
        .catchError((error) => log('Error in getRoutes: ' + error.toString()));

    return routes;
  }

  Future<void> addRoute(RouteFormModel routeFormModel) async {
    await _firestoreRoutes
        .add(routeFormModel.toJson())
        .then((value) => log(value.toString()))
        .catchError((error) => log('Error in addRoute: ' + error.toString()));
  }

  Future<void> updateRoute(
    RouteModel routeModel,
    RouteFormModel routeFormModel,
  ) async {
    await _firestoreRoutes
        .doc(routeModel.id)
        .update(routeFormModel.toJson())
        .catchError(
            (error) => log('Error in updateRoute: ' + error.toString()));
  }

  Future<void> deleteRoute(
    RouteModel routeModel,
  ) async {
    await _firestoreRoutes
        .doc(routeModel.id)
        .update({'isDeleted': true}).catchError(
            (error) => log('Error in deleteRoute: ' + error.toString()));
  }

  Future<void> saveUserRoute(UserRouteModel userRouteModel) async {
    await _firestoreUsers
        .doc(userRouteModel.userId)
        .collection(_userRouteCollectionName)
        .doc(userRouteModel.id)
        .set(userRouteModel.toJson())
        .catchError(
            (error) => log('Error in saveUserRoute: ' + error.toString()));
  }

  Future<List<UserRouteModel>> getUserRoutes(String userId) async {
    List<UserRouteModel> userRoutes = [];
    await _firestoreUsers
        .doc(userId)
        .collection(_userRouteCollectionName)
        .get()
        .then(
          (userRouteCollection) => userRouteCollection.docs.forEach(
            (json) => userRoutes.add(
              UserRouteModel.fromJson(json.data()),
            ),
          ),
        )
        .catchError(
            (error) => log('Error in getUserRoutes: ' + error.toString()));

    return userRoutes;
  }
}
