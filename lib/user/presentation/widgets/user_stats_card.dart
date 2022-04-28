import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:free_beta/user/presentation/user_stats_screen.dart';
import 'package:free_beta/user/presentation/widgets/user_stats_section.dart';

class UserStatsCard extends ConsumerWidget {
  const UserStatsCard({Key? key}) : super(key: key);

  static const currentStatsTitle = 'Current Stats';

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(fetchUserStatsProvider).when(
            data: (userStats) => _onSuccess(userStats, ref),
            loading: () => _UserStatsSkeleton(),
            error: (error, stackTrace) =>
                _onError(ref, error, stackTrace, 'fetchUserStatsProvider'),
          );

  Widget _onSuccess(UserStatsModel? userStatsModel, WidgetRef ref) {
    if (userStatsModel == null) {
      return _onError(ref, 'Invalid user', null, '_onSuccess');
    }

    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                currentStatsTitle,
                style: FreeBetaTextStyle.h2,
              ),
              SizedBox(width: FreeBetaSizes.l),
              _HelpButton(),
            ],
          ),
          SizedBox(height: FreeBetaSizes.m),
          UserStatsSection(routeStatsModel: userStatsModel.overall),
          SizedBox(height: FreeBetaSizes.m),
          Divider(
            height: 1,
            thickness: 1,
          ),
          _UserStatsSection(
            climbType: ClimbType.boulder,
            routeStatsModel: userStatsModel.boulders,
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          _UserStatsSection(
            climbType: ClimbType.topRope,
            routeStatsModel: userStatsModel.topRopes,
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          _UserStatsSection(
            climbType: ClimbType.autoBelay,
            routeStatsModel: userStatsModel.autoBelays,
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          _UserStatsSection(
            climbType: ClimbType.lead,
            routeStatsModel: userStatsModel.leads,
          ),
        ],
      ),
    );
  }

  Widget _onError(
    WidgetRef ref,
    Object error,
    StackTrace? stackTrace,
    String methodName,
  ) {
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
            UserStatsCard.currentStatsTitle,
            style: FreeBetaTextStyle.h2,
          ),
          SizedBox(height: FreeBetaSizes.m),
          _buildRow('Total'),
          _buildRow('Attempted'),
          _buildRow('Completed'),
          _buildRow('Favorited'),
          SizedBox(height: FreeBetaSizes.m),
          Divider(
            height: 1,
            thickness: 1,
          ),
          _buildCard(
            ClimbType.boulder.pluralDisplayName,
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          _buildCard(
            ClimbType.topRope.pluralDisplayName,
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          _buildCard(
            ClimbType.autoBelay.pluralDisplayName,
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          _buildCard(
            ClimbType.lead.pluralDisplayName,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label) {
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

  Widget _buildCard(String label) {
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
