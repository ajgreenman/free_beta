// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @override
  bool operator ==(covariant UserRouteModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.routeId == routeId &&
        other.isCompleted == isCompleted &&
        other.isFavorited == isFavorited &&
        other.attempts == attempts &&
        other.notes == notes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        routeId.hashCode ^
        isCompleted.hashCode ^
        isFavorited.hashCode ^
        attempts.hashCode ^
        notes.hashCode;
  }

  @override
  String toString() {
    return 'UserRouteModel(id: $id, userId: $userId, routeId: $routeId, isCompleted: $isCompleted, isFavorited: $isFavorited, attempts: $attempts, notes: $notes)';
  }
}
