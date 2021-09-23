import 'package:free_beta/app/enums/route_rating.dart';

class UserRouteModel {
  final bool isAttempted;
  final bool isCompleted;
  final bool isFavorited;
  final RouteRating rating;
  final String? notes;

  UserRouteModel({
    required this.isAttempted,
    required this.isCompleted,
    required this.isFavorited,
    this.rating = RouteRating.noRating,
    this.notes,
  });

  UserRouteModel.initial()
      : isAttempted = false,
        isCompleted = false,
        isFavorited = false,
        rating = RouteRating.noRating,
        notes = null;
}
