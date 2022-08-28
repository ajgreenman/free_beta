import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';

class RouteFormModel {
  String? name;
  BoulderRating? boulderRating;
  YosemiteRating? yosemiteRating;
  ClimbType? climbType;
  RouteColor? routeColor;
  WallLocation? wallLocation;
  int? wallLocationIndex;
  DateTime? creationDate;
  DateTime? removalDate;
  List<String>? images;
  String? betaVideo;

  RouteFormModel({
    this.name,
    this.boulderRating,
    this.yosemiteRating,
    this.climbType,
    this.routeColor,
    this.wallLocation,
    this.wallLocationIndex,
    this.creationDate,
    this.removalDate,
    this.images,
    this.betaVideo,
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
      boulderRating: routeModel.boulderRating,
      yosemiteRating: routeModel.yosemiteRating,
      images: routeModel.images,
      betaVideo: routeModel.betaVideo,
    );
  }

  Map<String, dynamic> toJson() {
    var json = {
      'name': name,
      'climbType': climbType!.name,
      'difficulty': boulderRating?.displayName ?? yosemiteRating?.displayName,
      'routeColor': routeColor!.name,
      'wallLocation': wallLocation!.name,
      'wallLocationIndex': wallLocationIndex ?? 0,
      'creationDate': Timestamp.fromDate(creationDate!),
      'isActive': true,
      'images': images,
      'betaVideo': betaVideo,
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
      ((boulderRating?.name ?? yosemiteRating?.name).toString()) +
      '\n' +
      (wallLocation.toString()) +
      '\n' +
      (wallLocationIndex.toString()) +
      '\n' +
      (creationDate.toString()) +
      '\n' +
      (removalDate.toString()) +
      '\n' +
      ((images?.length ?? 0).toString()) +
      '\n' +
      (betaVideo.toString());
}
