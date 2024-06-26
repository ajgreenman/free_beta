import 'package:flutter/material.dart';
import 'package:free_beta/app/presentation/widgets/divider.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/presentation/route_card.dart';
import 'package:free_beta/routes/presentation/route_detail_screen.dart';

class RouteList extends StatelessWidget {
  const RouteList({
    Key? key,
    required this.scrollKey,
    required this.routes,
    required this.onRefresh,
  }) : super(key: key);

  final String scrollKey;
  final List<RouteModel> routes;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    if (routes.isEmpty) {
      return _EmptyList();
    }

    if (onRefresh == null) {
      return _RouteListView(
        scrollKey: scrollKey,
        routes: routes,
      );
    }

    return RefreshIndicator(
      child: _RouteListView(
        scrollKey: scrollKey,
        routes: routes,
      ),
      onRefresh: onRefresh!,
    );
  }
}

class _RouteListView extends StatelessWidget {
  const _RouteListView({
    required this.scrollKey,
    required this.routes,
  });

  final String scrollKey;
  final List<RouteModel> routes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: PageStorageKey(scrollKey),
      shrinkWrap: true,
      itemBuilder: (_, index) => RouteCard(
        route: routes[index],
        onTap: (cardContext) => Navigator.of(cardContext).push(
          RouteDetailScreen.route(routes, index),
        ),
      ),
      separatorBuilder: (_, __) => FreeBetaDivider(),
      itemCount: routes.length,
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList({
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
