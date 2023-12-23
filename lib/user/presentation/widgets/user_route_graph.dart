import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/user/infrastructure/models/user_rating_model.dart';

class UserRouteGraph extends ConsumerWidget {
  const UserRouteGraph({
    Key? key,
    required this.climbType,
  }) : super(key: key);

  final ClimbType climbType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(fetchRatingUserGraphProvider(climbType: climbType)).when(
          data: (userRatings) => _RatingGraph(
            climbType: climbType,
            userRatings: userRatings,
            includeGraphDetails: ref.watch(includeGraphDetailsProvider),
          ),
          loading: () => CircularProgressIndicator(),
          error: (error, stackTrace) => _ErrorCard(
            key: Key('UserRouteGraph-error'),
            error: error,
            stackTrace: stackTrace,
          ),
        );
  }
}

class _RatingGraph extends StatelessWidget {
  const _RatingGraph({
    Key? key,
    required this.climbType,
    required this.userRatings,
    required this.includeGraphDetails,
  }) : super(key: key);

  final ClimbType climbType;
  final List<UserRatingModel> userRatings;
  final bool includeGraphDetails;

  static const _interval = 1.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: BarChart(
          BarChartData(
            barGroups: userRatings.map(_mapBarGroupsByRating).toList(),
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: FreeBetaColors.grayBackground,
                tooltipMargin: -100,
                tooltipHorizontalAlignment: FLHorizontalAlignment.right,
                fitInsideVertically: true,
                fitInsideHorizontally: true,
                getTooltipItem: _getTooltipItem,
              ),
            ),
            borderData: FlBorderData(
              border: Border(
                top: BorderSide(color: FreeBetaColors.grayBackground),
                bottom: BorderSide(),
              ),
            ),
            gridData: FlGridData(
              drawVerticalLine: false,
              horizontalInterval: _interval,
            ),
            titlesData: FlTitlesData(
              topTitles: AxisTitles(),
              rightTitles: AxisTitles(),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  interval: _interval,
                  showTitles: true,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: _getAxisLabels,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData _mapBarGroupsByRating(UserRatingModel userRating) {
    if (climbType == ClimbType.boulder) {
      return userRating.boulderUserRatingModel!.barChart;
    }

    if (!includeGraphDetails) {
      return userRating.yosemiteUserRatingModel!.condensedBarChart;
    }

    return userRating.yosemiteUserRatingModel!.detailedBarChart;
  }

  BarTooltipItem? _getTooltipItem(
    BarChartGroupData group,
    int groupIndex,
    BarChartRodData rod,
    int rodIndex,
  ) {
    if (climbType == ClimbType.boulder) {
      return BarTooltipItem(
        '${BoulderRating.values.where((value) => value.isIncludedInGraph).elementAt(groupIndex).displayName}\n',
        FreeBetaTextStyle.h4,
        textAlign: TextAlign.left,
        children: userRatings[groupIndex]
            .boulderUserRatingModel!
            .userProgressModel
            .getTooltipData,
      );
    }

    if (!includeGraphDetails) {
      return BarTooltipItem(
        '${CondensedYosemiteRating.values[groupIndex].displayName}\n',
        FreeBetaTextStyle.h4,
        textAlign: TextAlign.left,
        children: userRatings[groupIndex]
            .yosemiteUserRatingModel!
            .userProgressModel
            .getTooltipData,
      );
    }

    var detailedUserRating = userRatings[groupIndex]
        .yosemiteUserRatingModel!
        .detailedUserProgressModels[rodIndex];

    return BarTooltipItem(
      '${detailedUserRating.yosemiteRating.displayName}\n',
      FreeBetaTextStyle.h4,
      textAlign: TextAlign.left,
      children: detailedUserRating.userProgressModel.getTooltipData,
    );
  }

  Widget _getAxisLabels(double i, TitleMeta _) {
    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      child: Text(
        climbType == ClimbType.boulder
            ? BoulderRating.values[i.toInt()].displayName
            : CondensedYosemiteRating.values[i.toInt()].displayName,
        style: FreeBetaTextStyle.body6,
      ),
    );
  }
}

class _ErrorCard extends ConsumerWidget {
  const _ErrorCard({
    Key? key,
    required this.error,
    required this.stackTrace,
  }) : super(key: key);

  final Object error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(crashlyticsApiProvider).logError(
          error,
          stackTrace,
          'UserRouteGraph',
          'fetchRatingUserGraph',
        );

    return InfoCard(
      child: Text(
        'Error building graph, please try again later.',
      ),
    );
  }
}
