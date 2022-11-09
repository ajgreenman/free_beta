import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class FreeBetaBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) navigateTo;

  const FreeBetaBottomNavigationBar({
    required this.currentIndex,
    required this.navigateTo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: const Key('bottom-navigation'),
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: navigateTo,
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
          label: 'Profile',
          icon: _NavbarIcon(Icons.account_box),
        ),
      ],
    );
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
