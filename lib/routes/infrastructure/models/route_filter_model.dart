import 'package:free_beta/routes/infrastructure/models/route_model.dart';

class RouteFilterModel {
  RouteFilterModel({
    required this.filter,
    required this.routes,
    required this.filteredRoutes,
  });

  final String? filter;
  final List<RouteModel> routes;
  final List<RouteModel> filteredRoutes;
}
