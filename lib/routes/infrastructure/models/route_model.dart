import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/user/user_route_model.dart';

class RouteModel {
  final String id;
  final String name;
  final String difficulty;
  final ClimbType climbType;
  final RouteColor routeColor;
  final DateTime creationDate;
  final DateTime? removalDate;
  final List<String> images;
  UserRouteModel? userRouteModel;

  RouteModel({
    required this.id,
    this.name = '',
    required this.difficulty,
    required this.climbType,
    required this.routeColor,
    required this.creationDate,
    this.removalDate,
    this.images = const [],
    this.userRouteModel,
  });

  factory RouteModel.fromFirebase(String id, Map<String, dynamic> json) =>
      RouteModel(
        id: id,
        name: json['name'],
        climbType: ClimbType.values.firstWhere(
          (climbType) => describeEnum(climbType) == json['climbType'],
        ),
        creationDate: (json['creationDate'] as Timestamp).toDate(),
        routeColor: RouteColor.values.firstWhere(
          (routeColor) => describeEnum(routeColor) == json['routeColor'],
        ),
        difficulty: json['difficulty'],
        images: ((json['images'] as List<dynamic>?) ?? [])
            .map((image) => image.toString())
            .toList(),
      );
}

extension RouteModelExtensions on RouteModel {
  String get truncatedDisplayName {
    if (this.name.length > 7) {
      return this.name.substring(0, 7) + '...';
    }
    return this.name;
  }
}
