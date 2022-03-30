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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Removed Routes',
            style: FreeBetaTextStyle.h2,
          ),
          SizedBox(height: FreeBetaSizes.l),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              RouteListScreen.route(
                routeProvider: fetchFilteredRemovedRoutes,
                refreshProvider: fetchRemovedRoutesProvider,
                appBar: AppBar(
                  title: Text('Removed Routes'),
                  leading: FreeBetaBackButton(),
                ),
              ),
            ),
            child: Padding(
              padding: FreeBetaPadding.xlHorizontal,
              child: Text(
                'View Removed Routes',
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
          )
        ],
      ),
    );
  }
}
