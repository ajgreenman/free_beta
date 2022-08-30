import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/presentation/route_location_list_screen.dart';

class GymMapsScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => GymMapsScreen(),
      );

  const GymMapsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('gym_maps'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: WallLocation.values
              .map((location) => _WallLocationCard(wallLocation: location))
              .toList(),
        ),
      ),
    );
  }
}

class _WallLocationCard extends ConsumerWidget {
  const _WallLocationCard({Key? key, required this.wallLocation})
      : super(key: key);

  final WallLocation wallLocation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _onMapSectionTapped(
        ref,
        context,
        0,
        wallLocation,
      ),
      child: InfoCard(
        child: Column(
          children: [
            Text(
              wallLocation.displayName,
              style: FreeBetaTextStyle.h2,
            ),
            SizedBox(height: FreeBetaSizes.m),
            Center(
              child: WallSectionMap(
                wallLocation: wallLocation,
                onPressed: (index) => _onMapSectionTapped(
                  ref,
                  context,
                  index,
                  wallLocation,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onMapSectionTapped(
    WidgetRef ref,
    BuildContext context,
    int index,
    WallLocation location,
  ) {
    ref.read(routeWallLocationFilterProvider.notifier).state = location;
    ref.read(routeWallLocationIndexFilterProvider.notifier).state = index;
    return Navigator.of(context).push(
      RouteLocationListScreen.route(
        wallLocation: location,
        wallLocationIndex: index,
      ),
    );
  }
}
