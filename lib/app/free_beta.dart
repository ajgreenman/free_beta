import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/widgets/free_beta_bottom_navigation_bar.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/class/presentation/class_screen.dart';
import 'package:free_beta/gym/presentation/reset_admin_screen.dart';
import 'package:free_beta/gym/presentation/gym_maps_screen.dart';
import 'package:free_beta/gym/presentation/reset_schedule_screen.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/routes/presentation/route_help_screen.dart';
import 'package:free_beta/routes/presentation/route_list_screen.dart';
import 'package:free_beta/user/infrastructure/user_providers.dart';
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
    GymMapsScreen(),
    ResetScheduleScreen(),
    ClassScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('free-beta'),
      appBar: AppBar(
        title: Text('Climb Elev8'),
        actions: [
          _FreeBetaActions(currentIndex: _currentIndex),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: FreeBetaBottomNavigationBar(
        currentIndex: _currentIndex,
        navigateTo: _navigateTo,
      ),
    );
  }

  void _navigateTo(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });
  }
}

class _FreeBetaActions extends StatelessWidget {
  const _FreeBetaActions({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    if (currentIndex == 0) {
      return _HelpButton();
    }
    if (currentIndex == 2) {
      return _EditButton();
    }
    if (currentIndex == 4) {
      return _AuthenticationButton();
    }
    return SizedBox.shrink();
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

class _EditButton extends ConsumerWidget {
  const _EditButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(authenticationProvider).whenOrNull(
          data: (user) => user,
        );

    if (user == null || user.isAnonymous) {
      return SizedBox.shrink();
    }

    return IconButton(
      onPressed: () => Navigator.of(context).push(
        ResetAdminScreen.route(),
      ),
      icon: Icon(
        Icons.edit,
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
