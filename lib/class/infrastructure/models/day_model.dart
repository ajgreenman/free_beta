import 'package:flutter/foundation.dart';
import 'package:free_beta/app/enums/day.dart';

class DayModel {
  DayModel({required this.day, required this.image});

  final Day day;
  final String? image;

  factory DayModel.fromFirebase(String id, Map<String, dynamic> json) {
    return DayModel(
      day: Day.values.firstWhere(
        (day) => describeEnum(day) == id,
      ),
      image: json['image'],
    );
  }
}
