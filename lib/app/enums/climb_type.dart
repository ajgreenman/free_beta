enum ClimbType {
  boulder,
  topRope,
  lead,
  autoBelay,
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
}
