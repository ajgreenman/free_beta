import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:riverpod/riverpod.dart';

import 'models/route_model.dart';

final routeRemoteDataProvider = Provider((_) => RouteRemoteDataProvider());

class RouteRemoteDataProvider {
  CollectionReference<Map<String, dynamic>> get firestore =>
      FirebaseFirestore.instance.collection('routes');

  Future<List<RouteModel>> getRoutes() async {
    List<RouteModel> routes = [];
    await firestore
        .get()
        .then(
          (routeCollection) => routeCollection.docs.forEach(
            (json) => routes.add(
              RouteModel.fromFirebase(json.id, json.data()),
            ),
          ),
        )
        .catchError((error) => log(error.toString()));

    return routes;
  }

  Future<void> addRoute(RouteFormModel routeFormModel) async {
    await firestore
        .add(routeFormModel.toJson())
        .then((value) => log(value.toString()))
        .catchError((error) => log(error.toString()));
  }

  Future<void> updateRoute(
    RouteModel routeModel,
    RouteFormModel routeFormModel,
  ) async {
    await firestore
        .doc(routeModel.id)
        .update(routeFormModel.toJson())
        .catchError((error) => log(error.toString()));
  }
}
