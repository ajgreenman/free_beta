import 'package:free_beta/app/enums/route_rating.dart';

class RouteFormModel {
  bool isAttempted;
  bool isCompleted;
  bool isFavorited;
  RouteRating? rating;
  String? notes;

  RouteFormModel({
    required this.isAttempted,
    required this.isCompleted,
    required this.isFavorited,
    this.rating,
    this.notes,
  });
}
