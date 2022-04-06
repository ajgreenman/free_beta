import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/route_remote_data_provider.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';

class UserStats extends ConsumerWidget {
  const UserStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(fetchUserRoutesProvider).when(
            data: (userRoutes) => _onSuccess(userRoutes, ref),
            loading: () => _UserStatsSkeleton(),
            error: (error, stackTrace) =>
                _onError(ref, error, stackTrace, 'fetchUserRoutesProvider'),
          );

  Widget _onSuccess(UserStatsModel? userStatsModel, WidgetRef ref) {
    if (userStatsModel == null) {
      return _onError(ref, 'Invalid user', null, '_onSuccess');
    }

    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Stats',
            style: FreeBetaTextStyle.h2,
          ),
          SizedBox(height: FreeBetaSizes.m),
          _buildRow('Attempted', userStatsModel.attempted),
          _buildRow('Completed', userStatsModel.completed),
          _buildRow('Favorited', userStatsModel.favorited),
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

  Widget _buildRow(String label, int count) {
    return Row(
      children: [
        Text(
          label,
          style: FreeBetaTextStyle.h4,
        ),
        Spacer(),
        Text(
          count.toString(),
          style: FreeBetaTextStyle.body2.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
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
            'User Stats',
            style: FreeBetaTextStyle.h2,
          ),
          SizedBox(height: FreeBetaSizes.m),
          _buildRow('Attempted'),
          _buildRow('Completed'),
          _buildRow('Favorited'),
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
      ],
    );
  }
}
