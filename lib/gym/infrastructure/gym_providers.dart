import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/gym/infrastructure/gym_api.dart';
import 'package:free_beta/gym/infrastructure/gym_remote_data_provider.dart';
import 'package:free_beta/gym/infrastructure/gym_repository.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gym_providers.g.dart';

@Riverpod(dependencies: [gymRepository])
GymApi gymApi(GymApiRef ref) {
  return GymApi(
    gymRepository: ref.watch(gymRepositoryProvider),
  );
}

@Riverpod(dependencies: [gymRemoteData])
GymRepository gymRepository(GymRepositoryRef ref) {
  return GymRepository(
    gymRemoteDataProvider: ref.watch(gymRemoteDataProvider),
  );
}

@Riverpod(dependencies: [crashlyticsApi])
GymRemoteDataProvider gymRemoteData(GymRemoteDataRef ref) {
  return GymRemoteDataProvider(
    firebaseFirestore: FirebaseFirestore.instance,
    crashlyticsApi: ref.read(crashlyticsApiProvider),
  );
}

@Riverpod(dependencies: [gymApi])
Future<List<ResetModel>> resetSchedule(ResetScheduleRef ref) {
  final gymApi = ref.watch(gymApiProvider);

  return gymApi.getResetSchedule();
}
