import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/enums.dart';

class WallSection {
  WallSection({
    required this.location,
    required this.widthRatio,
    required this.widthOffset,
    required this.points,
  });

  final WallLocation location;
  final double widthRatio;
  final double widthOffset;
  final List<Offset> points;
}
