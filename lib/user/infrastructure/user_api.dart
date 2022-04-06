import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/gym/infrastructure/models/gym_model.dart';

final userApiProvider = Provider((_) => UserApi(
      FirebaseAuth.instance,
      FirebaseFirestore.instance,
    ));

final authenticationProvider = StreamProvider((ref) {
  return ref.read(userApiProvider).authenticationStream;
});

class UserApi {
  UserApi(this._firebaseAuth, this._firestoreGyms);

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestoreGyms;

  Stream<User?> get authenticationStream => _firebaseAuth.authStateChanges();

  Future<bool> signIn(String email, String password) async {
    return await _firebaseAuth
        .signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        )
        .then((_) => true)
        .onError((_, __) => false);
  }

  Future<bool> signUp(
    String email,
    String password,
  ) async {
    if (_firebaseAuth.currentUser == null) return false;

    var credential = EmailAuthProvider.credential(
      email: email.trim(),
      password: password.trim(),
    );

    return await _firebaseAuth.currentUser!
        .linkWithCredential(credential)
        .then((userCredential) {
      log('Anonymous account upgrade for $email');
      return true;
    }).onError((error, stackTrace) {
      log('Error linking account for $email\n${error.toString()}\n${stackTrace.toString()}');
      return false;
    });
  }

  Future<bool> checkGymPassword(String input) async {
    List<GymModel> gyms = [];

    await _firestoreGyms.collection('gyms').get().then(
          (gymCollection) => gymCollection.docs.forEach(
            (json) {
              gyms.add(
                GymModel.fromFirebase(json.id, json.data()),
              );
            },
          ),
        );

    if (gyms.isEmpty) return false;

    var elevate = gyms.where((gym) => gym.name == 'Elev8');
    if (elevate.isEmpty) return false;

    return elevate.first.password == input.trim();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
