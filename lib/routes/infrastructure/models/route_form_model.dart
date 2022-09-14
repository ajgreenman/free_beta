import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';

part 'route_form_model.p.dart';

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
}
