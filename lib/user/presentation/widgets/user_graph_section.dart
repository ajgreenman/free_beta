import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/detailed_graph_switch.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/presentation/route_color_square.dart';
import 'package:free_beta/user/presentation/widgets/user_route_graph.dart';

class UserGraphSection extends StatelessWidget {
  const UserGraphSection({
    Key? key,
    required this.climbType,
  }) : super(key: key);

  final ClimbType climbType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LegendRow(
                  color: RouteColor.red,
                  label: 'Unattempted',
                ),
                SizedBox(height: FreeBetaSizes.m),
                _LegendRow(
                  color: RouteColor.yellow,
                  label: 'In progress',
                ),
                SizedBox(height: FreeBetaSizes.m),
                _LegendRow(
                  color: RouteColor.green,
                  label: 'Completed',
                ),
                SizedBox(height: FreeBetaSizes.m),
              ],
            ),
            Spacer(),
            if (climbType != ClimbType.boulder) IncludeGraphDetailsSwitch(),
          ],
        ),
        UserRouteGraph(climbType: climbType),
        SizedBox(height: FreeBetaSizes.m),
        _Disclaimer()
      ],
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    Key? key,
    required this.color,
    required this.label,
  }) : super(key: key);

  final RouteColor color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RouteColorSquare(routeColor: color),
        SizedBox(width: FreeBetaSizes.m),
        Text(label),
      ],
    );
  }
}

class _Disclaimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Not all routes will show up on graph.',
      style: FreeBetaTextStyle.body6.copyWith(fontStyle: FontStyle.italic),
    );
  }
}
