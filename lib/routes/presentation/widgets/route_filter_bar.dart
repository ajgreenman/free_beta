import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/form/dropdown_list.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/presentation/route_color_square.dart';

class RouteFilterBar extends SliverPersistentHeaderDelegate {
  RouteFilterBar({required this.routeProvider});

  final FutureProvider<RouteFilterModel> routeProvider;

  static const _filterBarHeight = 64.0;
  static const _attemptedFilterHeight = 32.0;
  static const _routeFilterHeight = 86.0;

  @override
  double get minExtent => _filterBarHeight;

  @override
  double get maxExtent =>
      _filterBarHeight +
      _attemptedFilterHeight +
      _routeFilterHeight +
      FreeBetaSizes.m * 3;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
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
          bottom: minExtent + _attemptedFilterHeight + FreeBetaSizes.m * 2,
          left: FreeBetaSizes.m,
          right: FreeBetaSizes.m,
          child: Opacity(
            opacity: fadeOpacity,
            child: Row(
              children: [
                Flexible(child: _ClimbTypeFilter()),
                SizedBox(width: FreeBetaSizes.xl),
                Flexible(child: _RouteColorFilter()),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: minExtent + FreeBetaSizes.m,
          left: FreeBetaSizes.m,
          right: FreeBetaSizes.m,
          child: Opacity(
            opacity: fadeOpacity,
            child: _AttemptedFilter(),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _FilterTextField(routeProvider: routeProvider),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}

class _FilterTextField extends ConsumerWidget {
  const _FilterTextField({
    Key? key,
    required this.routeProvider,
  }) : super(key: key);

  final FutureProvider<RouteFilterModel> routeProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var routeFilterText = ref.watch(routeTextFilterProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: FreeBetaPadding.mAll,
          child: TextFormField(
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
              focusedBorder: OutlineInputBorder(
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
          ),
        ),
        Divider(height: 1, thickness: 1),
      ],
    );
  }
}

class _AttemptedFilter extends ConsumerStatefulWidget {
  const _AttemptedFilter({Key? key}) : super(key: key);

  @override
  ConsumerState<_AttemptedFilter> createState() => __AttemptedFilterState();
}

class __AttemptedFilterState extends ConsumerState<_AttemptedFilter> {
  late bool? attemptedFilter;

  @override
  void initState() {
    super.initState();
    attemptedFilter = ref.read(routeAttemptedFilterProvider.notifier).state;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: InkWell(
            onTap: () {
              if (attemptedFilter == true) {
                setState(() => attemptedFilter = null);
              } else {
                setState(() => attemptedFilter = true);
              }
              ref.read(routeAttemptedFilterProvider.notifier).state =
                  attemptedFilter;
            },
            child: _buildCheckboxRow(
              'Attempted',
              Checkbox(
                activeColor: FreeBetaColors.blueDark,
                value: attemptedFilter == true,
                onChanged: (value) {
                  if (value == null) return;
                  if (attemptedFilter == true) {
                    setState(() => attemptedFilter = null);
                  } else {
                    setState(() => attemptedFilter = true);
                  }
                  ref.read(routeAttemptedFilterProvider.notifier).state =
                      attemptedFilter;
                },
              ),
            ),
          ),
        ),
        SizedBox(width: FreeBetaSizes.xl),
        Flexible(
          child: InkWell(
            onTap: () {
              if (attemptedFilter == false) {
                setState(() => attemptedFilter = null);
              } else {
                setState(() => attemptedFilter = false);
              }
              ref.read(routeAttemptedFilterProvider.notifier).state =
                  attemptedFilter;
            },
            child: _buildCheckboxRow(
              'Unattempted',
              Checkbox(
                activeColor: FreeBetaColors.blueDark,
                value: attemptedFilter == false,
                onChanged: (value) {
                  if (value == null) return;
                  if (attemptedFilter == false) {
                    setState(() => attemptedFilter = null);
                  } else {
                    setState(() => attemptedFilter = false);
                  }
                  ref.read(routeAttemptedFilterProvider.notifier).state =
                      attemptedFilter;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxRow(String label, Checkbox checkbox) {
    return Row(
      children: [
        Text(
          label,
          style: FreeBetaTextStyle.body2,
        ),
        Spacer(),
        SizedBox.square(dimension: FreeBetaSizes.xxl, child: checkbox),
      ],
    );
  }
}

class _ClimbTypeFilter extends ConsumerWidget {
  const _ClimbTypeFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FreeBetaDropdownList<ClimbType?>(
      label: 'Filter Type',
      hintText: 'Tap to filter',
      borderWidth: 1.0,
      items: _getTypes(),
      onChanged: (climbType) {
        ref.read(routeClimbTypeFilterProvider.notifier).state = climbType;
      },
      initialValue: ref.read(routeClimbTypeFilterProvider.notifier).state,
    );
  }

  List<DropdownMenuItem<ClimbType?>> _getTypes() {
    var climbTypes = [
      DropdownMenuItem<ClimbType?>(child: Text('-')),
    ];

    climbTypes.addAll(
      ClimbType.values.map(
        (climbType) => DropdownMenuItem<ClimbType?>(
          value: climbType,
          child: Text(climbType.displayName),
        ),
      ),
    );

    return climbTypes;
  }
}

class _RouteColorFilter extends ConsumerWidget {
  const _RouteColorFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FreeBetaDropdownList<RouteColor?>(
      label: 'Filter Color',
      hintText: 'Tap to filter',
      borderWidth: 1.0,
      items: _getColors(),
      onChanged: (routeColor) {
        ref.read(routeRouteColorFilterProvider.notifier).state = routeColor;
      },
      initialValue: ref.read(routeRouteColorFilterProvider.notifier).state,
    );
  }

  List<DropdownMenuItem<RouteColor?>> _getColors() {
    var routeColors = [
      DropdownMenuItem<RouteColor?>(child: Text('-')),
    ];

    routeColors.addAll(
      RouteColor.values.map(
        (routeColor) {
          return DropdownMenuItem<RouteColor?>(
            value: routeColor,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: FreeBetaSizes.m,
                  ),
                  child: RouteColorSquare(routeColor: routeColor),
                ),
                Text(routeColor.displayName),
              ],
            ),
          );
        },
      ),
    );

    routeColors.removeWhere((menuItem) => menuItem.value == RouteColor.unknown);

    return routeColors;
  }
}
