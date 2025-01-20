import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/wall_location.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/widgets/gym_section.dart';

class WallSectionMap extends StatelessWidget {
  const WallSectionMap({
    Key? key,
    required this.wallLocation,
    required void Function(int) onPressed,
    this.highlightedSections = const [],
    this.sectionPadding = FreeBetaSizes.s,
    this.isForm = false,
  })  : onPressed = onPressed,
        super(key: key);

  const WallSectionMap.static({
    Key? key,
    required this.wallLocation,
    this.highlightedSections = const [],
    this.sectionPadding = FreeBetaSizes.s,
  })  : onPressed = null,
        isForm = false,
        super(key: key);

  final WallLocation wallLocation;
  final void Function(int)? onPressed;
  final List<int> highlightedSections;
  final double sectionPadding;
  final bool isForm;

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
                  onTap: onPressed == null ? () {} : () => onPressed!(i),
                  child: highlightedSections.contains(i)
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
    if (highlightedSections.isNotEmpty ||
        (highlightedSections.isEmpty && isForm)) {
      return FreeBetaColors.white;
    }

    var opacity = highlightedSections.isNotEmpty ? 25 : 175;

    switch (index % 3) {
      case 0:
        return FreeBetaColors.greenBrand.withAlpha(opacity);
      case 1:
        return FreeBetaColors.yellowBrand.withAlpha(opacity);
      case 2:
        return FreeBetaColors.purpleBrand.withAlpha(opacity);
      default:
        return FreeBetaColors.greenBrand.withAlpha(opacity);
    }
  }
}
