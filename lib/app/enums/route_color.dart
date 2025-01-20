import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

enum RouteColor {
  black,
  blue,
  gray,
  green,
  orange,
  pink,
  purple,
  red,
  seafoam,
  white,
  yellow,
  unknown,
}

extension RouteColorExtensions on RouteColor {
  String get displayName {
    switch (this) {
      case RouteColor.black:
        return 'Black';
      case RouteColor.blue:
        return 'Blue';
      case RouteColor.gray:
        return 'Gray';
      case RouteColor.green:
        return 'Green';
      case RouteColor.orange:
        return 'Orange';
      case RouteColor.pink:
        return 'Pink';
      case RouteColor.purple:
        return 'Purple';
      case RouteColor.red:
        return 'Red';
      case RouteColor.seafoam:
        return 'Seafoam';
      case RouteColor.unknown:
        return 'Unknown';
      case RouteColor.white:
        return 'White';
      case RouteColor.yellow:
        return 'Yellow';
    }
  }

  Color get displayColor {
    switch (this) {
      case RouteColor.black:
        return FreeBetaColors.black;
      case RouteColor.blue:
        return FreeBetaColors.blueLight;
      case RouteColor.gray:
        return FreeBetaColors.grayLight;
      case RouteColor.green:
        return FreeBetaColors.green;
      case RouteColor.orange:
        return FreeBetaColors.warning;
      case RouteColor.pink:
        return FreeBetaColors.pink;
      case RouteColor.purple:
        return FreeBetaColors.purple;
      case RouteColor.red:
        return FreeBetaColors.red;
      case RouteColor.seafoam:
        return FreeBetaColors.greenBrand;
      case RouteColor.unknown:
        return FreeBetaColors.white;
      case RouteColor.white:
        return FreeBetaColors.white;
      case RouteColor.yellow:
        return FreeBetaColors.yellowBrand;
    }
  }
}
