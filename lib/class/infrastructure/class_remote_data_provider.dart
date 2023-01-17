import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';

class ClassRemoteDataProvider {
  ClassRemoteDataProvider({
    required this.firebaseFirestore,
    required this.crashlyticsApi,
  });

  final FirebaseFirestore firebaseFirestore;
  final CrashlyticsApi crashlyticsApi;

  CollectionReference<Map<String, dynamic>> get _firestoreClasses =>
      firebaseFirestore.collection('classes');

  Future<List<ClassModel>> getClassSchedule() async {
    List<ClassModel> classSchedule = [];
    await _firestoreClasses.get().then(
          (schedule) => schedule.docs.forEach(
            (json) {
              classSchedule.add(
                ClassModel.fromFirebase(json.data()),
              );
            },
          ),
        );

    classSchedule.sort((a, b) => b.compareTo(a));
    return classSchedule;
  }
}
