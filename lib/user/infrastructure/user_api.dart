import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/gym/infrastructure/models/gym_model.dart';
import 'package:free_beta/user/infrastructure/models/user_model.dart';

class UserApi {
  UserApi(this._firebaseAuth, this._firestoreGyms, this._crashlyticsApi);

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestoreGyms;
  final CrashlyticsApi _crashlyticsApi;

  Stream<UserModel?> get authenticationStream =>
      _firebaseAuth.authStateChanges().map(_mapUser);

  UserModel? _mapUser(user) {
    if (user == null) return null;

    return UserModel(
      email: user.email ?? '',
      uid: user.uid,
      isAnonymous: user.isAnonymous,
    );
  }

  Future<bool> signIn(String email, String password) async {
    return await _firebaseAuth
        .signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        )
        .then((_) => true)
        .onError(
      (error, stackTrace) {
        _crashlyticsApi.logError(
          error,
          stackTrace,
          'UserApi',
          'signIn',
        );
        return false;
      },
    );
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
        .then((userCredential) => true)
        .onError(
      (error, stackTrace) {
        _crashlyticsApi.logError(
          error,
          stackTrace,
          'UserApi',
          'signUp',
        );
        return false;
      },
    );
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

  Future<void> deleteAccount() async {
    try {
      await _firebaseAuth.currentUser?.delete();
    } on Exception catch (error, stackTrace) {
      await signOut();
      _crashlyticsApi.logError(error, stackTrace, 'UserApi', 'deleteAccount');
    }
  }
}
