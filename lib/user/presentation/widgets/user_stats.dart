import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/route_local_data_provider.dart';

class UserStats extends ConsumerWidget {
  const UserStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(fetchUserRoutesProvider).when(
            data: (userRoutes) => _onSuccess(userRoutes),
            loading: () => _UserStatsSkeleton(),
            error: (error, stackTrace) => _onError(error, stackTrace),
          );

  Widget _onSuccess(UserRoutes userRoutes) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Stats',
            style: FreeBetaTextStyle.h2,
          ),
          SizedBox(height: FreeBetaSizes.m),
          _buildRow('Attempted', userRoutes.attempted),
          _buildRow('Completed', userRoutes.completed),
          _buildRow('Favorited', userRoutes.favorited),
        ],
      ),
    );
  }

  Widget _onError(Object error, StackTrace? stackTrace) {
    print(error);
    print(stackTrace);
    return Text('Sorry, an error occured.');
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
