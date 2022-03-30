import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';

class SliverFilterAppBar extends SliverPersistentHeaderDelegate {
  static const _filterBarHeight = 64.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    var adjustedShrinkOffset = shrinkOffset > maxExtent - minExtent
        ? maxExtent - minExtent
        : shrinkOffset;
    var fadeOpacity = shrinkOffset > 100 ? 0.0 : (100 - shrinkOffset) / 100;
    return Stack(
      children: [
        Container(
          height: maxExtent,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                FreeBetaColors.yellowFilterBar,
                FreeBetaColors.greenFilterBar,
                FreeBetaColors.purpleFilterBar,
              ],
              stops: [
                0.0,
                0.7,
                0.9,
              ],
            ),
          ),
        ),
        Positioned(
          bottom: minExtent,
          left: FreeBetaSizes.m,
          right: FreeBetaSizes.m,
          child: Opacity(
            opacity: fadeOpacity,
            child: _ClimbTypeFilters(),
          ),
        ),
        Positioned(
          bottom: FreeBetaSizes.m,
          left: FreeBetaSizes.m,
          right: FreeBetaSizes.m,
          child: _FilterTextField(),
        ),
      ],
    );
  }

  @override
  double get minExtent => _filterBarHeight;

  @override
  double get maxExtent => _filterBarHeight * 4;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}

class _ClimbTypeFilters extends StatefulWidget {
  const _ClimbTypeFilters({Key? key}) : super(key: key);

  @override
  State<_ClimbTypeFilters> createState() => __ClimbTypeFiltersState();
}

class __ClimbTypeFiltersState extends State<_ClimbTypeFilters> {
  List<ClimbType> _climbTypeFilters = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: FreeBetaPadding.sHorizontal,
          child: Text(
            'Climb Type',
            style: FreeBetaTextStyle.h3,
          ),
        ),
        Wrap(
          children: ClimbType.values.map((climbType) {
            return Padding(
              padding: FreeBetaPadding.sHorizontal,
              child: OutlinedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    _climbTypeFilters.contains(climbType)
                        ? FreeBetaColors.white
                        : FreeBetaColors.black,
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    _climbTypeFilters.contains(climbType)
                        ? FreeBetaColors.black
                        : FreeBetaColors.white,
                  ),
                ),
                onPressed: () => _toggleClimbType(climbType),
                child: Text(climbType.displayName),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _toggleClimbType(ClimbType climbType) {
    if (!_climbTypeFilters.contains(climbType)) {
      setState(() {
        _climbTypeFilters.add(climbType);
      });
    } else {
      setState(() {
        _climbTypeFilters.remove(climbType);
      });
    }
  }
}

class _FilterTextField extends ConsumerWidget {
  const _FilterTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var routeFilterText = ref.watch(routeTextFilterProvider);
    return TextFormField(
      initialValue: routeFilterText,
      onChanged: (value) {
        ref.read(routeTextFilterProvider.notifier).state = value;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(FreeBetaSizes.xl),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: FreeBetaSizes.ml,
        ),
        hintStyle: FreeBetaTextStyle.h4.copyWith(
          color: FreeBetaColors.grayDark,
        ),
        hintText: 'Type to filter routes',
      ),
      style: FreeBetaTextStyle.h4,
    );
  }
}
