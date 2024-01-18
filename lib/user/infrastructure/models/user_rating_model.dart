import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';

class UserRatingModel {
  UserRatingModel.withBoulder({
    required this.boulderUserRatingModel,
  }) : yosemiteUserRatingModel = null;

  UserRatingModel.withYosemite({
    required this.yosemiteUserRatingModel,
  }) : boulderUserRatingModel = null;

  final YosemiteUserRatingModel? yosemiteUserRatingModel;
  final BoulderUserRatingModel? boulderUserRatingModel;
}

class BoulderUserRatingModel {
  BoulderUserRatingModel({
    required this.boulderRating,
    required this.userProgressModel,
  });

  final BoulderRating boulderRating;
  final UserProgressModel userProgressModel;

  BarChartGroupData get barChart => userProgressModel._getBarChart(
        boulderRating.index,
      );
}

class YosemiteUserRatingModel {
  YosemiteUserRatingModel({
    required this.condensedYosemiteRating,
    required this.userProgressModel,
    required this.detailedUserProgressModels,
  });

  final CondensedYosemiteRating condensedYosemiteRating;
  final UserProgressModel userProgressModel;
  final List<DetailedYosemiteUserRatingModel> detailedUserProgressModels;

  BarChartGroupData get condensedBarChart => userProgressModel._getBarChart(
        condensedYosemiteRating.index,
      );

  BarChartGroupData get detailedBarChart => BarChartGroupData(
        x: condensedYosemiteRating.index,
        barRods: detailedUserProgressModels
            .map((detailedUserProgressModel) =>
                detailedUserProgressModel.userProgressModel._getRodData(8))
            .toList(),
      );
}

class DetailedYosemiteUserRatingModel {
  DetailedYosemiteUserRatingModel({
    required this.yosemiteRating,
    required this.userProgressModel,
  });

  final YosemiteRating yosemiteRating;
  final UserProgressModel userProgressModel;
}

class UserProgressModel {
  UserProgressModel({
    required this.unattempted,
    required this.inProgress,
    required this.completed,
  });

  UserProgressModel.fromRoutes({
    required Iterable<RouteModel> routes,
  })  : unattempted =
            routes.where((route) => route.isUnattempted).length.toDouble(),
        inProgress =
            routes.where((route) => route.isInProgress).length.toDouble(),
        completed =
            routes.where((route) => route.isCompleted).length.toDouble();

  final double unattempted;
  final double inProgress;
  final double completed;

  double get totalCount => unattempted + inProgress + completed;
  String get unattemptedCount => '${unattempted.toInt()}/${totalCount.toInt()}';
  String get inProgressCount => '${inProgress.toInt()}/${totalCount.toInt()}';
  String get completedCount => '${completed.toInt()}/${totalCount.toInt()}';

  BarChartGroupData _getBarChart(int index) => BarChartGroupData(
        x: index,
        barRods: [_getRodData(16)],
      );

  BarChartRodData _getRodData(double width) => BarChartRodData(
        toY: totalCount,
        color: FreeBetaColors.white,
        borderRadius: BorderRadius.zero,
        width: width,
        rodStackItems: [
          BarChartRodStackItem(
            completed + inProgress,
            totalCount,
            FreeBetaColors.red.withOpacity(0.7),
          ),
          BarChartRodStackItem(
            completed,
            completed + inProgress,
            FreeBetaColors.yellowBrand.withOpacity(0.7),
          ),
          BarChartRodStackItem(
            0,
            completed,
            FreeBetaColors.green.withOpacity(0.7),
          ),
        ],
      );

  List<TextSpan> get getTooltipData => [
        TextSpan(
          text: 'Unattempted: ${unattemptedCount}\n',
          style: FreeBetaTextStyle.body5,
        ),
        TextSpan(
          text: 'In progress: ${inProgressCount}\n',
          style: FreeBetaTextStyle.body5,
        ),
        TextSpan(
          text: 'Completed: ${completedCount}',
          style: FreeBetaTextStyle.body5,
        ),
      ];
}
