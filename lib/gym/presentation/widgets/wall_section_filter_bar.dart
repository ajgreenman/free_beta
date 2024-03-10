import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';

class WallSectionFilterBar extends SliverPersistentHeaderDelegate {
  WallSectionFilterBar({
    required this.width,
    required this.wallLocation,
    required this.wallLocationIndex,
  });

  final double width;
  final WallLocation wallLocation;
  final int wallLocationIndex;

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
        child: _WallSectionMapFilter(
          wallLocation: wallLocation,
          wallLocationIndex: wallLocationIndex,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}

class _WallSectionMapFilter extends ConsumerStatefulWidget {
  const _WallSectionMapFilter({
    Key? key,
    required this.wallLocation,
    required this.wallLocationIndex,
  }) : super(key: key);

  final WallLocation wallLocation;
  final int wallLocationIndex;

  @override
  ConsumerState<_WallSectionMapFilter> createState() =>
      _WallSectionMapFilterState();
}

class _WallSectionMapFilterState extends ConsumerState<_WallSectionMapFilter> {
  late int _wallLocationIndex;

  @override
  void initState() {
    super.initState();

    _wallLocationIndex = widget.wallLocationIndex;
  }

  @override
  Widget build(BuildContext context) {
    return WallSectionMap(
      wallLocation: widget.wallLocation,
      highlightedSections: [_wallLocationIndex],
      onPressed: (index) {
        setState(() {
          _wallLocationIndex = index;
        });
        ref.read(routeWallLocationIndexFilterProvider.notifier).update(index);
      },
    );
  }
}
