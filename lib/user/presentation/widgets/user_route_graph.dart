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
            includeRemovedRoutes: ref.watch(includeRemovedRoutesProvider),
          ),
          loading: () => _Loading(),
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
    required this.includeRemovedRoutes,
  }) : super(key: key);

  final ClimbType climbType;
  final List<UserRatingModel> userRatings;
  final bool includeGraphDetails;
  final bool includeRemovedRoutes;

  @override
  Widget build(BuildContext context) {
    var _interval = includeRemovedRoutes ? 10.0 : 1.0;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: BarChart(
          BarChartData(
            barGroups: userRatings.map(_mapBarGroupsByRating).toList(),
            groupsSpace: 4,
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
                  showTitles: true,
                  interval: _interval,
                  reservedSize: includeRemovedRoutes ? 28 : 22,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: _getBottomTitles,
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

  Widget _getBottomTitles(double i, TitleMeta _) {
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

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: MediaQuery.of(context).size.width - FreeBetaSizes.xl,
      child: SizedBox.square(
        dimension: FreeBetaSizes.l,
        child: Center(child: CircularProgressIndicator()),
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
