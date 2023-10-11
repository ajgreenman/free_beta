import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/class/infrastructure/class_api.dart';
import 'package:free_beta/class/infrastructure/class_remote_data_provider.dart';
import 'package:free_beta/class/infrastructure/class_repository.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';
import 'package:free_beta/class/infrastructure/models/class_schedule_model.dart';
import 'package:free_beta/class/infrastructure/models/day_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'class_providers.g.dart';

@riverpod
ClassApi classApi(ClassApiRef ref) {
  return ClassApi(
    classRepository: ref.watch(classRepositoryProvider),
  );
}

@riverpod
ClassRepository classRepository(ClassRepositoryRef ref) {
  return ClassRepository(
    classRemoteDataProvider: ref.watch(classRemoteDataProvider),
  );
}

@riverpod
ClassRemoteDataProvider classRemoteData(
  ClassRemoteDataRef ref,
) {
  return ClassRemoteDataProvider(
    firebaseFirestore: FirebaseFirestore.instance,
    crashlyticsApi: ref.read(crashlyticsApiProvider),
  );
}

@riverpod
Future<List<ClassModel>> fetchClasses(FetchClassesRef ref) async {
  final classApi = ref.watch(classApiProvider);

  return classApi.getClassSchedule();
}

@riverpod
Future<List<DayModel>> fetchDays(FetchDaysRef ref) async {
  final classApi = ref.watch(classApiProvider);

  return classApi.getDays();
}

@riverpod
Future<List<ClassScheduleModel>> getClassSchedule(
    GetClassScheduleRef ref) async {
  final days = await ref.watch(fetchDaysProvider.future);
  final classes = await ref.watch(fetchClassesProvider.future);

  return days
      .map((dayModel) => ClassScheduleModel(
          day: dayModel.day,
          image: dayModel.image,
          classes: classes
              .where((classModel) => classModel.day == dayModel.day)
              .toList()))
      .toList();
}
