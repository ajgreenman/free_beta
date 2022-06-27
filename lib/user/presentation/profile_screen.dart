import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/user/infrastructure/user_api.dart';
import 'package:free_beta/user/presentation/contact_developer_screen.dart';
import 'package:free_beta/user/presentation/widgets/gym_admin.dart';
import 'package:free_beta/user/presentation/widgets/removed_routes.dart';
import 'package:free_beta/user/presentation/widgets/user_stats_card.dart';

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserStatsCard(),
            RemovedRoutes(),
            _GymAdmin(ref),
            _ContactDeveloper(),
            _CopyrightText(),
            SizedBox(height: FreeBetaSizes.m),
          ],
        ),
      ),
    );
  }
}

class _GymAdmin extends StatelessWidget {
  const _GymAdmin(this.ref, {Key? key}) : super(key: key);

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    var widget = ref.watch(authenticationProvider).whenOrNull(
      data: (user) {
        if (user != null && !user.isAnonymous) return GymAdmin();
      },
    );
    return widget ?? SizedBox.shrink();
  }
}

class _ContactDeveloper extends StatelessWidget {
  const _ContactDeveloper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).push(
        ContactDeveloperScreen.route(),
      ),
      child: Text('Contact Developer'),
    );
  }
}

class _CopyrightText extends StatelessWidget {
  const _CopyrightText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final copyrightYear = DateTime.now().year;

    return Center(
      child: Text(
        '© $copyrightYear Climb Elev8',
        style: FreeBetaTextStyle.body3.copyWith(
          color: FreeBetaColors.grayLight,
        ),
      ),
    );
  }
}
