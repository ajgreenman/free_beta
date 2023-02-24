import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/extensions/date_extensions.dart';
import 'package:free_beta/app/presentation/widgets/back_button.dart';
import 'package:free_beta/app/presentation/widgets/divider.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/infrastructure/gym_providers.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';
import 'package:free_beta/gym/infrastructure/models/wall_section_model.dart';
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
        title: Text(
          'Route List Guide',
        ),
        leading: FreeBetaBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InfoCard(
              child: Padding(
                padding: FreeBetaPadding.mAll,
                child: Text(
                  'The previous screen provides an overview of all available routes and allows you to filter them. You can enter your progress with each route by tapping into a specific route. Below is a list of sample routes to help learn the symbols:',
                ),
              ),
            ),
            FreeBetaDivider(),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) => ProviderScope(
                overrides: [
                  resetScheduleProvider.overrideWith((_) => resetSchedule),
                ],
                child: RouteCard(
                  route: routes[index],
                  onTap: (cardContext) => Navigator.of(cardContext).push(
                    RouteDetailScreen.route(
                      routes,
                      index,
                      isHelp: true,
                    ),
                  ),
                ),
              ),
              separatorBuilder: (_, __) => FreeBetaDivider(),
              itemCount: routes.length,
            ),
            FreeBetaDivider(),
            SizedBox(height: FreeBetaSizes.l),
            _SymbolColumn(),
          ],
        ),
      ),
    );
  }

  static final resetSchedule = [
    ResetModel(
      id: '1',
      date: DateTime.now().subtract(Duration(days: 1)).copyWith(second: 0),
      sections: [
        WallSectionModel(
          wallLocation: WallLocation.mezzanine,
          wallSection: 0,
        ),
      ],
    ),
    ResetModel(
      id: '2',
      date: DateTime.now().add(Duration(days: 1)),
      sections: [
        WallSectionModel(
          wallLocation: WallLocation.boulder,
          wallSection: 0,
        ),
      ],
    ),
  ];

  static final routes = [
    RouteModel(
      id: '001',
      name: 'Beginner Route',
      boulderRating: BoulderRating.v1v2,
      climbType: ClimbType.boulder,
      routeColor: RouteColor.green,
      wallLocation: WallLocation.boulder,
      wallLocationIndex: 1,
      creationDate: DateTime.now(),
      userRouteModel: UserRouteModel(
        userId: 'user1',
        routeId: '001',
        attempts: 1,
        isCompleted: true,
        isFavorited: false,
        notes: 'Great warmup',
      ),
    ),
    RouteModel(
      id: '002',
      name: 'Campus!',
      yosemiteRating: YosemiteRating.elevenPlus,
      climbType: ClimbType.topRope,
      routeColor: RouteColor.purple,
      wallLocation: WallLocation.mezzanine,
      wallLocationIndex: 0,
      creationDate:
          DateTime.now().subtract(Duration(days: 1)).copyWith(second: 0),
      userRouteModel: UserRouteModel(
        userId: 'user1',
        routeId: '002',
        attempts: 4,
        isCompleted: true,
        isFavorited: true,
      ),
    ),
    RouteModel(
      id: '003',
      name: 'Send it',
      yosemiteRating: YosemiteRating.nine,
      climbType: ClimbType.lead,
      routeColor: RouteColor.blue,
      wallLocation: WallLocation.tall,
      wallLocationIndex: 0,
      creationDate: DateTime.now(),
      userRouteModel: UserRouteModel(
        userId: 'user1',
        routeId: '003',
        attempts: 2,
        isCompleted: false,
        isFavorited: true,
      ),
    ),
    RouteModel(
      id: '004',
      name: 'Crimp my ride',
      boulderRating: BoulderRating.v4v5,
      climbType: ClimbType.boulder,
      routeColor: RouteColor.yellow,
      wallLocation: WallLocation.boulder,
      wallLocationIndex: 0,
      creationDate: DateTime.now(),
      userRouteModel: UserRouteModel(
        userId: 'user1',
        routeId: '004',
        attempts: 0,
        isCompleted: false,
        isFavorited: false,
      ),
    ),
    RouteModel(
      id: '005',
      name: 'The Corporate Ladder',
      yosemiteRating: YosemiteRating.six,
      climbType: ClimbType.topRope,
      routeColor: RouteColor.black,
      wallLocation: WallLocation.tall,
      wallLocationIndex: 0,
      creationDate: DateTime.now(),
      userRouteModel: UserRouteModel(
        userId: 'user1',
        routeId: '005',
        attempts: 4,
        isCompleted: true,
        isFavorited: false,
        notes: 'Too easy',
      ),
    ),
  ];
}

class _SymbolColumn extends StatelessWidget {
  const _SymbolColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _IconRow(
          icon: _FavoriteIcon(isFavorited: true),
          label: 'Favorited',
        ),
        _IconRow(
          icon: _FavoriteIcon(isFavorited: false),
          label: 'Not favorited',
        ),
        _IconRow(
          icon: RouteProgressIcon(isAttempted: false, isCompleted: false),
          label: 'Unattempted',
        ),
        _IconRow(
          icon: RouteProgressIcon(isAttempted: true, isCompleted: false),
          label: 'Attempted but not completed',
        ),
        _IconRow(
          icon: RouteProgressIcon(isAttempted: true, isCompleted: true),
          label: 'Attempted and completed',
        ),
        _IconRow(
          icon: Padding(
            padding: FreeBetaPadding.lHorizontal,
            child: Icon(
              Icons.fiber_new,
            ),
          ),
          label: 'New route',
        ),
        _IconRow(
          icon: Padding(
            padding: FreeBetaPadding.lHorizontal,
            child: Icon(
              Icons.warning_outlined,
            ),
          ),
          label: 'Route to be removed soon',
        ),
      ],
    );
  }
}

class _IconRow extends StatelessWidget {
  const _IconRow({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        Text(label),
      ],
    );
  }
}

class _FavoriteIcon extends StatelessWidget {
  const _FavoriteIcon({
    Key? key,
    required this.isFavorited,
  }) : super(key: key);

  final bool isFavorited;

  @override
  Widget build(BuildContext context) {
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
}
