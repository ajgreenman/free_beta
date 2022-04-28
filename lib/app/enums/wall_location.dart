import 'dart:ui';

import 'package:free_beta/app/infrastructure/models/wall_section.dart';

enum WallLocation {
  boulder,
  mezzanine,
  tall,
}

extension WallLocationExtensions on WallLocation {
  String get displayName {
    switch (this) {
      case WallLocation.boulder:
        return 'Boulder Wall';
      case WallLocation.mezzanine:
        return 'Mezzanine';
      case WallLocation.tall:
        return 'Tall Wall';
    }
  }

  String get abbreviation {
    switch (this) {
      case WallLocation.boulder:
        return 'B';
      case WallLocation.mezzanine:
        return 'M';
      case WallLocation.tall:
        return 'T';
    }
  }

  List<WallSection> get sections {
    switch (this) {
      case WallLocation.boulder:
        return _boulderSections;
      case WallLocation.mezzanine:
        return _mezzanineSections;
      case WallLocation.tall:
        return _tallSections;
    }
  }

  double get heightRatio {
    switch (this) {
      case WallLocation.boulder:
        return 1.0 / 5.0;
      case WallLocation.mezzanine:
        return 2.0 / 5.0;
      case WallLocation.tall:
        return 3.0 / 5.0;
    }
  }
}

var _boulderSections = [
  WallSection(
    location: WallLocation.boulder,
    widthRatio: 0.18, // 90
    widthOffset: 0.0,
    points: [
      Offset(0.0, 0.0),
      Offset(1.0, 0.0),
      Offset(7.0 / 9.0, 0.8),
      Offset(7.0 / 9.0, 1.0),
      Offset(0.0, 1.0),
      Offset(0.0, 0.8),
    ],
  ),
  WallSection(
    location: WallLocation.boulder,
    widthRatio: 0.14, // 70
    widthOffset: 0.14,
    points: [
      Offset(2.0 / 7.0, 0.0),
      Offset(1.0, 0.9),
      Offset(1.0, 1.0),
      Offset(0.0, 1.0),
      Offset(0.0, 0.8),
    ],
  ),
  WallSection(
    location: WallLocation.boulder,
    widthRatio: 0.36, // 180
    widthOffset: 0.18,
    points: [
      Offset(0.0, 0.0),
      Offset(1.0, 0.0),
      Offset(13.0 / 18.0, 0.9),
      Offset(13.0 / 18.0, 1.0),
      Offset(5.0 / 18.0, 1.0),
      Offset(5.0 / 18.0, 0.9),
    ],
  ),
  WallSection(
    location: WallLocation.boulder,
    widthRatio: 0.24, // 120
    widthOffset: 0.44,
    points: [
      Offset(0.0, 0.9),
      Offset(5.0 / 12.0, 0.0),
      Offset(1.0, 0.0),
      Offset(11.5 / 12.0, 0.3),
      Offset(5.0 / 12.0, 1.0),
      Offset(0.0, 1.0),
    ],
  ),
  WallSection(
    location: WallLocation.boulder,
    widthRatio: 0.30, // 150
    widthOffset: 0.54,
    points: [
      Offset(0.0, 1.0),
      Offset(6.5 / 15.0, 0.3),
      Offset(7.0 / 15.0, 0.0),
      Offset(1.0, 0.0),
      Offset(13.0 / 15.0, 0.3),
      Offset(13.5 / 15.0, 1.0),
    ],
  ),
  WallSection(
    location: WallLocation.boulder,
    widthRatio: 0.15, // 75
    widthOffset: 0.8,
    points: [
      Offset(0.0, 0.3),
      Offset(2.0 / 7.5, 0.0),
      Offset(1.0, 0.0),
      Offset(2.0 / 7.5, 1.0),
      Offset(0.5 / 7.5, 1.0),
    ],
  ),
  WallSection(
    location: WallLocation.boulder,
    widthRatio: 0.16, // 80
    widthOffset: 0.84,
    points: [
      Offset(0.0, 1.0),
      Offset(5.5 / 8.0, 0.0),
      Offset(1.0, 0.0),
      Offset(1.0, 1.0),
    ],
  ),
];

var _mezzanineSections = [
  WallSection(
    location: WallLocation.mezzanine,
    widthRatio: 0.2, // 100
    widthOffset: 0.0,
    points: [
      Offset(0.0, 0.0),
      Offset(1.0, 0.0),
      Offset(1.0, 1.0),
      Offset(0.0, 1.0),
    ],
  ),
  WallSection(
    location: WallLocation.mezzanine,
    widthRatio: 0.16, // 80
    widthOffset: 0.2,
    points: [
      Offset(0.0, 0.0),
      Offset(1.0, 0.0),
      Offset(1.0, 0.05),
      Offset(0.2, 1.0),
      Offset(0.0, 1.0),
    ],
  ),
  WallSection(
    location: WallLocation.mezzanine,
    widthRatio: 0.26, // 130
    widthOffset: 0.232,
    points: [
      Offset(0.0, 1.0),
      Offset(6.4 / 13.0, 0.05),
      Offset(1.0, 0.85),
      Offset(1.0, 1.0),
    ],
  ),
  WallSection(
    location: WallLocation.mezzanine,
    widthRatio: 0.48, // 240
    widthOffset: 0.36,
    points: [
      Offset(0.0, 0.0),
      Offset(1.0, 0.0),
      Offset(1.0, 0.05),
      Offset(1.5 / 2.4, 0.85),
      Offset(1.5 / 2.4, 1.0),
      Offset(6.6 / 24.0, 1.0),
      Offset(6.6 / 24.0, 0.85),
      Offset(0.0, 0.05),
    ],
  ),
  WallSection(
    location: WallLocation.mezzanine,
    widthRatio: 0.22, // 110
    widthOffset: 0.66,
    points: [
      Offset(0.0, 1.0),
      Offset(0.0, 0.85),
      Offset(0.9 / 1.1, 0.05),
      Offset(0.9 / 1.1, 0.0),
      Offset(1.0, 0.0),
      Offset(1.0, 1.0),
    ],
  ),
  WallSection(
    location: WallLocation.mezzanine,
    widthRatio: 0.12, // 60
    widthOffset: 0.88,
    points: [
      Offset(0.0, 0.0),
      Offset(1.0, 0.0),
      Offset(1.0, 1.0),
      Offset(0.0, 1.0),
    ],
  ),
];

var _tallSections = [
  WallSection(
    location: WallLocation.tall,
    widthRatio: 0.15, // 75
    widthOffset: 0.0,
    points: [
      Offset(0.0, 0.0),
      Offset(0.8, 0.0),
      Offset(1.0, 1.4 / 3.0),
      Offset(5.5 / 7.5, 2.2 / 3.0),
      Offset(5.5 / 7.5, 1.0),
      Offset(0.0, 1.0),
    ],
  ),
  WallSection(
    location: WallLocation.tall,
    widthRatio: 0.23, // 115
    widthOffset: 0.11,
    points: [
      Offset(0.5 / 11.5, 0.0),
      Offset(11.0 / 11.5, 0.0),
      Offset(11.0 / 11.5, 1.3 / 3.0),
      Offset(1.0, 1.7 / 3.0),
      Offset(8.5 / 11.5, 2.6 / 3.0),
      Offset(8.5 / 11.5, 1.0),
      Offset(0.0, 1.0),
      Offset(0.0, 2.2 / 3.0),
      Offset(2.0 / 11.5, 1.4 / 3.0),
    ],
  ),
  WallSection(
    location: WallLocation.tall,
    widthRatio: 0.21, // 105
    widthOffset: 0.28,
    points: [
      Offset(2.5 / 10.5, 0.0),
      Offset(9.5 / 10.5, 0.0),
      Offset(1.0, 0.7 / 3.0),
      Offset(9.5 / 10.5, 1.3 / 3.0),
      Offset(9.5 / 10.5, 1.0),
      Offset(0.0, 1.0),
      Offset(0.0, 2.6 / 3.0),
      Offset(3.0 / 10.5, 1.7 / 3.0),
      Offset(2.5 / 10.5, 1.3 / 3.0),
    ],
  ),
  WallSection(
    location: WallLocation.tall,
    widthRatio: 0.2, // 100
    widthOffset: 0.47,
    points: [
      Offset(0.0, 0.0),
      Offset(1.0, 0.0),
      Offset(0.8, 0.7 / 3.0),
      Offset(1.0, 1.7 / 3.0),
      Offset(0.8, 2.6 / 3.0),
      Offset(0.85, 1.0),
      Offset(0.0, 1.0),
      Offset(0.0, 1.3 / 3.0),
      Offset(0.1, 0.7 / 3.0),
    ],
  ),
  WallSection(
    location: WallLocation.tall,
    widthRatio: 0.25, // 125
    widthOffset: 0.63,
    points: [
      Offset(0.16, 0.0),
      Offset(0.6, 0.0),
      Offset(1.0, 1.0),
      Offset(0.04, 1.0),
      Offset(0.0, 2.6 / 3.0),
      Offset(0.16, 1.7 / 3.0),
      Offset(0.0, 0.7 / 3.0),
    ],
  ),
  WallSection(
    location: WallLocation.tall,
    widthRatio: 0.22, // 110
    widthOffset: 0.78,
    points: [
      Offset(0.0, 0.0),
      Offset(1.0, 0.0),
      Offset(1.0, 1.0),
      Offset(0.5 / 1.1, 1.0),
    ],
  ),
];
