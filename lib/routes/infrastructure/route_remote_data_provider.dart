import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';
import 'package:riverpod/riverpod.dart';

import 'models/route_model.dart';

final routeRemoteDataProvider = Provider(
    (ref) => RouteRemoteDataProvider(ref.read(crashlyticsApiProvider)));

class RouteRemoteDataProvider {
  RouteRemoteDataProvider(this._crashlyticsApi);

  final CrashlyticsApi _crashlyticsApi;

  CollectionReference<Map<String, dynamic>> get _firestoreRoutes =>
      FirebaseFirestore.instance.collection('routes');
  CollectionReference<Map<String, dynamic>> get _firestoreUsers =>
      FirebaseFirestore.instance.collection('users');
  static const String _userRouteCollectionName = 'user_routes';

  Future<List<RouteModel>> getRoutes() async {
    List<RouteModel> routes = [];
    await _firestoreRoutes
        .where('isActive', isEqualTo: true)
        .get()
        .then(
          (routeCollection) => routeCollection.docs.forEach(
            (json) => routes.add(
              RouteModel.fromFirebase(json.id, json.data()),
            ),
          ),
        )
        .catchError(
      (error, stackTrace) {
        _crashlyticsApi.logError(
          error,
          stackTrace,
          'RouteRemoteDataProvider',
          'getRoutes',
        );
      },
    );

    log('${routes.where((element) => element.betaVideo != null).length}');

    return routes;
  }

  Future<List<RouteModel>> getRemovedRoutes() async {
    List<RouteModel> routes = [];
    await _firestoreRoutes
        .where('isActive', isEqualTo: false)
        .get()
        .then(
          (routeCollection) => routeCollection.docs.forEach(
            (json) => routes.add(
              RouteModel.fromFirebase(json.id, json.data()),
            ),
          ),
        )
        .catchError(
      (error, stackTrace) {
        _crashlyticsApi.logError(
          error,
          stackTrace,
          'RouteRemoteDataProvider',
          'getRoutes',
        );
      },
    );

    return routes;
  }

  Future<void> addRoute(RouteFormModel routeFormModel) async {
    await _firestoreRoutes
        .add(routeFormModel.toJson())
        .then((value) => log(value.toString()))
        .catchError(
      (error, stackTrace) {
        _crashlyticsApi.logError(
          error,
          stackTrace,
          'RouteRemoteDataProvider',
          'addRoute',
        );
      },
    );
  }

  Future<void> updateRoute(
    RouteModel routeModel,
    RouteFormModel routeFormModel,
  ) async {
    await _firestoreRoutes
        .doc(routeModel.id)
        .update(routeFormModel.toJson())
        .catchError(
      (error, stackTrace) {
        _crashlyticsApi.logError(
          error,
          stackTrace,
          'RouteRemoteDataProvider',
          'updateRoute',
        );
      },
    );
  }

  Future<void> deleteRoute(
    RouteModel routeModel,
  ) async {
    await _firestoreRoutes
        .doc(routeModel.id)
        .update({'isDeleted': true}).catchError(
      (error, stackTrace) {
        _crashlyticsApi.logError(
          error,
          stackTrace,
          'RouteRemoteDataProvider',
          'deleteRoute',
        );
      },
    );
  }

  Future<void> saveUserRoute(UserRouteModel userRouteModel) async {
    await _firestoreUsers
        .doc(userRouteModel.userId)
        .collection(_userRouteCollectionName)
        .doc(userRouteModel.id)
        .set(userRouteModel.toJson())
        .catchError(
      (error, stackTrace) {
        _crashlyticsApi.logError(
          error,
          stackTrace,
          'RouteRemoteDataProvider',
          'saveUserRoute',
        );
      },
    );
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
      (error, stackTrace) {
        _crashlyticsApi.logError(
          error,
          stackTrace,
          'RouteRemoteDataProvider',
          'getUserRoutes',
        );
      },
    );

    return userRoutes;
  }
}
