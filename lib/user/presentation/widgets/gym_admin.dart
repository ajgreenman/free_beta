import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/create_route_screen.dart';
import 'package:free_beta/user/infrastructure/user_api.dart';

class GymAdmin extends ConsumerWidget {
  const GymAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(authenticationProvider).when(
            data: (user) {
              if (user == null) {
                return SizedBox.shrink();
              }
              return _buildAuthenticated(context);
            },
            loading: () => SizedBox.shrink(),
            error: (_, __) => SizedBox.shrink(),
          );

  Widget _buildAuthenticated(BuildContext context) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gym Admin',
            style: FreeBetaTextStyle.h2,
          ),
          SizedBox(height: FreeBetaSizes.l),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () =>
              Navigator.of(context).push(CreateRouteScreen.route()),
          child: Padding(
            padding: FreeBetaPadding.xlHorizontal,
            child: Text(
              'Create Route',
              style: FreeBetaTextStyle.h4.copyWith(
                color: FreeBetaColors.white,
              ),
            ),
          ),
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(
                width: 2,
              ),
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                vertical: FreeBetaSizes.ml,
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
