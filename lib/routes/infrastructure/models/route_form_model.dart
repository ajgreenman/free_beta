import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/app/enums/enums.dart';

class RouteFormModel {
  String? name;
  String? difficulty;
  ClimbType? climbType;
  RouteColor? routeColor;
  DateTime? creationDate;
  DateTime? removalDate;
  List<String> images;

  RouteFormModel({
    this.name,
    this.difficulty,
    this.climbType,
    this.routeColor,
    this.creationDate,
    this.removalDate,
    this.images = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'climbType': climbType!.name,
      'difficulty': difficulty,
      'routeColor': routeColor!.name,
      'creationDate': Timestamp.fromDate(creationDate!),
      'images': images,
    };
  }

  @override
  String toString() =>
      (this.name.toString()) +
      '\n' +
      (this.difficulty.toString()) +
      '\n' +
      (this.climbType?.displayName ?? '') +
      '\n' +
      (this.routeColor?.displayName ?? '') +
      '\n' +
      (this.creationDate.toString());
}
