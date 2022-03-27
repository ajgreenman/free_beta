import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/presentation/route_detail_screen.dart';
import 'package:free_beta/routes/presentation/route_progress_icon.dart';
import 'package:free_beta/routes/presentation/route_summary.dart';

class RouteCard extends StatelessWidget {
  final RouteModel route;

  const RouteCard({
    Key? key,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        RouteDetailScreen.route(route),
      ),
      child: Container(
        color: _getBackgroundColor(),
        padding: FreeBetaPadding.mAll,
        child: Row(
          children: [
            _buildFavoriteIcon(),
            RouteSummary(route),
            Spacer(),
            _buildProgressIcon(),
            Icon(
              Icons.keyboard_arrow_right,
              size: FreeBetaSizes.xxl,
              color: FreeBetaColors.blueDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteIcon() {
    return Padding(
      padding: EdgeInsets.only(right: FreeBetaSizes.ml),
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

  Widget _buildProgressIcon() {
    return RouteProgressIcon(
      isAttempted: route.userRouteModel?.isAttempted ?? false,
      isCompleted: route.userRouteModel?.isCompleted ?? false,
    );
  }

  Color _getBackgroundColor() {
    if (route.removalDate != null) return FreeBetaColors.grayLight;
    return route.routeColor.displayColor.withOpacity(0.3);
  }
}
