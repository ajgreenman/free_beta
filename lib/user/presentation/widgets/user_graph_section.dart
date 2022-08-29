import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/route_color.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/presentation/route_color_square.dart';
import 'package:free_beta/user/presentation/widgets/user_route_graph.dart';

class UserGraphSection extends StatelessWidget {
  const UserGraphSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserRouteGraph(),
        SizedBox(height: FreeBetaSizes.m),
        _LegendRow(
          color: RouteColor.purple,
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
