enum YosemiteRating {
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
  speed
}

enum CondensedYosemiteRating {
  six,
  seven,
  eight,
  nine,
  ten,
  eleven,
  twelve,
  thirteen,
  speed,
}

extension YosemiteRatingExtensions on YosemiteRating {
  String get displayName {
    switch (this) {
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
      case YosemiteRating.speed:
        return 'Speed';
    }
  }

  CondensedYosemiteRating get condensedRating {
    switch (this) {
      case YosemiteRating.six:
        return CondensedYosemiteRating.six;
      case YosemiteRating.seven:
        return CondensedYosemiteRating.seven;
      case YosemiteRating.eight:
      case YosemiteRating.eightPlus:
        return CondensedYosemiteRating.eight;
      case YosemiteRating.nineMinus:
      case YosemiteRating.nine:
      case YosemiteRating.ninePlus:
        return CondensedYosemiteRating.nine;
      case YosemiteRating.tenMinus:
      case YosemiteRating.ten:
      case YosemiteRating.tenPlus:
        return CondensedYosemiteRating.ten;
      case YosemiteRating.elevenMinus:
      case YosemiteRating.eleven:
      case YosemiteRating.elevenPlus:
        return CondensedYosemiteRating.eleven;
      case YosemiteRating.twelveMinus:
      case YosemiteRating.twelve:
      case YosemiteRating.twelvePlus:
        return CondensedYosemiteRating.twelve;
      case YosemiteRating.thirteenMinus:
      case YosemiteRating.thirteen:
      case YosemiteRating.thirteenPlus:
        return CondensedYosemiteRating.thirteen;
      case YosemiteRating.speed:
        return CondensedYosemiteRating.speed;
    }
  }
}

extension CondensedYosemiteRatingExtensions on CondensedYosemiteRating {
  String get displayName {
    switch (this) {
      case CondensedYosemiteRating.six:
        return '5.6';
      case CondensedYosemiteRating.seven:
        return '5.7';
      case CondensedYosemiteRating.eight:
        return '5.8';
      case CondensedYosemiteRating.nine:
        return '5.9';
      case CondensedYosemiteRating.ten:
        return '5.10';
      case CondensedYosemiteRating.eleven:
        return '5.11';
      case CondensedYosemiteRating.twelve:
        return '5.12';
      case CondensedYosemiteRating.thirteen:
        return '5.13';
      case CondensedYosemiteRating.speed:
        return 'Speed';
    }
  }
}

YosemiteRating yosemiteRatingFromString(String yosemiteRating) {
  switch (yosemiteRating.toLowerCase()) {
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
    case 'speed':
      return YosemiteRating.speed;
    default:
      return YosemiteRating.six;
  }
}
