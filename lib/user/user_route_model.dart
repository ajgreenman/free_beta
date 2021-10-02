import 'package:free_beta/app/enums/route_rating.dart';

class UserRouteModel {
  final int routeId;
  final bool isAttempted;
  final bool isCompleted;
  final bool isFavorited;
  final RouteRating rating;
  final String? notes;

  UserRouteModel({
    required this.routeId,
    required this.isAttempted,
    required this.isCompleted,
    required this.isFavorited,
    this.rating = RouteRating.noRating,
    this.notes,
  });

  UserRouteModel.initial(int routeId)
      : routeId = routeId,
        isAttempted = false,
        isCompleted = false,
        isFavorited = false,
        rating = RouteRating.noRating,
        notes = null;

  Map<String, dynamic> toJson() {
    return {
      'routeId': routeId,
      'isAttempted': _setBool(isAttempted),
      'isCompleted': _setBool(isCompleted),
      'isFavorited': _setBool(isFavorited),
      'rating': rating.index,
      'notes': notes,
    };
  }

  factory UserRouteModel.fromJson(Map<String, dynamic> json) {
    return UserRouteModel(
      routeId: json['routeId'],
      isAttempted: _getBool(json['isAttempted']),
      isCompleted: _getBool(json['isCompleted']),
      isFavorited: _getBool(json['isFavorited']),
      rating: RouteRating.values[json['rating']],
      notes: json['notes'],
    );
  }

  static bool _getBool(dynamic dbValue) => dbValue == 1 ? true : false;

  static int _setBool(bool value) => value ? 1 : 0;

  @override
  String toString() {
    return 'UserRouteModel: {routeId:$routeId, isAttempted:$isAttempted, isCompleted:$isCompleted, isFavorited:$isFavorited, rating:$rating, notes:$notes,';
  }
}
