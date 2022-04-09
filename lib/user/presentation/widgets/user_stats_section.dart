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
        _buildRow('Total', routeStatsModel.total),
        _buildRow('Attempted', routeStatsModel.attempted),
        _buildRow('Completed', routeStatsModel.completed),
        _buildRow('Favorited', routeStatsModel.favorited),
      ],
    );
  }

  Widget _buildRow(String label, int count) {
    return Row(
      children: [
        Text(
          label,
          style: FreeBetaTextStyle.h4,
        ),
        Spacer(),
        Text(
          count.toString(),
          style: FreeBetaTextStyle.body2.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: FreeBetaSizes.m),
      ],
    );
  }
}
