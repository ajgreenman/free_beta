import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';

class WallSectionFilterBar extends SliverPersistentHeaderDelegate {
  WallSectionFilterBar({
    required this.width,
    required this.wallLocation,
    required this.wallLocationIndex,
    required this.onPressed,
  });

  final double width;
  final WallLocation wallLocation;
  final int wallLocationIndex;
  final Function(int)? onPressed;

  double get _availableWidth => width - FreeBetaSizes.l * 2;
  double get _availableHeight =>
      _availableWidth * wallLocation.heightRatio + FreeBetaSizes.l * 2;

  @override
  double get minExtent => 0.0;

  @override
  double get maxExtent => _availableHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      padding: FreeBetaPadding.lAll,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide()),
      ),
      child: Center(
        child: WallSectionMap(
          wallLocation: wallLocation,
          highlightedSection: wallLocationIndex,
          onPressed: onPressed,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
