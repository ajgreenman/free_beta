import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/wall_location.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_filter_bar.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/routes/presentation/widgets/route_list.dart';

class RouteLocationListScreen extends ConsumerWidget {
  static Route<dynamic> route({
    required WallLocation wallLocation,
    required int wallLocationIndex,
  }) {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return RouteLocationListScreen(
        wallLocation: wallLocation,
        wallLocationIndex: wallLocationIndex,
      );
    });
  }

  const RouteLocationListScreen({
    required this.wallLocation,
    required this.wallLocationIndex,
    Key? key,
  }) : super(key: key);

  final WallLocation wallLocation;
  final int wallLocationIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: FreeBetaBackButton(),
        title: Text(wallLocation.displayName),
      ),
      body: NestedScrollView(
        controller: ScrollController(),
        headerSliverBuilder: (_, __) => [
          SliverPersistentHeader(
            delegate: WallSectionFilterBar(
              width: MediaQuery.of(context).size.width,
              wallLocation: wallLocation,
              wallLocationIndex: wallLocationIndex,
            ),
          ),
        ],
        body: ref.watch(fetchLocationFilteredRoutesProvider).when(
              data: (routeFilterModel) => RouteList(
                scrollKey: 'route-location-list',
                routes: routeFilterModel.filteredRoutes.sortRoutes(),
                onRefresh: null,
              ),
              error: (error, stackTrace) => ErrorCard(
                child: ElevatedButton(
                  onPressed: () => _refreshRoutes(ref),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(FreeBetaColors.black),
                  ),
                  child: Text(
                    'Try again',
                    style: FreeBetaTextStyle.h4.copyWith(
                      color: FreeBetaColors.white,
                    ),
                  ),
                ),
              ),
              loading: () => Padding(
                padding: FreeBetaPadding.xxlVertical,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
      ),
    );
  }

  Future<void> _refreshRoutes(WidgetRef ref) async {
    ref.invalidate(fetchActiveRoutesProvider);
  }
}
