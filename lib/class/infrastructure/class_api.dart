import 'package:free_beta/app/enums/day.dart';
import 'package:free_beta/class/infrastructure/class_repository.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';
import 'package:free_beta/class/infrastructure/models/day_model.dart';

class ClassApi {
  final ClassRepository classRepository;

  ClassApi({required this.classRepository});

  Future<List<ClassModel>> getClassSchedule() async {
    return classRepository.getClassSchedule();
  }

  Future<void> addClass(ClassFormModel classFormModel) {
    return classRepository.addClass(classFormModel);
  }

  Future<void> updateClass(
    ClassModel classModel,
    ClassFormModel classFormModel,
  ) {
    return classRepository.updateClass(
      classModel,
      classFormModel,
    );
  }

  Future<void> deleteClass(ClassModel classModel) async {
    await classRepository.deleteClass(classModel);
  }

  Future<void> addDayImage(Day day, String image) async {
    await classRepository.addDayImage(day, image);
  }

  Future<void> deleteDayImage(Day day) async {
    await classRepository.deleteDayImage(day);
  }

  Future<List<DayModel>> getDays() async {
    return classRepository.getDays();
  }
}
