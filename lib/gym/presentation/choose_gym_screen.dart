import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/presentation/route_list_screen.dart';

class ChooseGymScreen extends StatelessWidget {
  const ChooseGymScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('choose-gym'),
      body: Padding(
        padding: FreeBetaPadding.xxlHorizontal,
        child: Column(
          children: [
            Padding(
              padding: FreeBetaPadding.lVertical,
              child: Text(
                'Choose your gym',
                style: FreeBetaTextStyle.h2,
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (_, __) => ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).push(RouteListScreen.route()),
                  child: Text(
                    'Elev8',
                    style: FreeBetaTextStyle.h4.copyWith(
                      color: FreeBetaColors.white,
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
                separatorBuilder: (_, __) => SizedBox(
                  height: FreeBetaSizes.m,
                ),
                itemCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}