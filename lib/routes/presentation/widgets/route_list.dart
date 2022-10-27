import 'package:flutter/material.dart';
import 'package:free_beta/app/presentation/widgets/divider.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/presentation/route_card.dart';
import 'package:free_beta/routes/presentation/route_detail_screen.dart';

class RouteList extends StatelessWidget {
  const RouteList({
    Key? key,
    required this.routes,
    required this.onRefresh,
  }) : super(key: key);

  final List<RouteModel> routes;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    if (routes.isEmpty) {
      return _EmptyWidget();
    }

    if (onRefresh == null) {
      return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, index) => RouteCard(
          route: routes[index],
          onTap: (cardContext) => Navigator.of(cardContext).push(
            RouteDetailScreen.route(routes[index]),
          ),
        ),
        separatorBuilder: (_, __) => FreeBetaDivider(),
        itemCount: routes.length,
      );
    }

    return RefreshIndicator(
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, index) => RouteCard(
          route: routes[index],
          onTap: (cardContext) => Navigator.of(cardContext).push(
            RouteDetailScreen.route(routes[index]),
          ),
        ),
        separatorBuilder: (_, __) => FreeBetaDivider(),
        itemCount: routes.length,
      ),
      onRefresh: onRefresh!,
    );
  }
}

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: FreeBetaSizes.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sorry, no available routes',
              style: FreeBetaTextStyle.h3,
            ),
            SizedBox(height: FreeBetaSizes.m),
            Text(
              'Try clearing your filters if you have any',
              style: FreeBetaTextStyle.body4,
            ),
          ],
        ),
      ),
    );
  }
}
