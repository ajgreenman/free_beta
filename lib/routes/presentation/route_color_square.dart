import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/route_color.dart';
import 'package:free_beta/app/theme.dart';

class RouteColorSquare extends StatelessWidget {
  const RouteColorSquare({
    required this.routeColor,
    this.size = FreeBetaSizes.l,
    Key? key,
  }) : super(key: key);

  final RouteColor routeColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: BoxDecoration(color: routeColor.displayColor),
      ),
    );
  }
}
