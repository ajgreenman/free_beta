import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/divider.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
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

class _SuccessCard extends ConsumerWidget {
  const _SuccessCard({
    Key? key,
    required this.userStatsModel,
  }) : super(key: key);

  final UserStatsModel userStatsModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Current Stats',
                style: FreeBetaTextStyle.h2,
              ),
              SizedBox(width: FreeBetaSizes.l),
              _HelpButton(),
            ],
          ),
          SizedBox(height: FreeBetaSizes.m),
          UserStatsSection(routeStatsModel: userStatsModel.overall),
          SizedBox(height: FreeBetaSizes.m),
          FreeBetaDivider(),
          _UserStatsSection(
            key: Key('UserStatsCard-section-boulders'),
            climbType: ClimbType.boulder,
            routeStatsModel: userStatsModel.boulders,
          ),
          FreeBetaDivider(),
          _UserStatsSection(
            key: Key('UserStatsCard-section-topRopes'),
            climbType: ClimbType.topRope,
            routeStatsModel: userStatsModel.topRopes,
          ),
          FreeBetaDivider(),
          _UserStatsSection(
            key: Key('UserStatsCard-section-autoBelays'),
            climbType: ClimbType.autoBelay,
            routeStatsModel: userStatsModel.autoBelays,
          ),
          FreeBetaDivider(),
          _UserStatsSection(
            key: Key('UserStatsCard-section-leads'),
            climbType: ClimbType.lead,
            routeStatsModel: userStatsModel.leads,
          ),
        ],
      ),
    );
  }
}

class _UserStatsSection extends StatelessWidget {
  const _UserStatsSection({
    Key? key,
    required this.climbType,
    required this.routeStatsModel,
  }) : super(key: key);

  final ClimbType climbType;
  final RouteStatsModel routeStatsModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        UserStatsScreen.route(
          climbType: climbType,
          routeStatsModel: routeStatsModel,
        ),
      ),
      child: Padding(
        padding: FreeBetaPadding.lVertical,
        child: Row(
          children: [
            Text(
              climbType.pluralDisplayName,
              style: FreeBetaTextStyle.h3,
            ),
            SizedBox(width: FreeBetaSizes.m),
            Text(
              '(${routeStatsModel.total})',
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
          Text(
            'Current Stats',
            style: FreeBetaTextStyle.h2,
          ),
          SizedBox(height: FreeBetaSizes.m),
          _SkeletonRow(label: 'Total'),
          _SkeletonRow(label: 'Attempted'),
          _SkeletonRow(label: 'Completed'),
          _SkeletonRow(label: 'Favorited'),
          SizedBox(height: FreeBetaSizes.m),
          FreeBetaDivider(),
          _SkeletonCard(label: ClimbType.boulder.pluralDisplayName),
          FreeBetaDivider(),
          _SkeletonCard(label: ClimbType.topRope.pluralDisplayName),
          FreeBetaDivider(),
          _SkeletonCard(label: ClimbType.autoBelay.pluralDisplayName),
          FreeBetaDivider(),
          _SkeletonCard(label: ClimbType.lead.pluralDisplayName),
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
          Text(
            '(?)',
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
        Text(
          '?',
          style: FreeBetaTextStyle.body2.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: FreeBetaSizes.m),
      ],
    );
  }
}

class _HelpButton extends StatelessWidget {
  const _HelpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message:
          'Statistics do not include routes that have been removed from the gym.',
      triggerMode: TooltipTriggerMode.tap,
      margin: FreeBetaPadding.xxlHorizontal,
      padding: FreeBetaPadding.mAll,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(FreeBetaSizes.m),
        color: FreeBetaColors.black,
      ),
      textStyle: FreeBetaTextStyle.body4.copyWith(
        color: FreeBetaColors.white,
      ),
      child: Icon(
        Icons.help_outlined,
        color: FreeBetaColors.grayDark,
        size: FreeBetaSizes.xl,
      ),
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
