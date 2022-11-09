import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/gym/infrastructure/gym_api.dart';
import 'package:free_beta/gym/infrastructure/gym_remote_data_provider.dart';
import 'package:free_beta/gym/infrastructure/gym_repository.dart';

final gymApiProvider = Provider(
  (ref) => GymApi(
    gymRepository: ref.watch(gymRepositoryProvider),
  ),
);

final gymRepositoryProvider = Provider(
  (ref) => GymRepository(
    gymRemoteDataProvider: ref.watch(gymRemoteDataProvider),
  ),
);

final gymRemoteDataProvider = Provider(
  (ref) => GymRemoteDataProvider(
    firebaseFirestore: FirebaseFirestore.instance,
    crashlyticsApi: ref.read(crashlyticsApiProvider),
  ),
);

final resetScheduleProvider = FutureProvider((ref) async {
  final gymApi = ref.watch(gymApiProvider);

  return gymApi.getResetSchedule();
});
