import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

enum RouteColor {
  black,
  blue,
  green,
  pink,
  purple,
  red,
  seafoam,
  yellow,
}

extension RouteColorExtensions on RouteColor {
  String get displayName {
    switch (this) {
      case RouteColor.black:
        return 'Black';
      case RouteColor.blue:
        return 'Blue';
      case RouteColor.green:
        return 'Green';
      case RouteColor.pink:
        return 'Pink';
      case RouteColor.purple:
        return 'Purple';
      case RouteColor.red:
        return 'Red';
      case RouteColor.seafoam:
        return 'Seafoam';
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
      case RouteColor.green:
        return FreeBetaColors.green;
      case RouteColor.pink:
        return FreeBetaColors.pink;
      case RouteColor.purple:
        return FreeBetaColors.purple;
      case RouteColor.red:
        return FreeBetaColors.red;
      case RouteColor.seafoam:
        return FreeBetaColors.greenBrand;
      case RouteColor.yellow:
        return FreeBetaColors.yellowBrand;
    }
  }
}
