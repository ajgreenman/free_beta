import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/widgets/switch.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';

class IncludeGraphDetailsSwitch extends ConsumerWidget {
  const IncludeGraphDetailsSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FreeBetaSwitch(
      switchKey: Key('details-graph-switch'),
      label: 'Detailed view',
      labelStyle: FreeBetaTextStyle.body3,
      initialValue: ref.watch(includeGraphDetailsProvider),
      onChanged: (value) =>
          ref.read(includeGraphDetailsProvider.notifier).update(value),
    );
  }
}
