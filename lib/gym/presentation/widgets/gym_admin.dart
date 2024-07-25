import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/create_route_screen.dart';
import 'package:free_beta/user/infrastructure/user_providers.dart';

class GymAdmin extends StatelessWidget {
  const GymAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => InfoCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gym Admin',
              style: FreeBetaTextStyle.h2,
            ),
            SizedBox(height: FreeBetaSizes.l),
            _CreateRouteButton(),
            SizedBox(height: FreeBetaSizes.l),
            Text(
              'To edit a route, first go to the route in the Routes tab. Then, tap the pencil icon in the top right corner of the screen.',
            ),
            SizedBox(height: FreeBetaSizes.l),
            Text(
              'To edit the reset schedule, tap the pencil icon in the top right corner of the reset schedule screen.',
            ),
            SizedBox(height: FreeBetaSizes.m),
            _DeleteAccountButton(),
          ],
        ),
      );
}

class _CreateRouteButton extends StatelessWidget {
  const _CreateRouteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: Key('GymAdmin-create'),
      onPressed: () => Navigator.of(context).push(CreateRouteScreen.route()),
      child: Padding(
        padding: FreeBetaPadding.xlHorizontal,
        child: Text(
          'Create route',
          style: FreeBetaTextStyle.h4.copyWith(
            color: FreeBetaColors.white,
          ),
        ),
      ),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(FreeBetaColors.black),
        side: WidgetStateProperty.all(
          BorderSide(
            width: 2,
          ),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(
            vertical: FreeBetaSizes.ml,
          ),
        ),
      ),
    );
  }
}

class _DeleteAccountButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      key: Key('GymAdmin-delete'),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(FreeBetaColors.red),
        side: WidgetStateProperty.all(
          BorderSide(
            width: 2.0,
            color: FreeBetaColors.red,
          ),
        ),
      ),
      onPressed: () => _onPressed(context, ref),
      child: Text(
        'Delete account',
        style: FreeBetaTextStyle.body5.copyWith(
          color: FreeBetaColors.white,
        ),
      ),
    );
  }

  Future<void> _onPressed(BuildContext context, WidgetRef ref) async {
    var willDelete = await showDialog(
      context: context,
      builder: (_) => _DeleteAreYouSureDialog(),
    );
    if (!(willDelete ?? false)) return;

    await ref.read(userApiProvider).deleteAccount();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Column(
          children: [
            Row(
              children: [
                Text('Account deleted! Reload the app.'),
                Spacer(),
                Icon(Icons.delete),
              ],
            ),
            Text('You may need to reopen the app to restore functionality.')
          ],
        ),
      ),
    );
  }
}

class _DeleteAreYouSureDialog extends StatelessWidget {
  const _DeleteAreYouSureDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure you want to delete your account?"),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: Text('Delete'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
