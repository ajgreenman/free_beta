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
  }) : super(key: key);

  final ClimbType climbType;
  final List<UserRatingModel> userRatings;

  static const _interval = 1.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: BarChart(
          BarChartData(
            barGroups: userRatings.map(_mapUserRatings).toList(),
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: FreeBetaColors.grayBackground,
                tooltipMargin: -100,
                tooltipHorizontalAlignment: FLHorizontalAlignment.right,
                fitInsideVertically: true,
                fitInsideHorizontally: true,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    climbType == ClimbType.boulder
                        ? '${BoulderRating.values.where((value) => value.isIncludedInGraph).elementAt(groupIndex).displayName}\n'
                        : '${CondensedYosemiteRating.values[groupIndex].displayName}\n',
                    FreeBetaTextStyle.h4,
                    textAlign: TextAlign.left,
                    children: [
                      TextSpan(
                        text:
                            'Unattempted: ${userRatings[groupIndex].unattemptedCount}\n',
                        style: FreeBetaTextStyle.body5,
                      ),
                      TextSpan(
                        text:
                            'In progress: ${userRatings[groupIndex].inProgressCount}\n',
                        style: FreeBetaTextStyle.body5,
                      ),
                      TextSpan(
                        text:
                            'Completed: ${userRatings[groupIndex].completedCount}',
                        style: FreeBetaTextStyle.body5,
                      ),
                    ],
                  );
                },
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
                  getTitlesWidget: (i, _) => SideTitleWidget(
                    axisSide: AxisSide.bottom,
                    child: Text(
                      climbType == ClimbType.boulder
                          ? BoulderRating.values[i.toInt()].displayName
                          : CondensedYosemiteRating
                              .values[i.toInt()].displayName,
                      style: FreeBetaTextStyle.body6,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData _mapUserRatings(UserRatingModel userRating) {
    return BarChartGroupData(
      x: climbType == ClimbType.boulder
          ? userRating.boulderRating!.index
          : userRating.yosemiteRating!.index,
      barRods: [
        BarChartRodData(
          toY: userRating.totalCount,
          color: FreeBetaColors.white,
          borderRadius: BorderRadius.zero,
          width: 16,
          rodStackItems: [
            BarChartRodStackItem(
              userRating.completed + userRating.inProgress,
              userRating.totalCount,
              FreeBetaColors.red.withOpacity(0.7),
            ),
            BarChartRodStackItem(
              userRating.completed,
              userRating.completed + userRating.inProgress,
              FreeBetaColors.yellowBrand.withOpacity(0.7),
            ),
            BarChartRodStackItem(
              0,
              userRating.completed,
              FreeBetaColors.green.withOpacity(0.7),
            ),
          ],
        ),
      ],
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
