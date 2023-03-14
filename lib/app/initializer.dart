import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';

class Initializer extends ConsumerWidget {
  const Initializer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(fetchActiveRoutesProvider);
    ref.watch(messagingApiProvider).initialize();
    return child;
  }
}
