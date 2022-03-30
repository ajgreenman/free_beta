import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';

class RouteFilterBar extends SliverPersistentHeaderDelegate {
  RouteFilterBar({required this.routeProvider});

  final FutureProvider<RouteFilterModel> routeProvider;

  static const _filterBarHeight = 72.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // = shrinkOffset > 100 ? 0.0 : (100 - shrinkOffset) / 100;
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
        // Positioned(
        //   bottom: minExtent,
        //   left: FreeBetaSizes.m,
        //   right: FreeBetaSizes.m,
        //   child: Opacity(
        //     opacity: fadeOpacity,
        //     child: Text('how r ya now'),
        //   ),
        // ),
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
  double get minExtent => _filterBarHeight;

  @override
  double get maxExtent => _filterBarHeight;

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
