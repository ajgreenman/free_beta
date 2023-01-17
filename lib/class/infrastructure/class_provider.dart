import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/class/infrastructure/class_api.dart';
import 'package:free_beta/class/infrastructure/class_remote_data_provider.dart';
import 'package:free_beta/class/infrastructure/class_repository.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';

final classApiProvider = Provider(
  (ref) => ClassApi(
    classRepository: ref.watch(classRepositoryProvider),
  ),
);

final classRepositoryProvider = Provider(
  (ref) => ClassRepository(
    classRemoteDataProvider: ref.watch(classRemoteDataProvider),
  ),
);

final classRemoteDataProvider = Provider(
  (ref) => ClassRemoteDataProvider(
    firebaseFirestore: FirebaseFirestore.instance,
    crashlyticsApi: ref.read(crashlyticsApiProvider),
  ),
);

final fetchClassesProvider = FutureProvider<List<ClassModel>>((ref) async {
  final routeApi = ref.watch(classApiProvider);

  return routeApi.getClassSchedule();
});
