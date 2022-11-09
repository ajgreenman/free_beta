import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';

class RouteModel {
  final String id;
  final String name;
  final BoulderRating? boulderRating;
  final YosemiteRating? yosemiteRating;
  final ClimbType climbType;
  final RouteColor routeColor;
  final WallLocation wallLocation;
  final int wallLocationIndex;
  final DateTime creationDate;
  final DateTime? removalDate;
  final List<String> images;
  final String? betaVideo;
  final bool isDeleted;
  UserRouteModel? userRouteModel;

  RouteModel({
    required this.id,
    this.name = '',
    this.boulderRating,
    this.yosemiteRating,
    required this.climbType,
    required this.routeColor,
    required this.wallLocation,
    required this.wallLocationIndex,
    required this.creationDate,
    this.removalDate,
    this.images = const [],
    this.betaVideo,
    this.isDeleted = false,
    this.userRouteModel,
  }) : assert((boulderRating == null) ^ (yosemiteRating == null));

  factory RouteModel.fromFirebase(String id, Map<String, dynamic> json) {
    var climbType = _getClimbType(json['climbType']);
    return RouteModel(
      id: id,
      name: json['name'] ?? '',
      boulderRating: _getBoulderRating(
        json['difficulty'],
        climbType,
      ),
      yosemiteRating: _getYosemiteRating(
        json['difficulty'],
        climbType,
      ),
      climbType: climbType,
      routeColor: RouteColor.values.firstWhere(
        (routeColor) => describeEnum(routeColor) == json['routeColor'],
      ),
      wallLocation: WallLocation.values.firstWhere(
        (wallLocation) => describeEnum(wallLocation) == json['wallLocation'],
      ),
      wallLocationIndex: json['wallLocationIndex'],
      creationDate: (json['creationDate'] as Timestamp).toDate(),
      removalDate: (json['removalDate'] as Timestamp?)?.toDate(),
      images: ((json['images'] as List<dynamic>?) ?? [])
          .map((image) {
            return image.toString();
          })
          .where((image) => image.isNotEmpty)
          .toList(),
      betaVideo: json['betaVideo'],
      isDeleted: _getBool(json['isDeleted']),
    );
  }

  static bool _getBool(bool? value) => value != null && value;

  static BoulderRating? _getBoulderRating(
    String difficulty,
    ClimbType climbType,
  ) {
    if (climbType != ClimbType.boulder) return null;
    return boulderRatingFromString(difficulty);
  }

  static YosemiteRating? _getYosemiteRating(
    String difficulty,
    ClimbType climbType,
  ) {
    if (climbType == ClimbType.boulder) return null;
    return yosemiteRatingFromString(difficulty);
  }

  static ClimbType _getClimbType(String value) {
    return ClimbType.values.firstWhere(
      (climbType) => climbType.name == value,
    );
  }

  @override
  String toString() {
    return 'RouteModel(id: $id, name: $name, boulderRating: $boulderRating, yosemiteRating: $yosemiteRating, climbType: $climbType, routeColor: $routeColor, wallLocation: $wallLocation, wallLocationIndex: $wallLocationIndex, creationDate: $creationDate, removalDate: $removalDate, images: $images, betaVideo: $betaVideo, isDeleted: $isDeleted, userRouteModel: $userRouteModel)';
  }
}

extension RouteModelExtensions on RouteModel {
  bool get isCompleted => userRouteModel != null && userRouteModel!.isCompleted;
  bool get isInProgress => !isUnattempted && !isCompleted;
  bool get isUnattempted =>
      userRouteModel == null || !userRouteModel!.isAttempted;
}

extension RouteModelListExtensions on List<RouteModel> {
  List<RouteModel> sortRoutes() {
    this.sort((a, b) => _compareRoutes(a, b));
    return this;
  }

  int _compareRoutes(RouteModel a, RouteModel b) {
    var climbType = a.climbType.index.compareTo(b.climbType.index);
    if (climbType != 0) return climbType;

    var difficulty = 0;
    if (a.climbType == ClimbType.boulder) {
      difficulty = a.boulderRating!.index.compareTo(b.boulderRating!.index);
    } else {
      difficulty = a.yosemiteRating!.index.compareTo(b.yosemiteRating!.index);
    }
    if (difficulty != 0) return difficulty;

    if (a.name.trim().isEmpty && b.name.trim().isNotEmpty) return 1;
    if (b.name.trim().isEmpty && a.name.trim().isNotEmpty) return -1;
    return a.name.compareTo(b.name);
  }
}
