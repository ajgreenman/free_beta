import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/divider.dart';
import 'package:free_beta/app/presentation/widgets/form/checkbox.dart';
import 'package:free_beta/app/presentation/widgets/form/dropdown_list.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/app/presentation/widgets/color_square.dart';

class RouteFilterBar extends SliverPersistentHeaderDelegate {
  RouteFilterBar({required this.routeProvider});

  final AutoDisposeFutureProvider<RouteFilterModel> routeProvider;

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
    bool _,
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
                Flexible(child: _RouteColorFilter()),
                SizedBox(width: FreeBetaSizes.xl),
                Flexible(child: _ClimbTypeFilter()),
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

  final AutoDisposeFutureProvider<RouteFilterModel> routeProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: FreeBetaPadding.mAll,
          child: TextFormField(
            initialValue: ref.watch(routeTextFilterProvider),
            onChanged: (value) =>
                ref.read(routeTextFilterProvider.notifier).update(value),
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
        FreeBetaDivider(),
      ],
    );
  }
}

class _AttemptedFilter extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var attemptedFilterValue = ref.watch(routeAttemptedFilterProvider);
    return Row(
      children: [
        Flexible(
          child: FreeBetaCheckbox(
            label: 'Attempted',
            value: attemptedFilterValue == true,
            onTap: () => _onAttemptedTap(attemptedFilterValue, ref),
          ),
        ),
        SizedBox(width: FreeBetaSizes.xl),
        Flexible(
          child: FreeBetaCheckbox(
            label: 'Unattempted',
            value: attemptedFilterValue == false,
            onTap: () => _onUnattemptedTap(attemptedFilterValue, ref),
          ),
        ),
      ],
    );
  }

  void _onAttemptedTap(bool? currentValue, WidgetRef ref) {
    if (currentValue == true) {
      ref.read(routeAttemptedFilterProvider.notifier).update(null);
    } else {
      ref.read(routeAttemptedFilterProvider.notifier).update(true);
    }
  }

  void _onUnattemptedTap(bool? currentValue, WidgetRef ref) {
    if (currentValue == false) {
      ref.read(routeAttemptedFilterProvider.notifier).update(null);
    } else {
      ref.read(routeAttemptedFilterProvider.notifier).update(false);
    }
  }
}

class _ClimbTypeFilter extends ConsumerWidget {
  const _ClimbTypeFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FreeBetaDropdownList<ClimbType?>(
      label: 'Style',
      hintText: 'Tap to filter',
      borderWidth: 1.0,
      items: _getTypes(),
      onChanged: (climbType) =>
          ref.read(routeClimbTypeFilterProvider.notifier).update(climbType),
      initialValue: ref.watch(routeClimbTypeFilterProvider),
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
      label: 'Color',
      hintText: 'Tap to filter',
      borderWidth: 1.0,
      items: _getColors(),
      onChanged: (routeColor) =>
          ref.read(routeColorFilterProvider.notifier).update(routeColor),
      initialValue: ref.watch(routeColorFilterProvider),
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
                  child: ColorSquare(color: routeColor.displayColor),
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
