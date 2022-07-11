import 'dart:developer';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/presentation/widgets/info_card.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';

class RouteGraph extends StatelessWidget {
  const RouteGraph({
    Key? key,
    required this.routes,
    required this.climbType,
  }) : super(key: key);

  final List<RouteModel> routes;
  final ClimbType climbType;

  @override
  Widget build(BuildContext context) {
    // var difficultyMap = _getDifficultyMap();
    // var routeList = <_RouteModel>[];
    var filtered = routes
        .sortRoutes()
        .where((route) => route.climbType == climbType)
        .toList();

    // var _routeList = <_RouteModel>[];
    // for (var i = 0; i < filtered.length; i++) {
    //   var route = filtered[i];
    //   var attemptClass = getAttemptClass(route.userRouteModel);
    //   var rating = ratingFromString(route.difficulty);
    //   _routeList.add(_RouteModel(attemptClass, rating));
    // }

    var seriesTwo = Rating.values.map((rating) {
      var filteredRoutes = filtered
          .where((route) =>
              route.difficulty.toLowerCase() ==
              rating.displayName.toLowerCase())
          .toList();
      //log(rating.toString() + filteredRoutes.toString());
      return charts.Series<RouteModel, String>(
        id: rating.name,
        data: filteredRoutes,
        domainFn: (RouteModel route, _) => rating.displayName,
        measureFn: (RouteModel route, _) {
          var result = getAttemptClass(route.userRouteModel);
          //log(route.id + result.toString());
          return result.index;
        },
        colorFn: (RouteModel route, _) {
          var result = getAttemptClass(route.userRouteModel);
          var index = result.index;
          var color = getColor(index);

          return charts.ColorUtil.fromDartColor(color);
        },
      );
    }).toList();

    // var seriesThree = _AttemptClass.values.map((attemptClass) {
    //   var filteredRoutes = filtered
    //       .where(
    //           (route) => getAttemptClass(route.userRouteModel) == attemptClass)
    //       .toList();
    //       var unattempted
    //   return charts.Series<_RouteModel, String>(

    //   );
    // });

    var unattempted = Rating.values
        .map((rating) => _GraphModel(
              rating: rating.displayName,
              count: filtered
                  .where((route) =>
                      getAttemptClass(route.userRouteModel) ==
                          _AttemptClass.unattempted &&
                      route.difficulty.toLowerCase() ==
                          rating.displayName.toLowerCase())
                  .length,
            ))
        .toList();

    var attempted = Rating.values
        .map((rating) => _GraphModel(
              rating: rating.displayName,
              count: filtered
                  .where((route) =>
                      getAttemptClass(route.userRouteModel) ==
                          _AttemptClass.attempted &&
                      route.difficulty.toLowerCase() ==
                          rating.displayName.toLowerCase())
                  .length,
            ))
        .toList();

    var completed = Rating.values
        .map((rating) => _GraphModel(
              rating: rating.displayName,
              count: filtered
                  .where((route) =>
                      getAttemptClass(route.userRouteModel) ==
                          _AttemptClass.completed &&
                      route.difficulty.toLowerCase() ==
                          rating.displayName.toLowerCase())
                  .length,
            ))
        .toList();
    var seriesThree = [
      charts.Series<_GraphModel, String>(
        id: 'Completed',
        domainFn: (_GraphModel model, _) => model.rating,
        measureFn: (_GraphModel model, _) => model.count,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(FreeBetaColors.greenBrand),
        data: completed,
      ),
      charts.Series<_GraphModel, String>(
        id: 'Attempted',
        domainFn: (_GraphModel model, _) => model.rating,
        measureFn: (_GraphModel model, _) => model.count,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(FreeBetaColors.yellowBrand),
        data: attempted,
      ),
      charts.Series<_GraphModel, String>(
        id: 'Unattempted',
        domainFn: (_GraphModel model, _) => model.rating,
        measureFn: (_GraphModel model, _) => model.count,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(FreeBetaColors.purpleBrand),
        data: unattempted,
      ),
    ];

    return Container(
      height: 300,
      color: FreeBetaColors.grayDark,
      child: charts.BarChart(
        seriesThree,
        animate: false,
        barGroupingType: charts.BarGroupingType.stacked,
      ),
    );
  }

  String getColorName(int index) {
    var logResult = index % 3;
    if (logResult == 0) return 'purple';
    if (logResult == 1) return 'yellow';
    return 'green';
  }

  Color getColor(int index) {
    var logResult = index % 3;
    if (logResult == 0) return FreeBetaColors.purpleBrand;
    if (logResult == 1) return FreeBetaColors.yellowBrand;
    return FreeBetaColors.greenBrand;
  }

  Map<Rating, Map<_AttemptClass, int>>? _getDifficultyMap() {
    var filtered = routes
        .sortRoutes()
        .where((route) => route.climbType == climbType)
        .toList();

    var routeList = <_RouteModel>[];
    for (var i = 0; i < filtered.length; i++) {
      var route = filtered[i];
      var attemptClass = getAttemptClass(route.userRouteModel);
      var rating = ratingFromString(route.difficulty);
      routeList.add(_RouteModel(attemptClass, rating));
    }

    Map<_AttemptClass, int> map = {};
    for (var attemptClass in _AttemptClass.values) {
      map.putIfAbsent(
          attemptClass,
          () => routeList
              .where((element) => element.attemptClass == attemptClass)
              .length);
    }
    Map<Rating, Map<_AttemptClass, int>> mapp = {};
    for (var rating in Rating.values) {
      mapp.putIfAbsent(
          rating,
          () => Map.fromIterable(
                _AttemptClass.values,
                key: (element) => element,
                value: (element) => 0,
              ));
    }
    for (var route in routeList) {
      mapp[route.rating]!.update(route.attemptClass, (value) => value + 1);
    }
    return mapp;
  }
}

class _GraphModel {
  final String rating;
  final int count;

  _GraphModel({
    required this.rating,
    required this.count,
  });
}

class _RouteModel {
  _RouteModel(this.attemptClass, this.rating);

  final _AttemptClass attemptClass;
  final Rating rating;
}

enum _AttemptClass {
  unattempted,
  attempted,
  completed,
}

_AttemptClass getAttemptClass(UserRouteModel? userRouteModel) {
  if (userRouteModel == null) return _AttemptClass.unattempted;
  if (!userRouteModel.isAttempted) return _AttemptClass.unattempted;
  if (userRouteModel.isCompleted) return _AttemptClass.completed;
  return _AttemptClass.attempted;
}
