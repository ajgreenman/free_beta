import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';

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
            .map((image) {
              return image.toString();
            })
            .where((image) => image.isNotEmpty)
            .toList(),
      );
}

extension RouteModelExtensions on RouteModel {
  String get displayName => this.name.isNotEmpty ? this.name : '(unnamed)';

  String get truncatedDisplayName {
    if (this.name.length > 30) {
      return this.name.substring(0, 30) + '...';
    }
    return this.name;
  }
}

extension RouteModelListExtensions on List<RouteModel> {
  List<RouteModel> sortRoutes() {
    this.sort((a, b) => _compareRoutes(a, b));
    return this;
  }

  int _compareRoutes(RouteModel a, RouteModel b) {
    var climbType = a.climbType.index.compareTo(b.climbType.index);
    if (climbType != 0) return climbType;

    var difficulty = _getDifficultyIndex(a).compareTo(_getDifficultyIndex(b));
    if (difficulty != 0) return difficulty;

    if (a.name.trim().isEmpty && b.name.trim().isNotEmpty) return 1;
    if (b.name.trim().isEmpty && a.name.trim().isNotEmpty) return -1;
    return a.name.compareTo(b.name);
  }

  int _getDifficultyIndex(RouteModel route) {
    switch (route.difficulty.toLowerCase()) {
      case 'vb':
        return 0;
      case 'v0-v2':
        return 1;
      case 'v2-v4':
        return 2;
      case 'v4-v6':
        return 3;
      case 'v6-v8':
        return 4;
      case 'v8+':
        return 5;
      case '5.5':
        return 6;
      case '5.6':
        return 7;
      case '5.7':
        return 8;
      case '5.8':
        return 9;
      case '5.8-':
        return 10;
      case '5.8':
        return 11;
      case '5.8+':
        return 12;
      case '5.9-':
        return 13;
      case '5.9':
        return 14;
      case '5.9+':
        return 15;
      case '5.10-':
        return 16;
      case '5.10':
        return 17;
      case '5.10+':
        return 18;
      case '5.11-':
        return 19;
      case '5.11':
        return 20;
      case '5.11+':
        return 21;
      case '5.12-':
        return 22;
      case '5.12':
        return 23;
      case '5.12+':
        return 24;
      case '5.13-':
        return 25;
      case '5.13':
        return 26;
      case '5.13+':
        return 27;
      default:
        return 100;
    }
  }
}
