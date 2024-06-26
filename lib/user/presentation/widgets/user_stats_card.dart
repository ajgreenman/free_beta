import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/divider.dart';
import 'package:free_beta/app/presentation/widgets/help_tooltip.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/presentation/widgets/removed_routes_switch.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:free_beta/user/presentation/user_stats_screen.dart';
import 'package:free_beta/user/presentation/widgets/user_stats_section.dart';

class UserStatsCard extends ConsumerWidget {
  const UserStatsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(fetchUserStatsProvider).when(
            data: (userStats) => _SuccessCard(
              key: Key('UserStatsCard-success'),
              userStatsModel: userStats,
            ),
            loading: () => _UserStatsSkeleton(
              key: Key('UserStatsCard-skeleton'),
            ),
            error: (error, stackTrace) => _ErrorCard(
              key: Key('UserStatsCard-error'),
              error: error,
              stackTrace: stackTrace,
              methodName: 'fetchUserStatsProvider',
            ),
          );
}

class _SuccessCard extends StatelessWidget {
  const _SuccessCard({
    Key? key,
    required this.userStatsModel,
  }) : super(key: key);

  final UserStatsModel userStatsModel;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TitleRow(),
          SizedBox(height: FreeBetaSizes.m),
          _SwitchRow(),
          SizedBox(height: FreeBetaSizes.m),
          UserStatsSection(routeStatsModel: userStatsModel.overall),
          SizedBox(height: FreeBetaSizes.m),
          FreeBetaDivider(),
          _UserStatsSection(
            key: Key('UserStatsCard-section-boulders'),
            isBoulder: true,
            userStatsModel: userStatsModel,
          ),
          FreeBetaDivider(),
          _UserStatsSection(
            key: Key('UserStatsCard-section-ropes'),
            isBoulder: false,
            userStatsModel: userStatsModel,
          ),
        ],
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RemovedRoutesSwitch(),
        SizedBox(width: FreeBetaSizes.l),
        HelpTooltip(
          message: 'Turning this on may increase loading times.',
        ),
      ],
    );
  }
}

class _TitleRow extends StatelessWidget {
  const _TitleRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Current Stats',
          style: FreeBetaTextStyle.h2,
        ),
        SizedBox(width: FreeBetaSizes.l),
        HelpTooltip(
          message:
              'Statistics do not include routes that have been removed from the gym.',
        ),
      ],
    );
  }
}

class _UserStatsSection extends StatelessWidget {
  const _UserStatsSection({
    Key? key,
    required this.isBoulder,
    required this.userStatsModel,
  }) : super(key: key);

  final bool isBoulder;
  final UserStatsModel userStatsModel;

  String get label => isBoulder ? 'Boulders' : 'Rope climbs';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        UserStatsScreen.route(
          isBoulder: isBoulder,
          userStatsModel: userStatsModel,
        ),
      ),
      child: Padding(
        padding: FreeBetaPadding.lVertical,
        child: Row(
          children: [
            Text(
              label,
              style: FreeBetaTextStyle.h3,
            ),
            SizedBox(width: FreeBetaSizes.m),
            Text(
              '(${isBoulder ? userStatsModel.boulders.total : userStatsModel.ropes.total})',
              style: FreeBetaTextStyle.h4,
            ),
            Spacer(),
            Icon(
              Icons.keyboard_arrow_right,
              size: FreeBetaSizes.xxl,
              color: FreeBetaColors.blueDark,
            ),
          ],
        ),
      ),
    );
  }
}

class _UserStatsSkeleton extends StatelessWidget {
  const _UserStatsSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TitleRow(),
          SizedBox(height: FreeBetaSizes.m),
          _SwitchRow(),
          SizedBox(height: FreeBetaSizes.m),
          _SkeletonRow(label: 'Total'),
          _SkeletonRow(label: 'Attempted'),
          _SkeletonRow(label: 'Completed'),
          _SkeletonRow(label: 'Favorited'),
          _SkeletonRow(label: 'Height climbed'),
          SizedBox(height: FreeBetaSizes.m),
          FreeBetaDivider(),
          _SkeletonCard(label: ClimbType.boulder.pluralDisplayName),
          FreeBetaDivider(),
          _SkeletonCard(label: 'Rope climbs'),
        ],
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FreeBetaPadding.lVertical,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: FreeBetaTextStyle.h3,
          ),
          SizedBox(width: FreeBetaSizes.m),
          _LoadingIcon(),
          Spacer(),
          Icon(
            Icons.keyboard_arrow_right,
            size: FreeBetaSizes.xxl,
            color: FreeBetaColors.blueDark,
          ),
        ],
      ),
    );
  }
}

class _SkeletonRow extends StatelessWidget {
  const _SkeletonRow({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: FreeBetaTextStyle.h4,
        ),
        Spacer(),
        _LoadingIcon(),
        SizedBox(width: FreeBetaSizes.m),
      ],
    );
  }
}

class _ErrorCard extends ConsumerWidget {
  const _ErrorCard({
    Key? key,
    required this.error,
    required this.stackTrace,
    required this.methodName,
  }) : super(key: key);

  final Object error;
  final StackTrace? stackTrace;
  final String methodName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(crashlyticsApiProvider).logError(
          error,
          stackTrace,
          'UserStats',
          methodName,
        );

    return InfoCard(
      child: Text(
        'Because you have an account, you must sign in to see your user stats.',
      ),
    );
  }
}

class _LoadingIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: SizedBox.square(
        dimension: FreeBetaSizes.l,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
