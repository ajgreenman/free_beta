import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/free_beta_bottom_navigation_bar.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/choose_gym_screen.dart';
import 'package:free_beta/user/infrastructure/user_api.dart';
import 'package:free_beta/user/presentation/profile_screen.dart';
import 'package:free_beta/user/presentation/sign_in_screen.dart';

class FreeBeta extends ConsumerStatefulWidget {
  const FreeBeta({Key? key}) : super(key: key);

  @override
  ConsumerState<FreeBeta> createState() => _FreeBetaState();
}

class _FreeBetaState extends ConsumerState<FreeBeta> {
  int _currentIndex = 0;

  static const List<Widget> _screens = [
    ChooseGymScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('free-beta'),
      appBar: AppBar(
        title: Text('Free Beta'),
        actions: [
          _buildAuthenticationButton(context),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: FreeBetaBottomNavigationBar(
        currentIndex: _currentIndex,
        navigateTo: _navigateTo,
      ),
    );
  }

  Widget _buildAuthenticationButton(BuildContext context) {
    var button = ref.watch(authenticationProvider).whenOrNull(
      data: (user) {
        if (user == null) {
          return TextButton(
            onPressed: () => Navigator.of(context).push(
              SignInScreen.route(),
            ),
            child: Text(
              'Sign In',
              style: FreeBetaTextStyle.body4.copyWith(
                color: FreeBetaColors.white,
              ),
            ),
          );
        }
        return TextButton(
          onPressed: () async {
            await ref.read(userApiProvider).signOut();
          },
          child: Text(
            'Sign Out',
            style: FreeBetaTextStyle.body4.copyWith(
              color: FreeBetaColors.white,
            ),
          ),
        );
      },
    );

    return button ?? SizedBox.shrink();
  }

  void _navigateTo(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });
  }
}
