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
            _FavoriteIcon(
              isFavorited: route.userRouteModel?.isFavorited ?? false,
            ),
            RouteSummary(route),
            Spacer(),
            RouteProgressIcon(
              isAttempted: (route.userRouteModel?.attempts ?? 0) > 0,
              isCompleted: route.userRouteModel?.isCompleted ?? false,
            ),
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

  Color _getBackgroundColor() => route.routeColor.displayColor.withOpacity(0.3);
}

class _FavoriteIcon extends StatelessWidget {
  const _FavoriteIcon({
    Key? key,
    required this.isFavorited,
  }) : super(key: key);

  final bool isFavorited;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: FreeBetaSizes.ml),
      child: Icon(
        isFavorited ? Icons.star : Icons.star_outline,
        size: FreeBetaSizes.xl,
        color: FreeBetaColors.blueDark,
      ),
    );
  }
}
