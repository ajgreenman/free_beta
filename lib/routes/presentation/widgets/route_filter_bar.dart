import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_filter_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';

class RouteFilterBar extends ConsumerWidget {
  const RouteFilterBar({
    Key? key,
    required this.routeProvider,
  }) : super(key: key);

  final FutureProvider<RouteFilterModel> routeProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                FreeBetaColors.yellowBrand.withOpacity(0.3),
                FreeBetaColors.greenBrand.withOpacity(0.3),
                FreeBetaColors.purpleBrand.withOpacity(0.2),
              ],
              stops: [
                0.0,
                0.7,
                0.9,
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: FreeBetaPadding.mAll,
                child: _buildFilterText(context, ref),
              ),
              _buildFilterCounts(ref),
            ],
          ),
        ),
        Divider(height: 1, thickness: 1),
      ],
    );
  }

  Widget _buildFilterCounts(WidgetRef ref) {
    var routeFilterModel =
        ref.watch(routeProvider).whenOrNull(data: (value) => value);

    if (routeFilterModel == null ||
        (routeFilterModel.filter?.isEmpty ?? true)) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: FreeBetaSizes.m,
        bottom: FreeBetaSizes.m,
      ),
      child: Text(
        'Showing ${routeFilterModel.filteredRoutes.length} ' +
            'of ${routeFilterModel.routes.length}',
      ),
    );
  }

  Widget _buildFilterText(BuildContext context, WidgetRef ref) {
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
