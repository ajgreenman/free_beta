import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
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
          error: (_, __) =>
              Text('Error building graph, please try again later.'),
          loading: () => CircularProgressIndicator(),
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
      height: 350,
      child: BarChart(
        series,
        barGroupingType: BarGroupingType.stacked,
        animate: false,
      ),
    );
  }
}
