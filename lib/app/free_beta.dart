import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/widgets/free_beta_bottom_navigation_bar.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
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

  static List<Widget> _screens = [
    RouteListScreen(
      routeProvider: fetchFilteredRoutes,
      refreshProvider: fetchRoutesProvider,
    ),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('free-beta'),
      appBar: AppBar(
        title: Text('Free Beta'),
        actions: [
          _getAction(context),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: FreeBetaBottomNavigationBar(
        currentIndex: _currentIndex,
        navigateTo: _navigateTo,
      ),
    );
  }

  Widget _getAction(BuildContext context) {
    if (_currentIndex == 0) {
      return _HelpButton();
    }
    return _AuthenticationButton();
  }

  void _navigateTo(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });
  }
}

class _HelpButton extends StatelessWidget {
  const _HelpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class _AuthenticationButton extends ConsumerWidget {
  const _AuthenticationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var button = ref.watch(authenticationProvider).whenOrNull(
      data: (user) {
        if (user == null || user.isAnonymous) {
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
      },
    );

    return button ?? SizedBox.shrink();
  }
}
