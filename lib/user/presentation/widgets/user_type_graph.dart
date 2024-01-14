import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/app/presentation/widgets/color_square.dart';
import 'package:free_beta/user/infrastructure/models/user_types_model.dart';

class UserTypeGraph extends ConsumerWidget {
  const UserTypeGraph({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(fetchUserTypesGraphProvider).when(
          data: (userTypes) => _TypeGraph(
            userTypes: userTypes,
          ),
          loading: () => _Loading(),
          error: (error, stackTrace) => _ErrorCard(
            error: error,
            stackTrace: stackTrace,
          ),
        );
  }
}

class _TypeGraph extends StatelessWidget {
  const _TypeGraph({required this.userTypes});

  final UserTypesModel userTypes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LegendRow(
              color: FreeBetaColors.blueLight,
              label: 'Boulder',
            ),
            SizedBox(height: FreeBetaSizes.m),
            _LegendRow(
              color: FreeBetaColors.yellowBrand,
              label: 'Auto-belay',
            ),
            SizedBox(height: FreeBetaSizes.m),
            _LegendRow(
              color: FreeBetaColors.green,
              label: 'Top Rope',
            ),
            SizedBox(height: FreeBetaSizes.m),
            _LegendRow(
              color: FreeBetaColors.purpleBrand,
              label: 'Lead',
            ),
            SizedBox(height: FreeBetaSizes.m),
          ],
        ),
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: FreeBetaSizes.xxxl,
              sectionsSpace: 0.0,
              sections: [
                _getSection(
                  userTypes.boulders / userTypes.total,
                  FreeBetaColors.white,
                  FreeBetaColors.blueLight,
                ),
                _getSection(
                  userTypes.topRopes / userTypes.total,
                  FreeBetaColors.black,
                  FreeBetaColors.greenBrand,
                ),
                _getSection(
                  userTypes.autoBelays / userTypes.total,
                  FreeBetaColors.white,
                  FreeBetaColors.purpleBrand,
                ),
                _getSection(
                  userTypes.leads / userTypes.total,
                  FreeBetaColors.black,
                  FreeBetaColors.yellowBrand,
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
      titleStyle: FreeBetaTextStyle.body4.copyWith(color: color),
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
          'UserTypeGraph',
          'fetchUserTypeGraph',
        );

    return InfoCard(
      child: Text(
        'Error building graph, please try again later.',
      ),
    );
  }
}
