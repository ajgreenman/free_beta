// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @override
  bool operator ==(covariant GymModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.password == password;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ password.hashCode;
}
