import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/climb_type.dart';
import 'package:free_beta/app/enums/route_color.dart';
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
            _buildName(),
            _buildColor(),
          ],
        ),
        Row(
          children: [
            _buildType(),
            _buildDivider(),
            _buildDifficulty(),
          ],
        ),
        ..._buildDates(),
      ],
    );
  }

  Widget _buildName() {
    return Text(
      route.name,
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

    return Padding(
      padding: const EdgeInsets.only(left: FreeBetaSizes.m),
      child: RouteColorSquare(routeColor: route.routeColor),
    );
  }

  List<Widget> _buildDates() {
    if (!isDetailed) return [];

    return [
      _buildDate('Created', route.creationDate),
      _buildDate('Removed', route.removalDate),
    ];
  }

  Widget _buildDate(String label, DateTime? date) {
    return Text(
      label + ': ' + DateFormat('MM/dd').formatWithNull(date),
      style: FreeBetaTextStyle.body3,
    );
  }
}
