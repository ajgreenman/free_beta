enum YosemiteRating {
  five,
  six,
  seven,
  eight,
  eightPlus,
  nineMinus,
  nine,
  ninePlus,
  tenMinus,
  ten,
  tenPlus,
  elevenMinus,
  eleven,
  elevenPlus,
  twelveMinus,
  twelve,
  twelvePlus,
  thirteenMinus,
  thirteen,
  thirteenPlus,
}

extension YosemiteRatingExtensions on YosemiteRating {
  String get displayName {
    switch (this) {
      case YosemiteRating.five:
        return '5.5';
      case YosemiteRating.six:
        return '5.6';
      case YosemiteRating.seven:
        return '5.7';
      case YosemiteRating.eight:
        return '5.8';
      case YosemiteRating.eightPlus:
        return '5.8+';
      case YosemiteRating.nineMinus:
        return '5.9-';
      case YosemiteRating.nine:
        return '5.9';
      case YosemiteRating.ninePlus:
        return '5.9+';
      case YosemiteRating.tenMinus:
        return '5.10-';
      case YosemiteRating.ten:
        return '5.10';
      case YosemiteRating.tenPlus:
        return '5.10+';
      case YosemiteRating.elevenMinus:
        return '5.11-';
      case YosemiteRating.eleven:
        return '5.11';
      case YosemiteRating.elevenPlus:
        return '5.11+';
      case YosemiteRating.twelveMinus:
        return '5.12-';
      case YosemiteRating.twelve:
        return '5.12';
      case YosemiteRating.twelvePlus:
        return '5.12+';
      case YosemiteRating.thirteenMinus:
        return '5.13-';
      case YosemiteRating.thirteen:
        return '5.13';
      case YosemiteRating.thirteenPlus:
        return '5.13+';
    }
  }
}

YosemiteRating yosemiteRatingFromString(String yosemiteRating) {
  switch (yosemiteRating.toLowerCase()) {
    case '5.5':
      return YosemiteRating.five;
    case '5.6':
      return YosemiteRating.six;
    case '5.7':
      return YosemiteRating.seven;
    case '5.8':
      return YosemiteRating.eight;
    case '5.8+':
      return YosemiteRating.eightPlus;
    case '5.9-':
      return YosemiteRating.nineMinus;
    case '5.9':
      return YosemiteRating.nine;
    case '5.9+':
      return YosemiteRating.ninePlus;
    case '5.10-':
      return YosemiteRating.tenMinus;
    case '5.10':
      return YosemiteRating.ten;
    case '5.10+':
      return YosemiteRating.tenPlus;
    case '5.11-':
      return YosemiteRating.elevenMinus;
    case '5.11':
      return YosemiteRating.eleven;
    case '5.11+':
      return YosemiteRating.elevenPlus;
    case '5.12-':
      return YosemiteRating.twelveMinus;
    case '5.12':
      return YosemiteRating.twelve;
    case '5.12+':
      return YosemiteRating.twelvePlus;
    case '5.13-':
      return YosemiteRating.thirteenMinus;
    case '5.13':
      return YosemiteRating.thirteen;
    case '5.13+':
      return YosemiteRating.thirteenPlus;
    default:
      return YosemiteRating.five;
  }
}
