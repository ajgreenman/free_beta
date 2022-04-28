import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/wall_location.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/widgets/gym_section.dart';

class WallSectionMap extends StatelessWidget {
  const WallSectionMap({
    required this.wallLocation,
    required this.width,
    Key? key,
  }) : super(key: key);

  final WallLocation wallLocation;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: wallLocation.sections.mapIndexed((i, section) {
        var left = ((i + 1) * FreeBetaSizes.s) + width * section.widthOffset;
        return Positioned(
          left: left,
          child: GymSection(
            color: _getColor(i),
            wallSection: section,
            size: Size(
              width * section.widthRatio,
              width * wallLocation.heightRatio,
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _getColor(int index) {
    switch (index % 3) {
      case 0:
        return FreeBetaColors.greenBrand;
      case 1:
        return FreeBetaColors.yellowBrand;
      case 2:
        return FreeBetaColors.purpleBrand;
      default:
        return FreeBetaColors.greenBrand;
    }
  }
}
