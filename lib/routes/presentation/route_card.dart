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
          _buildColorIcon(),
          _buildDifficulty(),
          _buildType(),
          Spacer(),
          _buildFavoriteIcon(),
          Icon(
            Icons.keyboard_arrow_right,
            size: FreeBetaSizes.xxl,
            color: FreeBetaColors.blueDark,
          ),
        ],
      ),
    );
  }

  Widget _buildColorIcon() {
    return Padding(
      padding: EdgeInsets.only(right: FreeBetaSizes.xl),
      child: RouteColorIcon(
        routeColor: route.routeColor,
        isAttempted: route.userRouteModel?.isAttempted ?? false,
        isCompleted: route.userRouteModel?.isCompleted ?? false,
      ),
    );
  }

  Widget _buildType() {
    return Expanded(
      child: Text(
        route.climbType.displayName,
        style: FreeBetaTextStyle.body3,
      ),
    );
  }

  Widget _buildDifficulty() {
    return Expanded(
      child: Text(
        route.difficulty,
        style: FreeBetaTextStyle.body3,
      ),
    );
  }

  Widget _buildFavoriteIcon() {
    return Padding(
      padding: EdgeInsets.only(right: FreeBetaSizes.xl),
      child: route.userRouteModel?.isFavorited ?? false
          ? Icon(
              Icons.star,
              size: FreeBetaSizes.xl,
              color: FreeBetaColors.blueDark,
            )
          : Icon(
              Icons.star_outline,
              size: FreeBetaSizes.xl,
              color: FreeBetaColors.blueDark,
            ),
    );
  }
}
