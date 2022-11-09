import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.p.dart';

class GymRemoteDataProvider {
  GymRemoteDataProvider({
    required this.firebaseFirestore,
    required this.crashlyticsApi,
  });

  final FirebaseFirestore firebaseFirestore;
  final CrashlyticsApi crashlyticsApi;

  CollectionReference<Map<String, dynamic>> get _firestoreResetSchedule =>
      firebaseFirestore.collection('reset_schedule');

  Future<ResetModel> getNextReset() async {
    return (await getResetSchedule()).first;
  }

  Future<List<ResetModel>> getResetSchedule() async {
    List<ResetModel> resetSchedule = [];
    await _firestoreResetSchedule.get().then(
          (schedule) => schedule.docs.forEach(
            (json) {
              resetSchedule.add(
                ResetModel.fromFirebase(json.id, json.data()),
              );
            },
          ),
        );

    resetSchedule.sort((a, b) => b.date.compareTo(a.date));
    return resetSchedule;
  }

  Future<void> addReset(ResetFormModel resetFormModel) async {
    await _firestoreResetSchedule
        .add(resetFormModel.toJson())
        .then((value) => log(value.toString()))
        .catchError(
      (error, stackTrace) {
        crashlyticsApi.logError(
          error,
          stackTrace,
          'GymRemoteDataProvider',
          'addReset',
        );
      },
    );
  }

  Future<void> updateReset(
    ResetModel resetModel,
    ResetFormModel resetFormModel,
  ) async {
    await _firestoreResetSchedule
        .doc(resetModel.id)
        .update(resetFormModel.toJson())
        .catchError(
      (error, stackTrace) {
        crashlyticsApi.logError(
          error,
          stackTrace,
          'GymRemoteDataProvider',
          'updateReset',
        );
      },
    );
  }

  Future<void> deleteReset(
    ResetModel resetModel,
  ) async {
    await _firestoreResetSchedule
        .doc(resetModel.id)
        .update({'isDeleted': true}).catchError(
      (error, stackTrace) {
        crashlyticsApi.logError(
          error,
          stackTrace,
          'GymRemoteDataProvider',
          'deleteReset',
        );
      },
    );
  }
}
