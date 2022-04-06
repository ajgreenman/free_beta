import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/user/infrastructure/models/feedback_form_model.dart';

final emailApiProvider = Provider(
  (ref) => EmailApi(ref.read(crashlyticsApiProvider)),
);

class EmailApi {
  EmailApi(this._crashlyticsApi);

  final CrashlyticsApi _crashlyticsApi;

  CollectionReference<Map<String, dynamic>> get firestore =>
      FirebaseFirestore.instance.collection('email_collection');

  Future<bool> sendEmail(FeedbackFormModel feedbackFormModel) async {
    return await firestore
        .add(feedbackFormModel.toJson())
        .then((_) => true)
        .onError(
      (error, stackTrace) {
        _crashlyticsApi.logError(error, stackTrace, 'EmailApi', 'sendEmail');
        return false;
      },
    );
  }
}
