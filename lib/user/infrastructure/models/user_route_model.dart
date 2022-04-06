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

  static int _setBool(bool value) => value ? 1 : 0;

  bool get isAttempted => attempts > 0;

  @override
  String toString() {
    return 'UserRouteModel: {id:$id, userId:$userId, routeId:$routeId, isCompleted:$isCompleted, isFavorited:$isFavorited, attempts:$attempts, notes:$notes,';
  }
}
