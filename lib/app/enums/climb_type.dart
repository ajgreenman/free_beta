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
}
