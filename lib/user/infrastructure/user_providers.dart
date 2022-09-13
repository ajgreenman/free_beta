import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/user/infrastructure/user_api.dart';

final userApiProvider = Provider((ref) => UserApi(
      FirebaseAuth.instance,
      FirebaseFirestore.instance,
      ref.read(crashlyticsApiProvider),
    ));

final authenticationProvider = StreamProvider((ref) {
  return ref.read(userApiProvider).authenticationStream;
});
