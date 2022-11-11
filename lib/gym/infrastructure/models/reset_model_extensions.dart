import 'package:collection/collection.dart';
import 'package:free_beta/app/extensions/date_extensions.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';
import 'package:free_beta/gym/infrastructure/models/wall_section_model_extensions.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';

extension ResetModelListExtensions on List<ResetModel> {
  List<ResetModel> get pastResets {
    var previousResets =
        where((resetModel) => resetModel.date.isBeforeToday).toList();

    previousResets.sort((a, b) => b.date.compareTo(a.date));
    return previousResets;
  }

  List<ResetModel> get _futureResets {
    var futureResets =
        this.where((resetModel) => resetModel.date.isAfterToday).toList();

    futureResets.sort((a, b) => a.date.compareTo(b.date));
    return futureResets;
  }

  List<ResetModel> get nextResets {
    if (todaysReset == null) return _futureResets;

    return [todaysReset!, ..._futureResets];
  }

  ResetModel? get todaysReset =>
      this.firstWhereOrNull((resetModel) => resetModel.date.isToday);

  ResetModel? get latestReset {
    if (pastResets.isEmpty) return null;

    return pastResets.first;
  }

  ResetModel? get nextReset {
    if (nextResets.isEmpty) return null;

    return nextResets.first;
  }
}

extension NullableResetModelExtensions on ResetModel? {
  bool containsRouteInSection(RouteModel routeModel) {
    if (this == null) return false;

    return this!.sections.hasRoute(routeModel);
  }

  bool hadRouteInReset(RouteModel routeModel) {
    if (this == null) return false;

    return this!.date.difference(routeModel.creationDate) == Duration.zero;
  }
}
