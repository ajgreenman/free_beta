import 'package:free_beta/app/enums/route_rating.dart';

class UserRouteFormModel {
  bool isAttempted;
  bool isCompleted;
  bool isFavorited;
  RouteRating? rating;
  String? notes;

  UserRouteFormModel({
    required this.isAttempted,
    required this.isCompleted,
    required this.isFavorited,
    this.rating,
    this.notes,
  });
}
