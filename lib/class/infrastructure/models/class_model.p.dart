import 'package:flutter/material.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';

extension ClassFormModelExtensions on ClassFormModel {
  Map<String, dynamic> toJson() => {
        'name': name,
        'classType': classType!.name,
        'instructor': instructor,
        'day': day!.name,
        'hour': hour,
        'minute': minute,
      };

  TimeOfDay? get timeOfDay {
    if (hour == null || minute == null) {
      return null;
    }

    return TimeOfDay(hour: hour!, minute: minute!);
  }
}

extension ClassModelListExtensions on List<ClassModel> {
  List<ClassModel> get activeClasses =>
      this.where((classModel) => !classModel.isDeleted).toList();
}
