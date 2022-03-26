import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';

class Initializer extends ConsumerWidget {
  const Initializer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(fetchRoutesProvider);
    return child;
  }
}
