import 'package:flutter/material.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/create_route_screen.dart';

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
            _buildActions(context),
            SizedBox(height: FreeBetaSizes.l),
            Text(
              'To edit a route, first go your route in the Routes tab. Then, tap the pencil icon in the top right corner of the screen.',
            ),
          ],
        ),
      );
}

Widget _buildActions(BuildContext context) {
  return Row(
    children: [
      ElevatedButton(
        onPressed: () => Navigator.of(context).push(CreateRouteScreen.route()),
        child: Padding(
          padding: FreeBetaPadding.xlHorizontal,
          child: Text(
            'Create Route',
            style: FreeBetaTextStyle.h4.copyWith(
              color: FreeBetaColors.white,
            ),
          ),
        ),
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(
              width: 2,
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: FreeBetaSizes.ml,
            ),
          ),
        ),
      ),
      Spacer(),
    ],
  );
}
