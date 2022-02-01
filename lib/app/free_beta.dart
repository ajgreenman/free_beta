import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/free_beta_bottom_navigation_bar.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/presentation/route_help_screen.dart';
import 'package:free_beta/routes/presentation/route_list_screen.dart';
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
    RouteListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('free-beta'),
      appBar: AppBar(
        title: Text('Free Beta'),
        actions: [_getAction(context)],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: FreeBetaBottomNavigationBar(
        currentIndex: _currentIndex,
        navigateTo: _navigateTo,
      ),
    );
  }

  Widget _getAction(BuildContext context) {
    print(_currentIndex);
    if (_currentIndex == 0) {
      return _buildHelpButton();
    }
    return _buildAuthenticationButton(context);
  }

  Widget _buildHelpButton() {
    return IconButton(
      onPressed: () => Navigator.of(context).push(
        RouteHelpScreen.route(),
      ),
      icon: Icon(
        Icons.help_outlined,
        color: FreeBetaColors.white,
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
              'Gym Sign In',
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
