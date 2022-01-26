import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/climb_type.dart';
import 'package:free_beta/app/extensions/date_extensions.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/presentation/route_color_square.dart';
import 'package:intl/intl.dart';

class RouteSummary extends StatelessWidget {
  const RouteSummary(
    this.route, {
    this.isDetailed = false,
    Key? key,
  }) : super(key: key);

  final bool isDetailed;
  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Row(
              children: [
                _buildName(),
                _buildColor(),
              ],
            ),
            ..._buildDate('Created', route.creationDate),
          ],
        ),
        Row(
          children: [
            Row(
              children: [
                _buildType(),
                _buildDivider(),
                _buildDifficulty(),
              ],
            ),
            if (route.removalDate != null)
              ..._buildDate('Removed', route.removalDate),
          ],
        ),
      ],
    );
  }

  Widget _buildName() {
    return Text(
      route.truncatedDisplayName,
      style: FreeBetaTextStyle.h4.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: FreeBetaPadding.sHorizontal,
      child: Text(
        '|',
        style: FreeBetaTextStyle.body3.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildType() {
    return Text(
      route.climbType.displayName,
      style: FreeBetaTextStyle.body3,
    );
  }

  Widget _buildDifficulty() {
    return Text(
      route.difficulty,
      style: FreeBetaTextStyle.body3,
    );
  }

  Widget _buildColor() {
    if (!isDetailed) return SizedBox.shrink();

    var colorSquare = RouteColorSquare(routeColor: route.routeColor);

    if (route.name.isEmpty) {
      return colorSquare;
    }

    return Padding(
      padding: const EdgeInsets.only(left: FreeBetaSizes.m),
      child: colorSquare,
    );
  }

  List<Widget> _buildDate(String label, DateTime? date) {
    if (!isDetailed) return [];

    return [
      Spacer(),
      Text(
        label + ': ' + DateFormat('MM/dd').formatWithNull(date),
        style: FreeBetaTextStyle.body3,
      ),
    ];
  }
}