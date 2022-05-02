import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/wall_location.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/widgets/gym_section.dart';

class WallSectionMap extends StatelessWidget {
  const WallSectionMap({
    required this.wallLocation,
    this.highlightedSection,
    this.sectionPadding = FreeBetaSizes.s,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final WallLocation wallLocation;
  final int? highlightedSection;
  final double sectionPadding;
  final Function(int)? onPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var availableWidth = constraints.maxWidth -
            (wallLocation.sections.length - 1) * sectionPadding;
        var height = availableWidth * wallLocation.heightRatio;
        return SizedBox(
          height: height,
          child: Stack(
            alignment: Alignment.center,
            children: wallLocation.sections.mapIndexed((i, section) {
              return Positioned(
                left: i * sectionPadding + availableWidth * section.widthOffset,
                child: GestureDetector(
                  onTap: onPressed == null ? null : () => onPressed!(i),
                  child: highlightedSection != null && highlightedSection == i
                      ? GymSection(
                          wallSection: section,
                          size: Size(
                            availableWidth * section.widthRatio,
                            height,
                          ),
                        )
                      : GymSection.withColor(
                          color: _getColor(i),
                          wallSection: section,
                          size: Size(
                            availableWidth * section.widthRatio,
                            height,
                          ),
                        ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Color _getColor(int index) {
    if (highlightedSection != null) {
      return FreeBetaColors.white;
    }

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
