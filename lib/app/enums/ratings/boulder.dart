enum BoulderRating {
  v0,
  v1v2,
  v1v3,
  v2v3,
  v2v4,
  v3v4,
  v3v5,
  v4v5,
  v4v6,
  v5v6,
  v5v7,
  v6v7,
  v6v8,
  v7v8,
  v8v9,
  v8,
  v9,
  consensus,
}

extension BoulderRatingExtensions on BoulderRating {
  String get displayName {
    switch (this) {
      case BoulderRating.v0:
        return 'V0';
      case BoulderRating.v1v2:
        return 'V1-V2';
      case BoulderRating.v1v3:
        return 'V1-V3';
      case BoulderRating.v2v3:
        return 'V2-V3';
      case BoulderRating.v2v4:
        return 'V2-V4';
      case BoulderRating.v3v4:
        return 'V3-V4';
      case BoulderRating.v3v5:
        return 'V3-V5';
      case BoulderRating.v4v5:
        return 'V4-V5';
      case BoulderRating.v4v6:
        return 'V4-V6';
      case BoulderRating.v5v6:
        return 'V5-V6';
      case BoulderRating.v5v7:
        return 'V5-V7';
      case BoulderRating.v6v7:
        return 'V6-V7';
      case BoulderRating.v6v8:
        return 'V6-V8';
      case BoulderRating.v7v8:
        return 'V7-V8';
      case BoulderRating.v8v9:
        return 'V8-V9';
      case BoulderRating.v8:
        return 'V8+';
      case BoulderRating.v9:
        return 'V9+';
      case BoulderRating.consensus:
        return 'Consensus';
    }
  }

  bool get isIncludedInGraph {
    switch (this) {
      case BoulderRating.v0:
        return true;
      case BoulderRating.v1v2:
        return true;
      case BoulderRating.v1v3:
        return false;
      case BoulderRating.v2v3:
        return true;
      case BoulderRating.v2v4:
        return false;
      case BoulderRating.v3v4:
        return true;
      case BoulderRating.v3v5:
        return false;
      case BoulderRating.v4v5:
        return true;
      case BoulderRating.v4v6:
        return false;
      case BoulderRating.v5v6:
        return true;
      case BoulderRating.v5v7:
        return false;
      case BoulderRating.v6v7:
        return true;
      case BoulderRating.v6v8:
        return false;
      case BoulderRating.v7v8:
        return true;
      case BoulderRating.v8v9:
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
    case 'v1-v2':
      return BoulderRating.v1v2;
    case 'v1-v3':
      return BoulderRating.v1v3;
    case 'v2-v3':
      return BoulderRating.v2v3;
    case 'v2-v4':
      return BoulderRating.v2v4;
    case 'v3-v4':
      return BoulderRating.v3v4;
    case 'v3-v5':
      return BoulderRating.v3v5;
    case 'v4-v5':
      return BoulderRating.v4v5;
    case 'v4-v6':
      return BoulderRating.v4v6;
    case 'v5-v6':
      return BoulderRating.v5v6;
    case 'v5-v7':
      return BoulderRating.v5v7;
    case 'v6-v7':
      return BoulderRating.v6v7;
    case 'v6-v8':
      return BoulderRating.v6v8;
    case 'v7-v8':
      return BoulderRating.v7v8;
    case 'v8-v9':
      return BoulderRating.v8v9;
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
