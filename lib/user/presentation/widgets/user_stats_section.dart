import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';

class UserStatsSection extends StatelessWidget {
  const UserStatsSection({
    Key? key,
    required this.routeStatsModel,
  }) : super(key: key);

  final RouteStatsModel routeStatsModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StatsRow(
          label: 'Total',
          value: routeStatsModel.total,
        ),
        _StatsRow(
          label: 'Attempted',
          value: routeStatsModel.attempted,
        ),
        _StatsRow(
          label: 'Completed',
          value: routeStatsModel.completed,
        ),
        _StatsRow(
          label: 'Favorited',
          value: routeStatsModel.favorited,
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: FreeBetaTextStyle.h4,
        ),
        Spacer(),
        Text(
          value.toString(),
          style: FreeBetaTextStyle.body2.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: FreeBetaSizes.m),
      ],
    );
  }
}
