import 'package:free_beta/app/enums/route_rating.dart';

class RouteFormModel {
  bool? isAttempted;
  bool? isCompleted;
  bool? isFavorited;
  RouteRating rating;
  String? notes;

  RouteFormModel({
    this.isAttempted,
    this.isCompleted,
    this.isFavorited,
    this.rating = RouteRating.noRating,
    this.notes,
  });
}
