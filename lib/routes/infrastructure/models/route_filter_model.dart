// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:free_beta/routes/infrastructure/models/route_model.dart';

class RouteFilterModel {
  RouteFilterModel({
    required this.routes,
    required this.filteredRoutes,
  });

  final List<RouteModel> routes;
  final List<RouteModel> filteredRoutes;

  @override
  bool operator ==(covariant RouteFilterModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.routes, routes) &&
        listEquals(other.filteredRoutes, filteredRoutes);
  }

  @override
  int get hashCode => routes.hashCode ^ filteredRoutes.hashCode;
}
