import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/presentation/route_card.dart';

class RouteList extends StatelessWidget {
  const RouteList({
    Key? key,
    required this.routes,
    required this.onRefresh,
  }) : super(key: key);

  final List<RouteModel> routes;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    if (routes.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: FreeBetaSizes.l),
          child: Text(
            'Sorry, no available routes',
            style: FreeBetaTextStyle.h3,
          ),
        ),
      );
    }

    return Expanded(
      child: RefreshIndicator(
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (_, index) => RouteCard(route: routes[index]),
          separatorBuilder: (_, __) => Divider(height: 1, thickness: 1),
          itemCount: routes.length,
        ),
        onRefresh: onRefresh,
      ),
    );
  }
}
