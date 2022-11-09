import 'package:free_beta/gym/infrastructure/models/wall_section_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';

extension WallSectionListExtensions on List<WallSectionModel> {
  bool hasRoute(RouteModel routeModel) {
    return this
        .where((wallSection) => wallSection.hasRoute(routeModel))
        .isNotEmpty;
  }
}

extension WallSectionModelExtensions on WallSectionModel {
  bool hasRoute(RouteModel routeModel) {
    return wallLocation == routeModel.wallLocation &&
        wallSection == routeModel.wallLocationIndex;
  }
}
