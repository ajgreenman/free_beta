import 'package:free_beta/app/enums/day.dart';
import 'package:free_beta/class/infrastructure/class_remote_data_provider.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';
import 'package:free_beta/class/infrastructure/models/day_model.dart';

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

  Future<void> addDayImage(Day day, String image) async {
    await classRemoteDataProvider.addDayImage(day, image);
  }

  Future<void> deleteDayImage(Day day) async {
    await classRemoteDataProvider.deleteDayImage(day);
  }

  Future<List<DayModel>> getDays() async {
    return classRemoteDataProvider.getDays();
  }
}
