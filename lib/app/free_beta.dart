import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/presentation/route_list_screen.dart';

class FreeBeta extends StatelessWidget {
  const FreeBeta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('free-beta-home'),
      appBar: AppBar(
        title: Text('Elev8'),
      ),
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
                  child: Text('Elev8'),
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
