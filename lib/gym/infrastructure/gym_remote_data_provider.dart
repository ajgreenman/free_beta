import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/gym/infrastructure/models/refresh_model.dart';
import 'package:free_beta/gym/infrastructure/models/refresh_model.p.dart';

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
    return (await getRefreshSchedule()).first;
  }

  Future<List<RefreshModel>> getRefreshSchedule() async {
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

    refreshSchedule.sort((a, b) => b.date.compareTo(a.date));
    return refreshSchedule;
  }

  Future<void> addRefresh(RefreshFormModel refreshFormModel) async {
    await _firestoreRefreshSchedule
        .add(refreshFormModel.toJson())
        .then((value) => log(value.toString()))
        .catchError(
      (error, stackTrace) {
        crashlyticsApi.logError(
          error,
          stackTrace,
          'GymRemoteDataProvider',
          'addRefresh',
        );
      },
    );
  }

  Future<void> updateRefresh(
    RefreshModel refreshModel,
    RefreshFormModel refreshFormModel,
  ) async {
    await _firestoreRefreshSchedule
        .doc(refreshModel.id)
        .update(refreshFormModel.toJson())
        .catchError(
      (error, stackTrace) {
        crashlyticsApi.logError(
          error,
          stackTrace,
          'GymRemoteDataProvider',
          'updateRefresh',
        );
      },
    );
  }

  Future<void> deleteRefresh(
    RefreshModel refreshModel,
  ) async {
    await _firestoreRefreshSchedule
        .doc(refreshModel.id)
        .update({'isDeleted': true}).catchError(
      (error, stackTrace) {
        crashlyticsApi.logError(
          error,
          stackTrace,
          'GymRemoteDataProvider',
          'deleteRefresh',
        );
      },
    );
  }
}
