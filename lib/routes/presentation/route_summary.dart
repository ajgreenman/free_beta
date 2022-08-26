import 'package:auto_size_text/auto_size_text.dart';
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

  TextStyle get textStyle =>
      isDetailed ? FreeBetaTextStyle.body2 : FreeBetaTextStyle.body3;

  TextStyle get headingTextStyle =>
      isDetailed ? FreeBetaTextStyle.h3 : FreeBetaTextStyle.h4;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildColor(),
                _buildName(context),
              ],
            ),
            ..._buildDate('Created', route.creationDate),
          ],
        ),
        Row(
          children: [
            _RouteTypeAndDifficultyRow(
              route: route,
              textStyle: textStyle,
            ),
            if (route.removalDate != null)
              ..._buildDate('Removed', route.removalDate),
          ],
        ),
      ],
    );
  }

  Widget _buildName(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Flexible(
      child: SizedBox(
        width: width / 2,
        child: AutoSizeText(
          route.truncatedDisplayName(isDetailed ? 17 : 30),
          style: headingTextStyle.copyWith(fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
      ),
    );
  }

  Widget _buildColor() {
    if (!isDetailed) return SizedBox.shrink();

    var colorSquare = RouteColorSquare(
      routeColor: route.routeColor,
      size: FreeBetaSizes.xl,
    );

    if (route.name.isEmpty) {
      return colorSquare;
    }

    return Padding(
      padding: const EdgeInsets.only(right: FreeBetaSizes.m),
      child: colorSquare,
    );
  }

  List<Widget> _buildDate(String label, DateTime? date) {
    if (!isDetailed) return [];

    return [
      Spacer(),
      Text(
        label + ': ' + DateFormat('MM/dd').formatWithNull(date),
        style: textStyle,
      ),
    ];
  }
}

class _RouteTypeAndDifficultyRow extends StatelessWidget {
  const _RouteTypeAndDifficultyRow({
    Key? key,
    required this.route,
    required this.textStyle,
  }) : super(key: key);

  final RouteModel route;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          route.climbType.displayName,
          style: textStyle,
        ),
        Padding(
          padding: FreeBetaPadding.sHorizontal,
          child: Text(
            '|',
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          route.difficulty,
          style: textStyle,
        ),
      ],
    );
  }
}
