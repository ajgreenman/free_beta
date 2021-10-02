import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/user/user_route_model.dart';

class RouteModel {
  final int id;
  final Location location;
  final Section section;
  final String difficulty;
  final ClimbType climbType;
  final RouteColor routeColor;
  final String? image;
  UserRouteModel? userRouteModel;

  RouteModel({
    required this.id,
    required this.location,
    required this.section,
    required this.difficulty,
    required this.climbType,
    required this.routeColor,
    this.image,
    this.userRouteModel,
  });
}

extension RouteModelListExtensions on List<RouteModel> {
  List<RouteModel> sortRoutes() {
    this.sort((a, b) => _compareRoutes(a, b));
    return this;
  }

  int _compareRoutes(RouteModel a, RouteModel b) {
    var typeComparison = a.location.index.compareTo(b.location.index);

    if (typeComparison != 0) {
      return typeComparison;
    }

    return a.section.index.compareTo(b.section.index);
  }
}
