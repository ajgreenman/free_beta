import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/user/presentation/profile_header.dart';
import 'package:free_beta/user/presentation/user_stats.dart';

class ProfileScreen extends ConsumerWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return ProfileScreen();
    });
  }

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: Key('profile'),
      body: Column(
        children: [
          ProfileHeader(),
          UserStats(),
        ],
      ),
    );
  }
}
