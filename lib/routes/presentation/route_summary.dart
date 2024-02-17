import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/extensions/date_extensions.dart';
import 'package:free_beta/app/presentation/widgets/free_beta_separator.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/infrastructure/gym_providers.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model_extensions.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/app/presentation/widgets/color_square.dart';
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
    if (isDetailed) {
      return _DetailedRouteSummary(route: route);
    }

    return _SimpleRouteSummary(route: route);
  }
}

class _SimpleRouteSummary extends StatelessWidget {
  const _SimpleRouteSummary({
    required this.route,
    Key? key,
  }) : super(key: key);

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    if (route.name.isEmpty) {
      return SizedBox(
        height: FreeBetaSizes.xxl,
        child: _RouteTypeAndDifficultyRow(
          route: route,
          isDetailed: false,
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NameText(
          name: route.name,
        ),
        _RouteTypeAndDifficultyRow(
          route: route,
          isDetailed: false,
        ),
      ],
    );
  }
}

class _DetailedRouteSummary extends StatelessWidget {
  const _DetailedRouteSummary({
    required this.route,
    Key? key,
  }) : super(key: key);

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
                  color: route.routeColor.displayColor,
                ),
                _RouteTypeAndDifficultyRow(
                  route: route,
                  isDetailed: true,
                ),
              ],
            ),
            Spacer(),
            _DateText(label: 'Created', date: route.creationDate),
          ],
        ),
        Row(
          children: [
            if (route.removalDate != null) ...[
              Spacer(),
              _DateText(label: 'Removed', date: route.removalDate),
            ],
          ],
        ),
      ],
    );
  }
}

class _NameText extends StatelessWidget {
  const _NameText({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Flexible(
      child: SizedBox(
        width: width / 2,
        child: AutoSizeText(
          name,
          style: FreeBetaTextStyle.h5.copyWith(fontWeight: FontWeight.bold),
          maxLines: 1,
          minFontSize: 10,
        ),
      ),
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
      style: FreeBetaTextStyle.body3,
    );
  }
}

class _ColorSquare extends StatelessWidget {
  const _ColorSquare({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: FreeBetaSizes.m),
      child: ColorSquare(
        color: color,
        size: FreeBetaSizes.xl,
      ),
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
      isDetailed ? FreeBetaTextStyle.body3 : FreeBetaTextStyle.body4;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          route.climbType.displayName,
          style: textStyle,
        ),
        FreeBetaSeparator(textStyle: textStyle),
        Text(
          route.boulderRating?.displayName ??
              route.yosemiteRating?.displayName ??
              '',
          style: textStyle,
        ),
        _RouteIcon(
          route: route,
          textStyle: textStyle,
        ),
      ],
    );
  }
}

class _RouteIcon extends ConsumerWidget {
  const _RouteIcon({
    required this.route,
    required this.textStyle,
  });

  final RouteModel route;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (route.removalDate != null) return SizedBox.shrink();

    var resetSchedule = ref.watch(resetScheduleProvider).whenOrNull(
          data: (resetSchedule) => resetSchedule,
        );
    if (resetSchedule == null) return SizedBox.shrink();

    var latestReset = resetSchedule.latestReset;
    if (latestReset == null) return SizedBox.shrink();

    if (latestReset.containsRouteInSection(route) &&
        latestReset.hadRouteInReset(route)) {
      return Row(
        children: [
          FreeBetaSeparator(textStyle: textStyle),
          Icon(
            Icons.fiber_new,
          ),
        ],
      );
    }

    var nextReset = resetSchedule.nextReset;
    if (nextReset == null) return SizedBox.shrink();

    if (!nextReset.containsRouteInSection(route)) {
      return SizedBox.shrink();
    }

    return Row(
      children: [
        FreeBetaSeparator(textStyle: textStyle),
        Icon(
          Icons.warning_outlined,
        ),
      ],
    );
  }
}
