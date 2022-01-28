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
        _buildNavbarItem(
          label: 'Routes',
          icon: Icons.format_list_bulleted,
        ),
        _buildNavbarItem(
          label: 'Profile',
          icon: Icons.account_box,
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildNavbarItem({
    required String label,
    required IconData icon,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(
        icon,
        key: Key('BottomNavigationBarItem-$label'),
        size: FreeBetaSizes.xl,
      ),
    );
  }
}
