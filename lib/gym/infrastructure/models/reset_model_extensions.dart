import 'package:collection/collection.dart';
import 'package:free_beta/app/extensions/date_extensions.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';

extension resetModelListExtensions on List<ResetModel> {
  ResetModel? get currentReset {
    var currentResets = this
        .where((resetModel) =>
            resetModel.date.isToday || resetModel.date.isAfterToday)
        .toList();
    if (currentResets.isEmpty) return latestReset;

    currentResets.sort((a, b) => a.date.compareTo(b.date));
    return currentResets.first;
  }

  List<ResetModel> get currentResets {
    var currentResets = this
        .where((resetModel) =>
            resetModel.date.isToday || resetModel.date.isAfterToday)
        .toList();

    currentResets.sort((a, b) => a.date.compareTo(b.date));
    return currentResets;
  }

  List<ResetModel> get previousResets {
    var previousResets =
        where((resetModel) => resetModel.date.isBeforeToday).toList();

    return previousResets;
  }

  ResetModel? get latestReset => this.firstWhereOrNull(
        (resetModel) =>
            resetModel.date.isToday || resetModel.date.isBeforeToday,
      );

  List<ResetModel> get futureResets {
    var futureResets =
        this.where((resetModel) => resetModel.date.isAfterToday).toList();
    futureResets.sort((a, b) => a.date.compareTo(b.date));
    return futureResets;
  }
}
