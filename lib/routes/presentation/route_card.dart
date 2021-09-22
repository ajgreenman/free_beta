import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/presentation/route_color_icon.dart';

class RouteCard extends StatelessWidget {
  final RouteModel route;

  const RouteCard({
    Key? key,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FreeBetaPadding.mVertical,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: FreeBetaSizes.xl),
            child: RouteColorIcon(route: route),
          ),
          Expanded(child: _buildDifficulty()),
          Expanded(child: _buildType()),
          Padding(
            padding: EdgeInsets.only(
              left: FreeBetaSizes.xl,
              right: FreeBetaSizes.s,
            ),
            child: Icon(
              Icons.keyboard_arrow_right,
              size: FreeBetaSizes.xxl,
              color: FreeBetaColors.blueDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildType() {
    return Text(
      route.climbType.displayName,
      style: FreeBetaTextStyle.body3,
    );
  }

  Widget _buildDifficulty() {
    return Text(
      route.difficulty,
      style: FreeBetaTextStyle.body3,
    );
  }
}
