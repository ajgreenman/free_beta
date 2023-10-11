import 'package:free_beta/app/enums/day.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';

class ClassScheduleModel {
  ClassScheduleModel({
    required this.day,
    required this.image,
    required this.classes,
  });

  final Day day;
  final String? image;
  final List<ClassModel> classes;
}
