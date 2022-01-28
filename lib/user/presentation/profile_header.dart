import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/create_route_screen.dart';
import 'package:free_beta/user/infrastructure/user_api.dart';
import 'package:free_beta/user/presentation/sign_in_screen.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authenticationProvider).when(
          data: (user) {
            log(user.toString());
            if (user == null) {
              return _buildUnauthenticated(context);
            }
            return _buildAuthenticated(context, ref);
          },
          loading: () => CircularProgressIndicator(),
          error: (_, __) => Text('Error'),
        );
  }

  Widget _buildAuthenticated(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: FreeBetaPadding.mAll,
      child: Column(
        children: [
          ElevatedButton(
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
          SizedBox(height: FreeBetaSizes.m),
          ElevatedButton(
            onPressed: () async {
              var userApi = ref.read(userApiProvider);
              await userApi.signOut();
            },
            child: Center(
              child: Text(
                'Sign Out',
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
        ],
      ),
    );
  }

  Widget _buildUnauthenticated(BuildContext context) {
    return Padding(
      padding: FreeBetaPadding.mAll,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(SignInScreen.route()),
            child: Center(
              child: Text(
                'Sign In',
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
        ],
      ),
    );
  }
}
