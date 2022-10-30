import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/gym/infrastructure/gym_remote_data_provider.dart';

final gymRemoteDataProvider = Provider(
  (ref) => GymRemoteDataProvider(
    firebaseFirestore: FirebaseFirestore.instance,
    crashlyticsApi: ref.read(crashlyticsApiProvider),
  ),
);

final refreshScheduleProvider = FutureProvider((ref) async {
  final gymRemoteProvider = ref.watch(gymRemoteDataProvider);

  return gymRemoteProvider.getRefreshSchedule();
});
