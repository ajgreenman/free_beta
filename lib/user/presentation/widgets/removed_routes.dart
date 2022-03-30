import 'package:flutter/material.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/presentation/route_list_screen.dart';

class RemovedRoutes extends StatelessWidget {
  const RemovedRoutes({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          RouteListScreen.route(
            routeProvider: fetchFilteredRemovedRoutes,
            refreshProvider: fetchRemovedRoutesProvider,
            appBar: AppBar(
              title: Text('Removed Routes'),
              leading: FreeBetaBackButton(),
            ),
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
      ),
    );
  }
}
