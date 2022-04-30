import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/wall_location.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/widgets/gym_section.dart';

class WallSectionMap extends StatelessWidget {
  const WallSectionMap({
    required this.wallLocation,
    required this.sectionWidth,
    this.highlightedSection,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final WallLocation wallLocation;
  final double sectionWidth;
  final int? highlightedSection;
  final Function(int)? onPressed;

  @override
  Widget build(BuildContext context) {
    var availableWidth = sectionWidth - FreeBetaSizes.xxl;
    return Stack(
      alignment: Alignment.center,
      children: wallLocation.sections.mapIndexed((i, section) {
        var left =
            ((i + 1) * FreeBetaSizes.s) + availableWidth * section.widthOffset;
        return Positioned(
          left: left,
          child: GestureDetector(
            onTap: onPressed == null ? null : () => onPressed!(i),
            child: highlightedSection != null && highlightedSection == i
                ? GymSection(
                    wallSection: section,
                    size: Size(
                      availableWidth * section.widthRatio,
                      availableWidth * wallLocation.heightRatio,
                    ),
                  )
                : GymSection.withColor(
                    color: _getColor(i),
                    wallSection: section,
                    size: Size(
                      availableWidth * section.widthRatio,
                      availableWidth * wallLocation.heightRatio,
                    ),
                  ),
          ),
        );
      }).toList(),
    );
  }

  Color _getColor(int index) {
    var opacity = highlightedSection != null ? 0.1 : 0.7;

    switch (index % 3) {
      case 0:
        return FreeBetaColors.greenBrand.withOpacity(opacity);
      case 1:
        return FreeBetaColors.yellowBrand.withOpacity(opacity);
      case 2:
        return FreeBetaColors.purpleBrand.withOpacity(opacity);
      default:
        return FreeBetaColors.greenBrand.withOpacity(opacity);
    }
  }
}
