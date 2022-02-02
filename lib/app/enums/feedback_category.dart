enum FeedbackCategory {
  suggestion,
  issue,
  review,
}

extension FeedbackCategoryExtensions on FeedbackCategory {
  String get displayName {
    switch (this) {
      case FeedbackCategory.issue:
        return 'Issue Report';
      case FeedbackCategory.review:
        return 'Review';
      case FeedbackCategory.suggestion:
        return 'Suggestion';
    }
  }
}
