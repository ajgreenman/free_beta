import 'package:free_beta/app/enums/gym.dart';

class UserModel {
  UserModel({
    required this.email,
    required this.uid,
    this.gyms = const [],
  });

  final String email;
  final String uid;
  final List<Gym> gyms;
}
