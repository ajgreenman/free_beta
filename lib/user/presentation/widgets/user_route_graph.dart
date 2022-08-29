import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';

class UserRouteGraph extends ConsumerWidget {
  const UserRouteGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(fetchRoutesProvider).when(
          data: (routes) => _RouteGraph(),
          error: (_, __) => Text('Error'),
          loading: () => CircularProgressIndicator(),
        );
  }
}

class _RouteGraph extends StatelessWidget {
  const _RouteGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('graph');
  }
}
