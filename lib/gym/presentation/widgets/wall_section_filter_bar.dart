import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';

class WallSectionFilterBar extends SliverPersistentHeaderDelegate {
  WallSectionFilterBar({
    required this.wallLocation,
    required this.wallLocationIndex,
  });

  final WallLocation wallLocation;
  final int wallLocationIndex;

  final _sectionSize = 500.0;

  @override
  double get minExtent => 0.0;

  @override
  double get maxExtent => _sectionSize * wallLocation.heightRatio;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    var width = MediaQuery.of(context).size.width * 0.9;
    return Container(
      padding: FreeBetaPadding.lVertical,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide()),
      ),
      child: Center(
        child: SizedBox(
          width: width,
          child: WallSectionMap(
            wallLocation: wallLocation,
            sectionWidth: width,
            highlightedSection: wallLocationIndex,
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
