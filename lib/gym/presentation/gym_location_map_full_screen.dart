import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';
import 'package:free_beta/routes/presentation/route_location_list_screen.dart';

class GymLocationMapFullScreen extends StatefulWidget {
  static Route route(WallLocation wallLocation) => MaterialPageRoute(
        builder: (_) => GymLocationMapFullScreen(wallLocation: wallLocation),
      );

  const GymLocationMapFullScreen({
    required this.wallLocation,
    Key? key,
  }) : super(key: key);

  final WallLocation wallLocation;

  @override
  State<GymLocationMapFullScreen> createState() =>
      _GymLocationMapFullScreenState();
}

class _GymLocationMapFullScreenState extends State<GymLocationMapFullScreen> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft],
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
    var width = MediaQuery.of(context).size.width - FreeBetaSizes.xxl;
    var sectionWidth = width * (1.2 - widget.wallLocation.heightRatio);
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
        child: SizedBox(
          width: sectionWidth,
          child: WallSectionMap(
            onPressed: (index) {
              SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitUp],
              );
              return Navigator.of(context).push(
                RouteLocationListScreen.route(
                  wallLocation: widget.wallLocation,
                  wallLocationIndex: index,
                  onBack: () {
                    SystemChrome.setPreferredOrientations(
                      [
                        DeviceOrientation.landscapeRight,
                        DeviceOrientation.landscapeLeft
                      ],
                    );
                    Navigator.of(context).pop();
                  },
                ),
              );
            },
            wallLocation: widget.wallLocation,
            sectionWidth: sectionWidth,
          ),
        ),
      ),
    );
  }
}
