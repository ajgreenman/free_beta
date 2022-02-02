import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/user/infrastructure/models/feedback_form_model.dart';

final emailApiProvider = Provider((_) => EmailApi());

class EmailApi {
  CollectionReference<Map<String, dynamic>> get firestore =>
      FirebaseFirestore.instance.collection('email_collection');

  Future<bool> sendEmail(FeedbackFormModel feedbackFormModel) async {
    return await firestore
        .add(feedbackFormModel.toJson())
        .then((_) => true)
        .onError((_, __) => false);
  }
}
