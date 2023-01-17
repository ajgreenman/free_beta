import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:free_beta/app/enums/class_type.dart';
import 'package:free_beta/app/enums/day.dart';
import 'package:free_beta/app/theme.dart';

class ClassModel {
  ClassModel({
    required this.name,
    required this.classType,
    required this.instructor,
    required this.day,
    required this.hour,
    required this.minute,
  });

  final String name;
  final ClassType classType;
  final String instructor;
  final Day day;
  final int hour;
  final int minute;

  Color get chalkboardColor {
    switch (classType) {
      case ClassType.yoga:
        return FreeBetaColors.greenBrand;
      case ClassType.fitness:
        return FreeBetaColors.purpleBrand;
      case ClassType.climbing:
        return FreeBetaColors.yellowBrand;
    }
  }

  factory ClassModel.fromFirebase(Map<String, dynamic> json) {
    return ClassModel(
      name: json['name'] ?? '',
      classType: ClassType.values.firstWhere(
        (classType) => describeEnum(classType) == json['classType'],
      ),
      instructor: json['instructor'],
      day: Day.values.firstWhere(
        (day) => describeEnum(day) == json['day'],
      ),
      hour: json['hour'],
      minute: json['minute'],
    );
  }

  int compareTo(ClassModel b) {
    var dayValue = b.day.index.compareTo(day.index);
    if (dayValue != 0) return dayValue;

    var hourValue = b.hour.compareTo(hour);
    if (hourValue != 0) return hourValue;

    return b.minute.compareTo(minute);
  }
}
