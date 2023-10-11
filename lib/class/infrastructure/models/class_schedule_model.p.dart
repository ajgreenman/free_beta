import 'package:free_beta/class/infrastructure/models/class_model.dart';
import 'package:free_beta/class/infrastructure/models/class_schedule_model.dart';

extension ClassScheduleModelExtensions on ClassScheduleModel {
  List<ClassModel> get activeClasses =>
      this.classes.where((classModel) => !classModel.isDeleted).toList();
}
