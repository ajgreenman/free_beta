import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/app/enums/day.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';
import 'package:free_beta/class/infrastructure/models/class_model.p.dart';
import 'package:free_beta/class/infrastructure/models/day_model.dart';

class ClassRemoteDataProvider {
  ClassRemoteDataProvider({
    required this.firebaseFirestore,
    required this.crashlyticsApi,
  });

  final FirebaseFirestore firebaseFirestore;
  final CrashlyticsApi crashlyticsApi;

  CollectionReference<Map<String, dynamic>> get _firestoreClasses =>
      firebaseFirestore.collection('classes');

  CollectionReference<Map<String, dynamic>> get _firestoreDays =>
      firebaseFirestore.collection('days');

  Future<List<ClassModel>> getClassSchedule() async {
    List<ClassModel> classSchedule = [];
    await _firestoreClasses.get().then(
          (schedule) => schedule.docs.forEach(
            (json) {
              classSchedule.add(
                ClassModel.fromFirebase(json.id, json.data()),
              );
            },
          ),
        );

    classSchedule.sort((a, b) => b.compareTo(a));
    return classSchedule;
  }

  Future<void> addClass(ClassFormModel classFormModel) async {
    await _firestoreClasses
        .add(classFormModel.toJson())
        .then((value) => log(value.toString()))
        .catchError(
      (error, stackTrace) {
        crashlyticsApi.logError(
            error, stackTrace, 'ClassRemoteDataProvider', 'addClass');
      },
    );
  }

  Future<void> updateClass(
    ClassModel classModel,
    ClassFormModel classFormModel,
  ) async {
    await _firestoreClasses
        .doc(classModel.id)
        .update(classFormModel.toJson())
        .catchError(
      (error, stackTrace) {
        crashlyticsApi.logError(
          error,
          stackTrace,
          'ClassRemoteDataProvider',
          'updateClass',
        );
      },
    );
  }

  Future<void> deleteClass(
    ClassModel classModel,
  ) async {
    await _firestoreClasses
        .doc(classModel.id)
        .update({'isDeleted': true}).catchError(
      (error, stackTrace) {
        crashlyticsApi.logError(
          error,
          stackTrace,
          'ClassRemoteDataProvider',
          'deleteClass',
        );
      },
    );
  }

  Future<List<DayModel>> getDays() async {
    List<DayModel> dayImages = [];
    await _firestoreDays.get().then(
          (days) => days.docs.forEach(
            (json) {
              dayImages.add(
                DayModel.fromFirebase(json.id, json.data()),
              );
            },
          ),
        );
    return dayImages;
  }

  Future<void> addDayImage(Day day, String image) async {
    await _firestoreDays.doc(day.name).update({'image': image}).catchError(
      (error, stackTrace) {
        crashlyticsApi.logError(
          error,
          stackTrace,
          'ClassRemoteDataProvider',
          'addDayImage',
        );
      },
    );
  }

  Future<void> deleteDayImage(Day day) async {
    await _firestoreDays
        .doc(day.name)
        .update({'image': FieldValue.delete()}).catchError(
      (error, stackTrace) {
        crashlyticsApi.logError(
          error,
          stackTrace,
          'ClassRemoteDataProvider',
          'addDayImage',
        );
      },
    );
  }
}
