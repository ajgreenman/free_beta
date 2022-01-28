class UserRouteFormModel {
  bool isAttempted;
  bool isCompleted;
  bool isFavorited;
  String? notes;

  UserRouteFormModel({
    required this.isAttempted,
    required this.isCompleted,
    required this.isFavorited,
    this.notes,
  });
}
