import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:free_beta/app/enums/enums.dart';

class RefreshModel {
  RefreshModel({
    required this.id,
    required this.date,
    required this.sections,
  });

  factory RefreshModel.fromFirebase(String id, Map<String, dynamic> json) {
    log(json.toString());
    return RefreshModel(
      id: id,
      date: (json['date'] as Timestamp).toDate(),
      sections: ((json['sections'] as List<dynamic>?) ?? [])
          .map((section) => _WallSectionModel.fromFirebase(section))
          .toList(),
    );
  }

  final String id;
  final DateTime date;
  List<_WallSectionModel> sections;
}

class _WallSectionModel {
  _WallSectionModel({
    required this.wallLocation,
    required this.wallSection,
  });

  factory _WallSectionModel.fromFirebase(Map<String, dynamic> json) =>
      _WallSectionModel(
        wallLocation: WallLocation.values.firstWhere(
          (wallLocation) => describeEnum(wallLocation) == json['wallLocation'],
        ),
        wallSection: json['wallSection'],
      );

  final WallLocation wallLocation;
  final int wallSection;
}
