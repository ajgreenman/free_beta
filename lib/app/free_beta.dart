import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/free_beta_actions.dart';
import 'package:free_beta/app/presentation/widgets/free_beta_bottom_navigation_bar.dart';
import 'package:free_beta/class/presentation/class_screen.dart';
import 'package:free_beta/gym/presentation/gym_maps_screen.dart';
import 'package:free_beta/gym/presentation/reset_schedule_screen.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/routes/presentation/route_list_screen.dart';
import 'package:free_beta/user/presentation/profile_screen.dart';

class FreeBeta extends ConsumerWidget {
  FreeBeta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _screens = [
      RouteListScreen(
        routeProvider: fetchFilteredRoutesProvider,
        refreshProvider: fetchActiveRoutesProvider,
      ),
      GymMapsScreen(),
      ResetScheduleScreen(),
      ClassScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      key: Key('free-beta'),
      appBar: AppBar(
        title: Text('Climb Elev8'),
        actions: [FreeBetaActions()],
      ),
      body: _screens[ref.watch(bottomNavProvider)],
      bottomNavigationBar: FreeBetaBottomNavigationBar(),
    );
  }
}
