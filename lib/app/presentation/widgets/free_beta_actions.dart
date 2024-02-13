import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/presentation/widgets/chalkboard.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/class/presentation/class_admin_screen.dart';
import 'package:free_beta/gym/presentation/reset_admin_screen.dart';
import 'package:free_beta/routes/presentation/route_help_screen.dart';
import 'package:free_beta/user/infrastructure/user_providers.dart';
import 'package:free_beta/user/presentation/sign_in_screen.dart';

class FreeBetaActions extends ConsumerWidget {
  const FreeBetaActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);
    if (currentIndex == 0) {
      return _RouteHelpButton();
    }
    if (currentIndex == 2) {
      return _EditScheduleButton();
    }
    if (currentIndex == 3) {
      return _ClassesButton();
    }
    if (currentIndex == 4) {
      return _AuthenticationButton();
    }
    return SizedBox.shrink();
  }
}

class _RouteHelpButton extends StatelessWidget {
  const _RouteHelpButton({Key? key}) : super(key: key);

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

class _ClassesButton extends ConsumerWidget {
  const _ClassesButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(authenticationStreamProvider).whenOrNull(
          data: (user) => user,
        );

    if (user == null || user.isAnonymous) {
      return _ClassesLegendButton();
    }

    return _EditClassesButton();
  }
}

class _EditClassesButton extends StatelessWidget {
  const _EditClassesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).push(
        ClassAdminScreen.route(),
      ),
      icon: Icon(
        Icons.edit,
        color: FreeBetaColors.white,
      ),
    );
  }
}

class _ClassesLegendButton extends StatelessWidget {
  const _ClassesLegendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (_) => _LegendDialog(),
        );
      },
      icon: Icon(
        Icons.help_outlined,
        color: FreeBetaColors.white,
      ),
    );
  }
}

class _EditScheduleButton extends ConsumerWidget {
  const _EditScheduleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(authenticationStreamProvider).whenOrNull(
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
    var button = ref.watch(authenticationStreamProvider).whenOrNull(
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

class _LegendDialog extends StatelessWidget {
  const _LegendDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 48.0),
        child: Chalkboard(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Padding(
            padding: FreeBetaPadding.lAll,
            child: Column(
              children: [
                Text(
                  "Color legend",
                  style: FreeBetaTextStyle.h3.copyWith(
                    color: FreeBetaColors.white,
                  ),
                ),
                SizedBox(height: FreeBetaSizes.l),
                _LegendRow(
                  name: "Green",
                  type: "Yoga",
                  color: FreeBetaColors.greenBrand,
                ),
                _LegendRow(
                  name: "Yellow",
                  type: "Climbing",
                  color: FreeBetaColors.yellowBrand,
                ),
                _LegendRow(
                  name: "Purple",
                  type: "Fitness/Other",
                  color: FreeBetaColors.purpleBrand,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    Key? key,
    required this.name,
    required this.type,
    required this.color,
  }) : super(key: key);

  final String name;
  final String type;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name,
          style: FreeBetaTextStyle.body2.copyWith(
            color: color,
          ),
        ),
        Spacer(),
        Text(
          type,
          style: FreeBetaTextStyle.body3.copyWith(
            color: FreeBetaColors.white,
          ),
        ),
      ],
    );
  }
}
