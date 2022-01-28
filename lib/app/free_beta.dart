import 'package:flutter/material.dart';
import 'package:free_beta/app/presentation/free_beta_bottom_navigation_bar.dart';
import 'package:free_beta/gym/presentation/choose_gym_screen.dart';
import 'package:free_beta/user/presentation/profile_screen.dart';

class FreeBeta extends StatefulWidget {
  const FreeBeta({Key? key}) : super(key: key);

  @override
  State<FreeBeta> createState() => _FreeBetaState();
}

class _FreeBetaState extends State<FreeBeta> {
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
        title: Center(child: Text('Free Beta')),
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
