class GymModel {
  final String id;
  final String name;
  final String password;

  GymModel({
    required this.id,
    required this.name,
    required this.password,
  });

  factory GymModel.fromFirebase(String id, Map<String, dynamic> json) =>
      GymModel(
        id: id,
        name: json['name'],
        password: json['password'],
      );
}
