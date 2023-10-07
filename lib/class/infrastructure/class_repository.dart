import 'package:free_beta/class/infrastructure/class_remote_data_provider.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';

class ClassRepository {
  final ClassRemoteDataProvider classRemoteDataProvider;

  ClassRepository({required this.classRemoteDataProvider});

  Future<List<ClassModel>> getClassSchedule() async {
    return classRemoteDataProvider.getClassSchedule();
  }

  Future<void> addClass(ClassFormModel classFormModel) async {
    await classRemoteDataProvider.addClass(classFormModel);
  }

  Future<void> updateClass(
    ClassModel classModel,
    ClassFormModel classFormModel,
  ) async {
    await classRemoteDataProvider.updateClass(
      classModel,
      classFormModel,
    );
  }

  Future<void> deleteClass(
    ClassModel classModel,
  ) async {
    await classRemoteDataProvider.deleteClass(classModel);
  }
}
