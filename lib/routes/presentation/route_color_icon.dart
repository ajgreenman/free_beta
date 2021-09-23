import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/theme.dart';

class RouteColorIcon extends StatelessWidget {
  final RouteColor routeColor;
  final bool isAttempted;
  final bool isCompleted;

  const RouteColorIcon({
    Key? key,
    required this.routeColor,
    required this.isAttempted,
    required this.isCompleted,
  }) : super(key: key);

  const RouteColorIcon.byColor({
    required this.routeColor,
  })  : isAttempted = true,
        isCompleted = true;

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
    if (!isAttempted) {
      return BoxDecoration(
        border: Border.all(
          color: routeColor.displayColor,
          width: 3.0,
        ),
      );
    }

    if (!isCompleted) {
      return BoxDecoration(
        border: Border.all(
          color: routeColor.displayColor,
          width: 2.0,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            FreeBetaColors.white,
            routeColor.displayColor,
          ],
        ),
      );
    }

    return BoxDecoration(
      color: routeColor.displayColor,
    );
  }
}
