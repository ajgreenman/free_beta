import 'package:collection/collection.dart';
import 'package:free_beta/app/extensions/date_extensions.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';

extension resetModelListExtensions on List<ResetModel> {
  ResetModel? get currentReset {
    var currentResets = this
        .where((resetModel) =>
            resetModel.date.isToday || resetModel.date.isAfterToday)
        .toList();
    if (currentResets.isEmpty) return null;

    currentResets.sort((a, b) => a.date.compareTo(b.date));
    return currentResets.first;
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
