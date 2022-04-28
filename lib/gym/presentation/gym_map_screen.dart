import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/widgets/gym_section_map.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';

class GymMapScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => GymMapScreen(),
      );

  const GymMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _thumbnailWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      key: Key('gym_maps'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: WallLocation.values.mapIndexed((i, location) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                GymSectionMap.route(location),
              ),
              child: InfoCard(
                child: Column(
                  children: [
                    Text(
                      location.displayName,
                      style: FreeBetaTextStyle.h2,
                    ),
                    SizedBox(height: FreeBetaSizes.m),
                    Center(
                      child: SizedBox(
                        height: _thumbnailWidth * location.heightRatio,
                        width: _thumbnailWidth + FreeBetaSizes.xxl,
                        child: WallSectionMap(
                          width: _thumbnailWidth,
                          wallLocation: location,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
