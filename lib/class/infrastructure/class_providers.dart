import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/class/infrastructure/class_api.dart';
import 'package:free_beta/class/infrastructure/class_remote_data_provider.dart';
import 'package:free_beta/class/infrastructure/class_repository.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';
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
