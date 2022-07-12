import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';

class UserRouteTypeStats extends StatelessWidget {
  const UserRouteTypeStats({
    Key? key,
    required this.routes,
  }) : super(key: key);

  final List<RouteModel> routes;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      [],
      barGroupingType: BarGroupingType.stacked,
    );
  }
}
