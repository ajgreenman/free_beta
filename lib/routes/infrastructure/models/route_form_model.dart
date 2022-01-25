import 'package:free_beta/app/enums/enums.dart';

class RouteFormModel {
  String? name;
  String? difficulty;
  ClimbType? climbType;
  RouteColor? routeColor;
  DateTime? creationDate;
  DateTime? removalDate;
  List<String>? images;

  RouteFormModel({
    this.name,
    this.difficulty,
    this.climbType,
    this.routeColor,
    this.creationDate,
    this.removalDate,
    this.images,
  });

  @override
  String toString() =>
      (this.name ?? '') +
      '\n' +
      (this.difficulty ?? '') +
      '\n' +
      (this.climbType?.displayName ?? '') +
      '\n' +
      (this.routeColor?.displayName ?? '');
}
