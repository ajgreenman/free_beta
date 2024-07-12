import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/widgets/switch.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';

class RemovedRoutesSwitch extends ConsumerWidget {
  const RemovedRoutesSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FreeBetaSwitch(
      switchKey: Key('removed-routes-switch'),
      label: 'Include removed routes: ',
      labelStyle: FreeBetaTextStyle.body3,
      initialValue: ref.watch(includeRemovedRoutesProvider),
      onChanged: (value) =>
          ref.read(includeRemovedRoutesProvider.notifier).update(value),
      expanded: true,
    );
  }
}
