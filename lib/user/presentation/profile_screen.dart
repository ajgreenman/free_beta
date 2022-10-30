import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/divider.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/refresh_schedule_screen.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/routes/presentation/route_list_screen.dart';
import 'package:free_beta/user/infrastructure/user_providers.dart';
import 'package:free_beta/user/presentation/contact_developer_screen.dart';
import 'package:free_beta/user/presentation/widgets/gym_admin.dart';
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
            _UserActionsCard(),
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
      key: Key('ProfileScreen-contact'),
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

class _UserActionsCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var showRefreshSchedule = ref.watch(configApiProvider).showRefreshSchedule;
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Actions',
            style: FreeBetaTextStyle.h2,
          ),
          SizedBox(height: FreeBetaSizes.m),
          FreeBetaDivider(),
          if (showRefreshSchedule) ...[
            SizedBox(height: FreeBetaSizes.l),
            _RefreshScheduleCard(),
            SizedBox(height: FreeBetaSizes.l),
            FreeBetaDivider(),
          ],
          SizedBox(height: FreeBetaSizes.l),
          _RemovedRoutesCard(),
        ],
      ),
    );
  }
}

class _RefreshScheduleCard extends StatelessWidget {
  const _RefreshScheduleCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(RefreshScheduleScreen.route()),
      child: Row(
        children: [
          Text(
            'View refresh schedule',
            style: FreeBetaTextStyle.h3,
          ),
          Spacer(),
          Icon(
            Icons.keyboard_arrow_right,
            size: FreeBetaSizes.xxl,
            color: FreeBetaColors.blueDark,
          ),
        ],
      ),
    );
  }
}

class _RemovedRoutesCard extends StatelessWidget {
  const _RemovedRoutesCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        RouteListScreen.route(
          appBar: AppBar(
            title: Text('Removed Routes'),
            leading: FreeBetaBackButton(),
          ),
          routeProvider: fetchFilteredRemovedRoutes,
          refreshProvider: fetchRemovedRoutesProvider,
        ),
      ),
      child: Row(
        children: [
          Text(
            'View removed routes',
            style: FreeBetaTextStyle.h3,
          ),
          Spacer(),
          Icon(
            Icons.keyboard_arrow_right,
            size: FreeBetaSizes.xxl,
            color: FreeBetaColors.blueDark,
          ),
        ],
      ),
    );
  }
}
