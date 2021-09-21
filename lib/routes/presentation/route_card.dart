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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(FreeBetaSizes.m)),
        boxShadow: [FreeBetaShadows.fluffy],
        color: FreeBetaColors.white,
      ),
      child: Row(
        children: [
          RouteColorIcon(route: route),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTitleRow(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    route.routeColor.displayName,
                    style: FreeBetaTextStyle.h2.copyWith(
                      color: FreeBetaColors.green,
                    ),
                  ),
                  Text(
                    route.climbType.displayName,
                    style: FreeBetaTextStyle.h2.copyWith(
                      color: FreeBetaColors.green,
                    ),
                  ),
                  Text(
                    route.difficulty,
                    style: FreeBetaTextStyle.h2.copyWith(
                      color: FreeBetaColors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Color',
          style: FreeBetaTextStyle.h2,
        ),
        Text(
          'Type',
          style: FreeBetaTextStyle.h2,
        ),
        Text(
          'Difficulty',
          style: FreeBetaTextStyle.h2,
        ),
      ],
    );
  }
}
