import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:free_beta/gym/infrastructure/models/wall_section_model.dart';

class ResetModel {
  ResetModel({
    required this.id,
    required this.date,
    required this.sections,
    this.isDeleted = false,
  });

  final String id;
  final DateTime date;
  List<WallSectionModel> sections;
  final bool isDeleted;

  factory ResetModel.fromFirebase(String id, Map<String, dynamic> json) {
    var sections = ((json['sections'] as List<dynamic>?) ?? [])
        .map((section) => WallSectionModel.fromFirebase(section))
        .toList();
    sections.sort(
      (a, b) => a.wallLocation.index.compareTo(b.wallLocation.index),
    );
    return ResetModel(
      id: id,
      date: (json['date'] as Timestamp).toDate(),
      sections: sections,
      isDeleted: _getBool(json['isDeleted']),
    );
  }

  static bool _getBool(bool? value) => value != null && value;

  @override
  String toString() => 'ResetModel(id: $id, date: $date)';
}

class ResetFormModel {
  ResetFormModel({
    this.date,
    this.sections = const [],
  });

  factory ResetFormModel.fromRouteModel(ResetModel resetModel) {
    return ResetFormModel(
      date: resetModel.date,
      sections: resetModel.sections,
    );
  }

  DateTime? date;
  List<WallSectionModel> sections;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResetFormModel &&
        other.date == date &&
        other.sections == sections;
  }

  @override
  int get hashCode => date.hashCode ^ sections.hashCode;

  @override
  String toString() =>
      'ResetFormModel(date: $date, sections: ${sections.length})';
}
