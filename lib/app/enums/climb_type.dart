import 'package:free_beta/app/enums/enums.dart';

enum ClimbType {
  boulder,
  topRope,
  autoBelay,
  lead,
}

extension ClimbTypeExtensions on ClimbType {
  String get displayName {
    switch (this) {
      case ClimbType.boulder:
        return 'Boulder';
      case ClimbType.topRope:
        return 'Top Rope';
      case ClimbType.lead:
        return 'Lead';
      case ClimbType.autoBelay:
        return 'Auto-belay';
    }
  }

  String get pluralDisplayName {
    return displayName + 's';
  }

  String get abbreviatedName {
    switch (this) {
      case ClimbType.boulder:
        return 'B';
      case ClimbType.topRope:
        return 'TR';
      case ClimbType.lead:
        return 'L';
      case ClimbType.autoBelay:
        return 'AB';
    }
  }

  Type get ratingClass {
    switch (this) {
      case ClimbType.boulder:
        return BoulderRating;
      case ClimbType.topRope:
        return YosemiteRating;
      case ClimbType.autoBelay:
        return YosemiteRating;
      case ClimbType.lead:
        return YosemiteRating;
    }
  }
}
