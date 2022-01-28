import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userApiProvider = Provider((_) => UserApi(FirebaseAuth.instance));

final authenticationProvider = StreamProvider((ref) {
  return ref.watch(userApiProvider).authenticationStream;
});

class UserApi {
  UserApi(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authenticationStream => _firebaseAuth.authStateChanges();

  Future<bool> signIn(String email, String password) async {
    return await _firebaseAuth
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((_) => true)
        .onError((_, __) => false);
  }

  Future<void> signUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
