import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/presentation/route_location_list_screen.dart';

class GymLocationMapFullScreen extends ConsumerStatefulWidget {
  static Route route(WallLocation wallLocation) => MaterialPageRoute(
        builder: (_) => GymLocationMapFullScreen(wallLocation: wallLocation),
      );

  const GymLocationMapFullScreen({
    required this.wallLocation,
    Key? key,
  }) : super(key: key);

  final WallLocation wallLocation;

  @override
  ConsumerState<GymLocationMapFullScreen> createState() =>
      _GymLocationMapFullScreenState();
}

class _GymLocationMapFullScreenState
    extends ConsumerState<GymLocationMapFullScreen> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wallLocation.displayName),
        leading: FreeBetaBackButton(
          onPressed: () {
            SystemChrome.setPreferredOrientations(
              [DeviceOrientation.portraitUp],
            );
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: FreeBetaColors.grayDark,
      body: Center(
        child: Padding(
          padding: FreeBetaPadding.mAll,
          child: WallSectionMap(
            onPressed: (index) {
              SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitUp],
              );
              ref.read(routeWallLocationFilterProvider.notifier).state =
                  widget.wallLocation;
              ref.read(routeWallLocationIndexFilterProvider.notifier).state =
                  index;
              return Navigator.of(context).push(
                RouteLocationListScreen.route(
                  wallLocation: widget.wallLocation,
                  wallLocationIndex: index,
                ),
              );
            },
            wallLocation: widget.wallLocation,
          ),
        ),
      ),
      floatingActionButton: _buildRotationButton(context),
    );
  }

  FloatingActionButton _buildRotationButton(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? FloatingActionButton.large(
            onPressed: () {
              SystemChrome.setPreferredOrientations(
                [
                  DeviceOrientation.landscapeRight,
                  DeviceOrientation.landscapeLeft,
                ],
              );
              SystemChrome.setPreferredOrientations(
                [
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                  DeviceOrientation.landscapeRight,
                  DeviceOrientation.landscapeLeft,
                ],
              );
            },
            backgroundColor: FreeBetaColors.grayLight,
            child: const Icon(
              Icons.screen_rotation,
            ),
          )
        : FloatingActionButton.large(
            onPressed: () {
              SystemChrome.setPreferredOrientations(
                [
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ],
              );
              SystemChrome.setPreferredOrientations(
                [
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                  DeviceOrientation.landscapeRight,
                  DeviceOrientation.landscapeLeft,
                ],
              );
            },
            backgroundColor: FreeBetaColors.grayLight,
            child: const Icon(
              Icons.screen_rotation,
            ),
          );
  }
}