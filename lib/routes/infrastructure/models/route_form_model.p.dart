part of 'route_form_model.dart';

extension RouteFormModelExtensions on RouteFormModel {
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
}
