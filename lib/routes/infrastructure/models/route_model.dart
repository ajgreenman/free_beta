import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/user/user_route_model.dart';

class RouteModel {
  final String id;
  final String name;
  final String? image;
  final String difficulty;
  final ClimbType climbType;
  final RouteColor routeColor;
  final DateTime creationDate;
  final DateTime? removalDate;
  UserRouteModel? userRouteModel;

  RouteModel({
    required this.id,
    this.name = '',
    this.image,
    required this.difficulty,
    required this.climbType,
    required this.routeColor,
    required this.creationDate,
    this.removalDate,
    this.userRouteModel,
  });
}

extension RouteModelExtensions on RouteModel {
  String get truncatedDisplayName {
    if (this.name.length > 7) {
      return this.name.substring(0, 7) + '...';
    }
    return this.name;
  }
}
