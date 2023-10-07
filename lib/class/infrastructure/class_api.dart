import 'package:free_beta/class/infrastructure/class_repository.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';

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
}
