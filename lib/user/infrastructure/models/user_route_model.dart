part 'user_route_model.p.dart';

class UserRouteModel {
  final String id;
  final String userId;
  final String routeId;
  final bool isCompleted;
  final bool isFavorited;
  final int attempts;
  final String? notes;

  UserRouteModel({
    required this.userId,
    required this.routeId,
    required this.isCompleted,
    required this.isFavorited,
    this.attempts = 0,
    this.notes,
  }) : id = '$userId-$routeId';

  factory UserRouteModel.fromJson(Map<String, dynamic> json) {
    return UserRouteModel(
      userId: json['userId'],
      routeId: json['routeId'],
      isCompleted: _getBool(json['isCompleted']),
      isFavorited: _getBool(json['isFavorited']),
      attempts: json['attempts'] ?? 0,
      notes: json['notes'],
    );
  }

  static bool _getBool(dynamic dbValue) => dbValue == 1 ? true : false;

  bool get isAttempted => attempts > 0;
}
