import 'package:free_beta/app/enums/enums.dart';

class FeedbackFormModel {
  final String name;
  final FeedbackCategory category;
  final String comments;

  FeedbackFormModel({
    required this.name,
    required this.category,
    required this.comments,
  });

  Map<String, dynamic> toJson() {
    return {
      'to': 'a.j.greenman@gmail.com',
      'message': {
        'subject': 'Climb Elev8 Feedback - ${category.name}',
        'text': 'From: $name\nComments: $comments',
      },
    };
  }
}
