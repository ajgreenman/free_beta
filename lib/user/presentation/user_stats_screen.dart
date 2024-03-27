import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/user/infrastructure/models/user_stats_model.dart';
import 'package:free_beta/user/presentation/widgets/user_graph_section.dart';
import 'package:free_beta/user/presentation/widgets/user_stats_section.dart';

class UserStatsScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
            if (climbType != ClimbType.boulder)
              InfoCard(
                child: Text('Not a boulder'),
              ),
            InfoCard(
              child: UserStatsSection(routeStatsModel: routeStatsModel),
            ),
            InfoCard(
              child: UserGraphSection(
                climbType: climbType,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
