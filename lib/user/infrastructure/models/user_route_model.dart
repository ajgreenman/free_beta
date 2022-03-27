class UserRouteModel {
  final String userId;
  final String routeId;
  final bool isAttempted;
  final bool isCompleted;
  final bool isFavorited;
  final String? notes;

  UserRouteModel({
    required this.userId,
    required this.routeId,
    required this.isAttempted,
    required this.isCompleted,
    required this.isFavorited,
    this.notes,
  });

  UserRouteModel.initial(String userId, String routeId)
      : userId = userId,
        routeId = routeId,
        isAttempted = false,
        isCompleted = false,
        isFavorited = false,
        notes = null;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'routeId': routeId,
      'isAttempted': _setBool(isAttempted),
      'isCompleted': _setBool(isCompleted),
      'isFavorited': _setBool(isFavorited),
      'notes': notes,
    };
  }

  factory UserRouteModel.fromJson(Map<String, dynamic> json) {
    return UserRouteModel(
      userId: json['userId'],
      routeId: json['routeId'],
      isAttempted: _getBool(json['isAttempted']),
      isCompleted: _getBool(json['isCompleted']),
      isFavorited: _getBool(json['isFavorited']),
      notes: json['notes'],
    );
  }

  static bool _getBool(dynamic dbValue) => dbValue == 1 ? true : false;

  static int _setBool(bool value) => value ? 1 : 0;

  @override
  String toString() {
    return 'UserRouteModel: {userId:$userId, routeId:$routeId, isAttempted:$isAttempted, isCompleted:$isCompleted, isFavorited:$isFavorited, notes:$notes,';
  }
}
