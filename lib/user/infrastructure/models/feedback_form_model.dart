import 'package:free_beta/app/enums/enums.dart';

part 'feedback_form_model.p.dart';

class FeedbackFormModel {
  final String name;
  final String? email;
  final FeedbackCategory category;
  final String comments;

  FeedbackFormModel({
    required this.name,
    required this.email,
    required this.category,
    required this.comments,
  });
}
