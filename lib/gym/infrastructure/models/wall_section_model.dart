import 'package:free_beta/app/enums/wall_location.dart';

class WallSectionModel {
  WallSectionModel({
    required this.wallLocation,
    required this.wallSection,
  });

  factory WallSectionModel.fromFirebase(Map<String, dynamic> json) =>
      WallSectionModel(
        wallLocation: WallLocation.values.firstWhere(
          (wallLocation) => wallLocation.name == json['wallLocation'],
        ),
        wallSection: json['wallSection'],
      );

  final WallLocation wallLocation;
  final int wallSection;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WallSectionModel &&
        other.wallLocation == wallLocation &&
        other.wallSection == wallSection;
  }

  @override
  int get hashCode => wallLocation.hashCode ^ wallSection.hashCode;

  @override
  String toString() =>
      'WallSectionModel(wallLocation: $wallLocation, wallSection: $wallSection)';
}
