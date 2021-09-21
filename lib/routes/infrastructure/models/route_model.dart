import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/user/user_route_model.dart';

class RouteModel {
  final UserRouteModel userRouteModel;
  final Location location;
  final Section section;
  final String difficulty;
  final ClimbType climbType;
  final RouteColor routeColor;
  final String? image;

  RouteModel({
    required this.userRouteModel,
    required this.location,
    required this.section,
    required this.difficulty,
    required this.climbType,
    required this.routeColor,
    this.image,
  });
}

extension RouteModelListExtensions on List<RouteModel> {
  List<RouteModel> sortByType() {
    this.sort((a, b) => a.climbType.index.compareTo(b.climbType.index));
    return this;
  }
}
