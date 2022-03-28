class UserRouteFormModel {
  bool isCompleted;
  bool isFavorited;
  int attempts;
  String? notes;

  UserRouteFormModel({
    required this.isCompleted,
    required this.isFavorited,
    this.attempts = 0,
    this.notes,
  });
}
