import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:free_beta/user/presentation/widgets/route_graph.dart';
import 'package:free_beta/user/presentation/widgets/user_stats_section.dart';

class UserStatsScreen extends ConsumerWidget {
  static Route<dynamic> route({
    required ClimbType climbType,
    required RouteStatsModel routeStatsModel,
  }) {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return UserStatsScreen(
        climbType: climbType,
        routeStatsModel: routeStatsModel,
      );
    });
  }

  final ClimbType climbType;
  final RouteStatsModel routeStatsModel;

  const UserStatsScreen({
    Key? key,
    required this.climbType,
    required this.routeStatsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: Key('user-stats'),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(climbType.displayName + ' Stats'),
        leading: FreeBetaBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InfoCard(
              child: UserStatsSection(routeStatsModel: routeStatsModel),
            ),
            InfoCard(
              child: Column(
                children: [
                  Text(
                    'Legend',
                    style: FreeBetaTextStyle.h2,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text('Unattempted'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 20,
                          color: FreeBetaColors.purpleBrand,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text('In progress'),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 20,
                            color: FreeBetaColors.yellowBrand,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text('Completed'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 20,
                          color: FreeBetaColors.greenBrand,
                        ),
                      ),
                    ],
                  ),
                  ref.watch(fetchRoutesProvider).when(
                        data: (routes) => RouteGraph(
                          routes: routes,
                          climbType: climbType,
                        ),
                        error: (_, __) => Text('error loading graph'),
                        loading: () => CircularProgressIndicator(),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
