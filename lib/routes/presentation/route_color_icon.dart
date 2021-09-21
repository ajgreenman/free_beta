import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';

class RouteColorIcon extends StatelessWidget {
  final RouteModel route;

  const RouteColorIcon({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FreeBetaPadding.sHorizontal,
      child: SizedBox(
        height: FreeBetaSizes.l,
        width: FreeBetaSizes.l,
        child: DecoratedBox(
          decoration: _getColorDecoration(),
        ),
      ),
    );
  }

  BoxDecoration _getColorDecoration() {
    if (!route.userRouteModel.isAttempted) {
      return BoxDecoration(
        border: Border.all(
          color: route.routeColor.displayColor,
          width: 3.0,
        ),
      );
    }

    if (!route.userRouteModel.isCompleted) {
      return BoxDecoration(
        border: Border.all(
          color: route.routeColor.displayColor,
          width: 2.0,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            FreeBetaColors.white,
            route.routeColor.displayColor,
          ],
        ),
      );
    }

    return BoxDecoration(
      color: route.routeColor.displayColor,
    );
  }
}
