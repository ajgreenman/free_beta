part of 'feedback_form_model.dart';

extension FeedbackFormModelExtensions on FeedbackFormModel {
  Map<String, dynamic> toJson() {
    return {
      'to': 'a.j.greenman@gmail.com',
      'message': {
        'subject': 'Climb Elev8 Feedback - ${category.name}',
        'text': 'From: $name\nEmail: ${email ?? 'n/a'}\nComments: $comments',
      },
    };
  }
}
