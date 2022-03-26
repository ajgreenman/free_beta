import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/presentation/route_card.dart';
import 'package:free_beta/routes/presentation/route_detail_screen.dart';
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
            onPressed: () =>
                Navigator.of(context).push(RouteListScreen.route()),
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
