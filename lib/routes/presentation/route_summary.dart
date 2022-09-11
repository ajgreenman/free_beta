import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/enums.dart';
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
              mainAxisSize: MainAxisSize.min,
              children: [
                _ColorSquare(
                  name: route.name,
                  color: route.routeColor,
                  isDetailed: isDetailed,
                ),
                _NameText(
                  name: route.name,
                  isDetailed: isDetailed,
                ),
              ],
            ),
            if (isDetailed) ...[
              Spacer(),
              _DateText(label: 'Created', date: route.creationDate),
            ]
          ],
        ),
        Row(
          children: [
            _RouteTypeAndDifficultyRow(
              route: route,
              isDetailed: isDetailed,
            ),
            if (isDetailed && route.removalDate != null) ...[
              Spacer(),
              _DateText(label: 'Removed', date: route.removalDate),
            ],
          ],
        ),
      ],
    );
  }
}

class _DateText extends StatelessWidget {
  const _DateText({
    Key? key,
    required this.label,
    required this.date,
  }) : super(key: key);

  final String label;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Text(
      label + ': ' + DateFormat('MM/dd').formatWithNull(date),
      style: FreeBetaTextStyle.body2,
    );
  }
}

class _NameText extends StatelessWidget {
  const _NameText({
    Key? key,
    required this.name,
    required this.isDetailed,
  }) : super(key: key);

  final String name;
  final bool isDetailed;

  TextStyle get headingTextStyle =>
      isDetailed ? FreeBetaTextStyle.h3 : FreeBetaTextStyle.h4;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Flexible(
      child: SizedBox(
        width: width / 2,
        child: AutoSizeText(
          name,
          style: headingTextStyle.copyWith(fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
      ),
    );
  }
}

class _ColorSquare extends StatelessWidget {
  const _ColorSquare({
    Key? key,
    required this.name,
    required this.color,
    required this.isDetailed,
  }) : super(key: key);

  final String name;
  final RouteColor color;
  final bool isDetailed;

  @override
  Widget build(BuildContext context) {
    if (!isDetailed) return SizedBox.shrink();

    var colorSquare = RouteColorSquare(
      routeColor: color,
      size: FreeBetaSizes.xl,
    );

    if (name.isEmpty) {
      return colorSquare;
    }

    return Padding(
      padding: const EdgeInsets.only(right: FreeBetaSizes.m),
      child: colorSquare,
    );
  }
}

class _RouteTypeAndDifficultyRow extends StatelessWidget {
  const _RouteTypeAndDifficultyRow({
    Key? key,
    required this.route,
    required this.isDetailed,
  }) : super(key: key);

  final RouteModel route;
  final bool isDetailed;

  TextStyle get textStyle =>
      isDetailed ? FreeBetaTextStyle.body2 : FreeBetaTextStyle.body3;

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
          route.boulderRating?.displayName ??
              route.yosemiteRating?.displayName ??
              '',
          style: textStyle,
        ),
      ],
    );
  }
}
