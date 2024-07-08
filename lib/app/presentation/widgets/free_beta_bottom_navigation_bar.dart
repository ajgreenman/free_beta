import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';

class FreeBetaBottomNavigationBar extends ConsumerWidget {
  const FreeBetaBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      key: const Key('bottom-navigation'),
      type: BottomNavigationBarType.fixed,
      currentIndex: ref.watch(bottomNavProvider),
      onTap: (i) => setIndex(i, ref),
      unselectedItemColor: FreeBetaColors.grayLight,
      items: [
        BottomNavigationBarItem(
          label: 'Routes',
          icon: _NavbarIcon(Icons.format_list_bulleted),
        ),
        BottomNavigationBarItem(
          label: 'Maps',
          icon: _NavbarIcon(Icons.map_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Schedule',
          icon: _NavbarIcon(Icons.calendar_month_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Classes',
          icon: _NavbarIcon(Icons.self_improvement),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: _NavbarIcon(Icons.account_box),
        ),
      ],
    );
  }

  void setIndex(int index, WidgetRef ref) {
    var currentIndex = ref.read(bottomNavProvider);
    if (currentIndex == 0 && index == 0) {
      ref.read(routeListScrollControllerProvider).scrollToTop();
    }

    ref.read(bottomNavProvider.notifier).setIndex(index);
  }
}

class _NavbarIcon extends StatelessWidget {
  const _NavbarIcon(
    this.icon, {
    Key? key,
  }) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: FreeBetaSizes.xl,
    );
  }
}
