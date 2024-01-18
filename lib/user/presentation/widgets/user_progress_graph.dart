import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/app/presentation/widgets/color_square.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/user/infrastructure/models/user_rating_model.dart';
import 'package:free_beta/user/infrastructure/models/user_rating_model_extensions.dart';

class UserProgressGraph extends ConsumerWidget {
  const UserProgressGraph({
    Key? key,
    required this.climbType,
  }) : super(key: key);

  final ClimbType climbType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(fetchRatingUserGraphProvider(climbType: climbType)).when(
          data: (userRatings) => _ProgressGraph(
            climbType: climbType,
            userRatings: userRatings,
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

class _ProgressGraph extends StatelessWidget {
  const _ProgressGraph({
    Key? key,
    required this.climbType,
    required this.userRatings,
  }) : super(key: key);

  final ClimbType climbType;
  final List<UserRatingModel> userRatings;

  UserProgressModel get _progressModel =>
      userRatings.getProgressModel(climbType);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LegendRow(
          color: FreeBetaColors.red,
          label: 'Unattempted',
        ),
        SizedBox(height: FreeBetaSizes.m),
        _LegendRow(
          color: FreeBetaColors.yellowBrand,
          label: 'In progress',
        ),
        SizedBox(height: FreeBetaSizes.m),
        _LegendRow(
          color: FreeBetaColors.green,
          label: 'Completed',
        ),
        SizedBox(height: FreeBetaSizes.m),
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: FreeBetaSizes.xxl,
              sectionsSpace: 0.0,
              sections: [
                _getSection(
                  _progressModel.unattempted / _progressModel.totalCount,
                  FreeBetaColors.black,
                  FreeBetaColors.red.withOpacity(0.7),
                ),
                _getSection(
                  _progressModel.inProgress / _progressModel.totalCount,
                  FreeBetaColors.black,
                  FreeBetaColors.yellowBrand.withOpacity(0.7),
                ),
                _getSection(
                  _progressModel.completed / _progressModel.totalCount,
                  FreeBetaColors.black,
                  FreeBetaColors.green.withOpacity(0.7),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  PieChartSectionData _getSection(
    double value,
    Color color,
    Color backgroundColor,
  ) {
    return PieChartSectionData(
      value: value,
      color: backgroundColor,
      title: (value * 100).toStringAsFixed(1) + '%',
      titleStyle: FreeBetaTextStyle.body3.copyWith(color: color),
      radius: FreeBetaSizes.xxxl,
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    Key? key,
    required this.color,
    required this.label,
  }) : super(key: key);

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ColorSquare(color: color),
        SizedBox(width: FreeBetaSizes.m),
        Text(label),
      ],
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
          'UserProgressGraph',
          'fetchRatingUserGraph',
        );

    return InfoCard(
      child: Text(
        'Error building graph, please try again later.',
      ),
    );
  }
}
