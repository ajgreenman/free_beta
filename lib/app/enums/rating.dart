enum Rating {
  v0,
  v1v3,
  v2v4,
  v3v5,
  v4v6,
  v5v7,
  v6v8,
  v8,
  consensus,
}

extension RatingExtensions on Rating {
  String get displayName {
    switch (this) {
      case Rating.v0:
        return 'v0';
      case Rating.v1v3:
        return 'v1-v3';
      case Rating.v2v4:
        return 'v2-v4';
      case Rating.v3v5:
        return 'v3-v5';
      case Rating.v4v6:
        return 'v4-v6';
      case Rating.v5v7:
        return 'v5-v7';
      case Rating.v6v8:
        return 'v6-v8';
      case Rating.v8:
        return 'v8+';
      case Rating.consensus:
        return 'Con.';
      default:
        return 'v0';
    }
  }
}

Rating ratingFromString(String rating) {
  switch (rating.toLowerCase()) {
    case 'v0':
      return Rating.v0;
    case 'v1-v3':
      return Rating.v1v3;
    case 'v2-v4':
      return Rating.v2v4;
    case 'v3-v5':
      return Rating.v3v5;
    case 'v4-v6':
      return Rating.v4v6;
    case 'v5-v7':
      return Rating.v5v7;
    case 'v6-v8':
      return Rating.v6v8;
    case 'v8+':
      return Rating.v8;
    case 'consensus':
      return Rating.consensus;
    default:
      return Rating.v0;
  }
}
