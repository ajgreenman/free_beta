import 'package:flutter/material.dart';

import 'package:free_beta/app/enums/class_type.dart';
import 'package:free_beta/app/enums/day.dart';
import 'package:free_beta/app/theme.dart';

class ClassModel {
  ClassModel({
    required this.id,
    required this.name,
    this.notes,
    required this.classType,
    required this.instructor,
    required this.day,
    required this.hour,
    required this.minute,
    this.isDeleted = false,
  });

  final String id;
  final String name;
  final String? notes;
  final ClassType classType;
  final String instructor;
  final Day day;
  final int hour;
  final int minute;
  final bool isDeleted;

  Color get chalkboardColor {
    switch (classType) {
      case ClassType.yoga:
        return FreeBetaColors.greenBrand;
      case ClassType.fitness:
        return FreeBetaColors.purpleBrand;
      case ClassType.climbing:
        return FreeBetaColors.yellowBrand;
      case ClassType.event:
        return FreeBetaColors.warning;
    }
  }

  factory ClassModel.fromFirebase(String id, Map<String, dynamic> json) {
    return ClassModel(
      id: id,
      name: json['name'] ?? '',
      notes: json['notes'],
      classType: ClassType.values.firstWhere(
        (classType) => classType.name == json['classType'],
        orElse: () => ClassType.yoga,
      ),
      instructor: json['instructor'],
      day: Day.values.firstWhere(
        (day) => day.name == json['day'],
        orElse: () => Day.sunday,
      ),
      hour: json['hour'],
      minute: json['minute'],
      isDeleted: _getBool(json['isDeleted']),
    );
  }

  static bool _getBool(bool? value) => value != null && value;

  int compareTo(ClassModel b) {
    var dayValue = b.day.index.compareTo(day.index);
    if (dayValue != 0) return dayValue;

    var hourValue = b.hour.compareTo(hour);
    if (hourValue != 0) return hourValue;

    return b.minute.compareTo(minute);
  }
}

class ClassFormModel {
  ClassFormModel({
    this.name,
    this.notes,
    this.classType,
    this.instructor,
    this.day,
    this.hour,
    this.minute,
  });

  factory ClassFormModel.fromClassModel(ClassModel classModel) {
    return ClassFormModel(
      name: classModel.name,
      notes: classModel.notes,
      classType: classModel.classType,
      instructor: classModel.instructor,
      day: classModel.day,
      hour: classModel.hour,
      minute: classModel.minute,
    );
  }

  String? name;
  String? notes;
  ClassType? classType;
  String? instructor;
  Day? day;
  int? hour;
  int? minute;

  @override
  String toString() {
    return 'ClassFormModel(name: $name, notes: $notes, classType: $classType, instructor: $instructor, day: $day, hour: $hour, minute: $minute)';
  }

  @override
  bool operator ==(covariant ClassFormModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.notes == notes &&
        other.classType == classType &&
        other.instructor == instructor &&
        other.day == day &&
        other.hour == hour &&
        other.minute == minute;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        notes.hashCode ^
        classType.hashCode ^
        instructor.hashCode ^
        day.hashCode ^
        hour.hashCode ^
        minute.hashCode;
  }
}
