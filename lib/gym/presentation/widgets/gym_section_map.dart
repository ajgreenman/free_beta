import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';

class GymSectionMap extends StatefulWidget {
  static Route route(WallLocation wallLocation) => MaterialPageRoute(
        builder: (_) => GymSectionMap(wallLocation: wallLocation),
      );

  const GymSectionMap({
    required this.wallLocation,
    Key? key,
  }) : super(key: key);

  final WallLocation wallLocation;

  @override
  State<GymSectionMap> createState() => _GymSectionMapState();
}

class _GymSectionMapState extends State<GymSectionMap> {
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
      body: WallSectionMap(
        wallLocation: widget.wallLocation,
        width: width * (1.2 - widget.wallLocation.heightRatio),
      ),
    );
  }
}
