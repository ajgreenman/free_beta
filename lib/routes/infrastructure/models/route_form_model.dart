import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';

class RouteFormModel {
  String? name;
  String? difficulty;
  ClimbType? climbType;
  RouteColor? routeColor;
  WallLocation? wallLocation;
  int? wallLocationIndex;
  DateTime? creationDate;
  DateTime? removalDate;
  List<String>? images;

  RouteFormModel({
    this.name,
    this.difficulty,
    this.climbType,
    this.routeColor,
    this.wallLocation,
    this.wallLocationIndex,
    this.creationDate,
    this.removalDate,
    this.images,
  });

  factory RouteFormModel.fromRouteModel(RouteModel routeModel) {
    return RouteFormModel(
      name: routeModel.name,
      climbType: routeModel.climbType,
      wallLocation: routeModel.wallLocation,
      wallLocationIndex: routeModel.wallLocationIndex,
      creationDate: routeModel.creationDate,
      removalDate: routeModel.removalDate,
      routeColor: routeModel.routeColor,
      difficulty: routeModel.difficulty,
      images: routeModel.images,
    );
  }

  Map<String, dynamic> toJson() {
    var json = {
      'name': name,
      'climbType': climbType!.name,
      'difficulty': difficulty,
      'routeColor': routeColor!.name,
      'wallLocation': wallLocation!.name,
      'wallLocationIndex': wallLocationIndex,
      'creationDate': Timestamp.fromDate(creationDate!),
      'isActive': true,
      'images': images,
    };

    if (removalDate != null) {
      json.putIfAbsent('removalDate', () => Timestamp.fromDate(removalDate!));
      json.update('isActive', (value) => false);
    }

    return json;
  }

  @override
  String toString() =>
      (name.toString()) +
      '\n' +
      (routeColor?.displayName ?? '') +
      '\n' +
      (climbType?.displayName ?? '') +
      '\n' +
      (difficulty.toString()) +
      '\n' +
      (wallLocation.toString()) +
      '\n' +
      (wallLocationIndex.toString()) +
      '\n' +
      (creationDate.toString()) +
      '\n' +
      (removalDate.toString()) +
      '\n' +
      ((images?.length ?? 0).toString());
}
