import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/presentation/route_card.dart';
import 'package:free_beta/routes/presentation/route_detail_screen.dart';
import 'package:free_beta/routes/presentation/route_progress_icon.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';

class RouteHelpScreen extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return RouteHelpScreen();
    });
  }

  RouteHelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('help'),
      appBar: AppBar(
        leading: FreeBetaBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHelpText(),
            Divider(height: 1, thickness: 1),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    RouteDetailScreen.route(
                      routes[index],
                      isHelp: true,
                    ),
                  ),
                  child: RouteCard(route: routes[index]),
                );
              },
              separatorBuilder: (_, __) => Divider(height: 1, thickness: 1),
              itemCount: routes.length,
            ),
            Divider(height: 1, thickness: 1),
            SizedBox(height: FreeBetaSizes.l),
            _buildSymbols(),
          ],
        ),
      ),
    );
  }

  Widget _buildSymbols() {
    return Column(
      children: [
        _buildRow(
          _buildFavoriteIcon(true),
          'Favorited',
        ),
        _buildRow(
          _buildFavoriteIcon(false),
          'Not favorited',
        ),
        _buildRow(
          _buildProgressIcon(false, false),
          'Unattempted',
        ),
        _buildRow(
          _buildProgressIcon(true, false),
          'Attempted but not completed',
        ),
        _buildRow(
          _buildProgressIcon(true, true),
          'Attempted and completed',
        ),
      ],
    );
  }

  Widget _buildHelpText() {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Route List Guide',
            style: FreeBetaTextStyle.h1,
          ),
          SizedBox(height: FreeBetaSizes.m),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'The previous screen provides an overview of all available routes and allows you to filter them. You can enter your progress with each route by tapping into a specific route. Below is a list of sample routes to help learn the symbols:',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(Widget icon, String label) {
    return Row(
      children: [
        icon,
        Text(label),
      ],
    );
  }

  Widget _buildFavoriteIcon(bool isFavorited) {
    return Padding(
      padding: FreeBetaPadding.lHorizontal,
      child: isFavorited
          ? Icon(
              Icons.star,
              size: FreeBetaSizes.xl,
              color: FreeBetaColors.blueDark,
            )
          : Icon(
              Icons.star_outline,
              size: FreeBetaSizes.xl,
              color: FreeBetaColors.blueDark,
            ),
    );
  }

  Widget _buildProgressIcon(bool isAttempted, bool isCompleted) {
    return RouteProgressIcon(
      isAttempted: isAttempted,
      isCompleted: isCompleted,
    );
  }

  static final routes = [
    RouteModel(
      id: '001',
      name: 'Beginner Route',
      difficulty: 'v0-v2',
      climbType: ClimbType.boulder,
      routeColor: RouteColor.green,
      creationDate: DateTime.now(),
      userRouteModel: UserRouteModel(
        routeId: '001',
        isAttempted: true,
        isCompleted: true,
        isFavorited: false,
        notes: 'Great warmup',
      ),
    ),
    RouteModel(
      id: '002',
      name: 'Campus!',
      difficulty: '5.11+',
      climbType: ClimbType.topRope,
      routeColor: RouteColor.purple,
      creationDate: DateTime.now(),
      userRouteModel: UserRouteModel(
        routeId: '002',
        isAttempted: true,
        isCompleted: true,
        isFavorited: true,
      ),
    ),
    RouteModel(
      id: '003',
      name: 'Send it',
      difficulty: '5.9',
      climbType: ClimbType.lead,
      routeColor: RouteColor.blue,
      creationDate: DateTime.now(),
      userRouteModel: UserRouteModel(
        routeId: '003',
        isAttempted: true,
        isCompleted: false,
        isFavorited: true,
      ),
    ),
    RouteModel(
      id: '004',
      name: 'Crimp my ride',
      difficulty: 'v4-v6',
      climbType: ClimbType.boulder,
      routeColor: RouteColor.yellow,
      creationDate: DateTime.now(),
      userRouteModel: UserRouteModel(
        routeId: '004',
        isAttempted: false,
        isCompleted: false,
        isFavorited: false,
      ),
    ),
    RouteModel(
      id: '005',
      name: 'The Corporate Ladder',
      difficulty: '5.6',
      climbType: ClimbType.topRope,
      routeColor: RouteColor.black,
      creationDate: DateTime.now(),
      userRouteModel: UserRouteModel(
        routeId: '005',
        isAttempted: true,
        isCompleted: true,
        isFavorited: false,
        notes: 'Too easy',
      ),
    ),
  ];
}
