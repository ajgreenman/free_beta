import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
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
    return ref.watch(fetchRatingUserGraph(climbType)).when(
          data: (series) => _RatingGraph(
            series: series,
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
    required this.series,
  }) : super(key: key);

  final List<Series<UserRatingModel, String>> series;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 325,
      child: BarChart(
        series,
        barGroupingType: BarGroupingType.stacked,
        domainAxis: OrdinalAxisSpec(
          renderSpec: SmallTickRendererSpec(
            labelStyle: TextStyleSpec(
              fontSize: 8,
            ),
          ),
        ),
        animate: false,
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
