import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/divider.dart';
import 'package:free_beta/app/presentation/widgets/form/checkbox.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:free_beta/user/presentation/widgets/user_graph_section.dart';
import 'package:free_beta/user/presentation/widgets/user_stats_section.dart';

class UserStatsScreen extends ConsumerWidget {
  static Route<dynamic> route({
    required bool isBoulder,
    required UserStatsModel userStatsModel,
  }) {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return UserStatsScreen(
        isBoulder: isBoulder,
        userStatsModel: userStatsModel,
      );
    });
  }

  final bool isBoulder;
  final UserStatsModel userStatsModel;

  const UserStatsScreen({
    Key? key,
    required this.isBoulder,
    required this.userStatsModel,
  }) : super(key: key);

  String get titleText => isBoulder ? 'Boulder Stats' : 'Rope Stats';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var routeStatsModel = isBoulder
        ? userStatsModel.boulders
        : userStatsModel
            .getCombinedRouteModel(ref.watch(includedClimbTypesProvider));
    return Scaffold(
      key: Key('user-stats'),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(titleText),
        leading: FreeBetaBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InfoCard(
              child: Column(
                children: [
                  if (!isBoulder) _RopeFilter(),
                  UserStatsSection(routeStatsModel: routeStatsModel),
                ],
              ),
            ),
            InfoCard(
              child: UserGraphSection(
                isBoulder: isBoulder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RopeFilter extends ConsumerWidget {
  const _RopeFilter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        FreeBetaCheckbox(
          label: 'Top Ropes',
          value: ref.watch(includeTopRopeInGraphProvider),
          onTap: () =>
              ref.read(includeTopRopeInGraphProvider.notifier).toggle(),
        ),
        FreeBetaCheckbox(
          label: 'Auto-belays',
          value: ref.watch(includeAutoBelayInGraphProvider),
          onTap: () =>
              ref.read(includeAutoBelayInGraphProvider.notifier).toggle(),
        ),
        FreeBetaCheckbox(
          label: 'Leads',
          value: ref.watch(includeLeadInGraphProvider),
          onTap: () => ref.read(includeLeadInGraphProvider.notifier).toggle(),
        ),
        SizedBox(height: FreeBetaSizes.m),
        FreeBetaDivider(),
        SizedBox(height: FreeBetaSizes.m),
      ],
    );
  }
}
