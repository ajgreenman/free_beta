import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

import 'models/route_model.dart';

final routeRemoteDataProvider = Provider((_) => RouteRemoteDataProvider());

class RouteRemoteDataProvider {
  Future<List<RouteModel>> getRoutes() async {
    List<RouteModel> routes = [];
    await FirebaseFirestore.instance.collection('routes').get().then(
          (routeCollection) => routeCollection.docs.forEach(
            (json) => routes.add(
              RouteModel.fromFirebase(json.id, json.data()),
            ),
          ),
        );
    return routes;
  }
}
