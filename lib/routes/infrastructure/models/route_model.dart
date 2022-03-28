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
        name: json['name'] ?? '',
        climbType: ClimbType.values.firstWhere(
          (climbType) => describeEnum(climbType) == json['climbType'],
        ),
        creationDate: (json['creationDate'] as Timestamp).toDate(),
        removalDate: (json['removalDate'] as Timestamp?)?.toDate(),
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

  String truncatedDisplayName(int limit) {
    if (this.name.length > limit) {
      return this.name.substring(0, limit) + '...';
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
      case 'v1-v3':
        return 2;
      case 'v2-v4':
        return 3;
      case 'v3-v5':
        return 4;
      case 'v4-v6':
        return 5;
      case 'v5-v7':
        return 6;
      case 'v6-v8':
        return 7;
      case 'v8+':
        return 8;
      case '5.5':
        return 100;
      case '5.6':
        return 101;
      case '5.7':
        return 102;
      case '5.8':
        return 103;
      case '5.8-':
        return 104;
      case '5.8':
        return 105;
      case '5.8+':
        return 106;
      case '5.9-':
        return 107;
      case '5.9':
        return 108;
      case '5.9+':
        return 109;
      case '5.10-':
        return 110;
      case '5.10':
        return 111;
      case '5.10+':
        return 112;
      case '5.11-':
        return 113;
      case '5.11':
        return 114;
      case '5.11+':
        return 115;
      case '5.12-':
        return 116;
      case '5.12':
        return 117;
      case '5.12+':
        return 118;
      case '5.13-':
        return 119;
      case '5.13':
        return 120;
      case '5.13+':
        return 121;
      default:
        return 1000;
    }
  }
}
