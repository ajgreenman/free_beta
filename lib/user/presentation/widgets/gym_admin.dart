import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return Padding(
      padding: FreeBetaPadding.mlAll,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 2,
            thickness: 2,
          ),
          SizedBox(height: FreeBetaSizes.l),
          Text(
            'Gym Admin',
            style: FreeBetaTextStyle.h3,
          ),
          SizedBox(height: FreeBetaSizes.l),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).push(CreateRouteScreen.route()),
              child: Center(
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
          ),
        ],
      ),
    );
  }
}
