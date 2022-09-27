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
        return 'V0';
      case BoulderRating.v1v3:
        return 'V1-V3';
      case BoulderRating.v2v4:
        return 'V2-V4';
      case BoulderRating.v3v5:
        return 'V3-V5';
      case BoulderRating.v4v6:
        return 'V4-V6';
      case BoulderRating.v5v7:
        return 'V5-V7';
      case BoulderRating.v6v8:
        return 'V6-V8';
      case BoulderRating.v8:
        return 'V8+';
      case BoulderRating.v9:
        return 'V9+';
      case BoulderRating.consensus:
        return 'Consensus';
      default:
        return 'V0';
    }
  }

  bool get isIncludedInGraph {
    switch (this) {
      case BoulderRating.v0:
        return true;
      case BoulderRating.v1v3:
        return true;
      case BoulderRating.v2v4:
        return true;
      case BoulderRating.v3v5:
        return true;
      case BoulderRating.v4v6:
        return true;
      case BoulderRating.v5v7:
        return true;
      case BoulderRating.v6v8:
        return true;
      case BoulderRating.v8:
        return false;
      case BoulderRating.v9:
        return true;
      case BoulderRating.consensus:
        return false;
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
    case 'con.':
      return BoulderRating.consensus;
    default:
      return BoulderRating.v0;
  }
}
