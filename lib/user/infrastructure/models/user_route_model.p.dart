part of 'user_route_model.dart';

extension UserRouteModelExtensions on UserRouteModel {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'routeId': routeId,
      'isCompleted': _setBool(isCompleted),
      'isFavorited': _setBool(isFavorited),
      'attempts': attempts,
      'notes': notes,
    };
  }

  static int _setBool(bool value) => value ? 1 : 0;
}
