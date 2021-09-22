enum Location {
  low,
  mezzanine,
  high,
}

extension LocationExtensions on Location {
  String get displayName {
    switch (this) {
      case Location.low:
        return 'Boulder Area';
      case Location.mezzanine:
        return 'Mezzanine';
      case Location.high:
        return 'Tall Wall';
    }
  }
}
