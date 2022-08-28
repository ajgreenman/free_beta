enum BoulderRating {
  v0,
  v1v3,
  v2v4,
  v3v5,
  v4v6,
  v5v7,
  v6v8,
  v8,
  v9,
  consensus,
}

extension BoulderRatingExtensions on BoulderRating {
  String get displayName {
    switch (this) {
      case BoulderRating.v0:
        return 'v0';
      case BoulderRating.v1v3:
        return 'v1-v3';
      case BoulderRating.v2v4:
        return 'v2-v4';
      case BoulderRating.v3v5:
        return 'v3-v5';
      case BoulderRating.v4v6:
        return 'v4-v6';
      case BoulderRating.v5v7:
        return 'v5-v7';
      case BoulderRating.v6v8:
        return 'v6-v8';
      case BoulderRating.v8:
        return 'v8+';
      case BoulderRating.v9:
        return 'v9+';
      case BoulderRating.consensus:
        return 'Con.';
      default:
        return 'v0';
    }
  }
}

BoulderRating boulderRatingFromString(String boulderRating) {
  switch (boulderRating.toLowerCase()) {
    case 'v0':
      return BoulderRating.v0;
    case 'v1-v3':
      return BoulderRating.v1v3;
    case 'v2-v4':
      return BoulderRating.v2v4;
    case 'v3-v5':
      return BoulderRating.v3v5;
    case 'v4-v6':
      return BoulderRating.v4v6;
    case 'v5-v7':
      return BoulderRating.v5v7;
    case 'v6-v8':
      return BoulderRating.v6v8;
    case 'v8+':
      return BoulderRating.v8;
    case 'v9+':
      return BoulderRating.v9;
    case 'consensus':
      return BoulderRating.consensus;
    default:
      return BoulderRating.v0;
  }
}
