import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/user/infrastructure/user_api.dart';
import 'package:free_beta/user/presentation/widgets/app_settings.dart';
import 'package:free_beta/user/presentation/widgets/gym_admin.dart';
import 'package:free_beta/user/presentation/widgets/removed_routes.dart';
import 'package:free_beta/user/presentation/widgets/user_stats.dart';

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
            UserStats(),
            _getGymAdmin(ref),
            RemovedRoutes(),
            AppSettings(),
            _CopyrightText(),
          ],
        ),
      ),
    );
  }

  Widget _getGymAdmin(WidgetRef ref) {
    var value = ref.watch(authenticationProvider).whenOrNull(
      data: (user) {
        if (user != null) return GymAdmin();
      },
    );
    return value ?? SizedBox.shrink();
  }
}

class _CopyrightText extends StatelessWidget {
  const _CopyrightText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final copyrightYear = DateTime.now().year;

    return Text(
      '© $copyrightYear Free Beta',
      style: FreeBetaTextStyle.body3.copyWith(
        color: FreeBetaColors.grayLight,
      ),
    );
  }
}
