import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/user/infrastructure/models/user_model.dart';
import 'package:free_beta/user/infrastructure/user_remote_data_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_providers.g.dart';

@Riverpod(dependencies: [crashlyticsApi])
UserRemoteDataProvider userApi(Ref ref) {
  return UserRemoteDataProvider(
    FirebaseAuth.instance,
    FirebaseFirestore.instance,
    ref.read(crashlyticsApiProvider),
  );
}

@Riverpod(dependencies: [userApi])
Stream<UserModel?> authenticationStream(Ref ref) {
  return ref.read(userApiProvider).authenticationStream;
}
