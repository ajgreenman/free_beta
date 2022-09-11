import 'package:free_beta/app/enums/gym.dart';

class UserModel {
  UserModel({
    required this.email,
    required this.uid,
    required this.isAnonymous,
    this.gyms = const [],
  });

  final String email;
  final String uid;
  final bool isAnonymous;
  final List<Gym> gyms;
}
