import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/gym/infrastructure/models/refresh_model.dart';

class GymRemoteDataProvider {
  GymRemoteDataProvider({
    required this.firebaseFirestore,
    required this.crashlyticsApi,
  });

  final FirebaseFirestore firebaseFirestore;
  final CrashlyticsApi crashlyticsApi;

  CollectionReference<Map<String, dynamic>> get _firestoreRefreshSchedule =>
      firebaseFirestore.collection('refresh_schedule');

  Future<RefreshModel> getNextRefresh() async {
    return (await _getRefreshSchedule()).first;
  }

  Future<List<RefreshModel>> _getRefreshSchedule() async {
    List<RefreshModel> refreshSchedule = [];
    await _firestoreRefreshSchedule.get().then(
          (schedule) => schedule.docs.forEach(
            (json) {
              refreshSchedule.add(
                RefreshModel.fromFirebase(json.id, json.data()),
              );
            },
          ),
        );

    refreshSchedule.sort(((a, b) => a.date.compareTo(b.date)));
    return refreshSchedule;
  }
}
