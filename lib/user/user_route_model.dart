class UserRouteModel {
  final bool isAttempted;
  final bool isCompleted;
  final bool isFavorited;
  final int? rating;
  final String? notes;

  UserRouteModel({
    required this.isAttempted,
    required this.isCompleted,
    required this.isFavorited,
    this.rating,
    this.notes,
  });

  UserRouteModel.initial()
      : isAttempted = false,
        isCompleted = false,
        isFavorited = false,
        rating = null,
        notes = null;
}
