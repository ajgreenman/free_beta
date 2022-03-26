import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';

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

  factory RouteFormModel.fromRouteModel(RouteModel routeModel) =>
      RouteFormModel(
        name: routeModel.name,
        climbType: routeModel.climbType,
        creationDate: routeModel.creationDate,
        removalDate: routeModel.removalDate,
        routeColor: routeModel.routeColor,
        difficulty: routeModel.difficulty,
        images: routeModel.images,
      );

  Map<String, dynamic> toJson() {
    var json = {
      'name': name,
      'climbType': climbType!.name,
      'difficulty': difficulty,
      'routeColor': routeColor!.name,
      'creationDate': Timestamp.fromDate(creationDate!),
      'images': images,
    };

    if (removalDate != null) {
      json.putIfAbsent('removalDate', () => Timestamp.fromDate(removalDate!));
    }

    return json;
  }

  @override
  String toString() =>
      (this.name.toString()) +
      '\n' +
      (this.routeColor?.displayName ?? '') +
      '\n' +
      (this.climbType?.displayName ?? '') +
      '\n' +
      (this.difficulty.toString()) +
      '\n' +
      (this.creationDate.toString()) +
      '\n' +
      (this.removalDate.toString()) +
      '\n' +
      (this.images.length.toString());
}
