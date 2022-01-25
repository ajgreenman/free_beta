import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/route_color.dart';
import 'package:free_beta/app/theme.dart';

class RouteColorSquare extends StatelessWidget {
  const RouteColorSquare({required this.routeColor, Key? key})
      : super(key: key);

  final RouteColor routeColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: FreeBetaSizes.l,
      width: FreeBetaSizes.l,
      child: DecoratedBox(
        decoration: BoxDecoration(color: routeColor.displayColor),
      ),
    );
  }
}
