import 'package:collection/collection.dart';
import 'package:free_beta/app/extensions/date_extensions.dart';
import 'package:free_beta/gym/infrastructure/models/refresh_model.dart';

extension RefreshModelListExtensions on List<RefreshModel> {
  RefreshModel? get currentRefresh {
    var currentRefreshes = this
        .where((refreshModel) =>
            refreshModel.date.isToday || refreshModel.date.isAfterToday)
        .toList();
    if (currentRefreshes.isEmpty) return null;

    currentRefreshes.sort((a, b) => a.date.compareTo(b.date));
    return currentRefreshes.first;
  }

  RefreshModel? get latestRefresh => this.firstWhereOrNull(
        (refreshModel) =>
            refreshModel.date.isToday || refreshModel.date.isBeforeToday,
      );

  List<RefreshModel> get futureRefreshes {
    var futureRefreshes =
        this.where((refreshModel) => refreshModel.date.isAfterToday).toList();
    futureRefreshes.sort((a, b) => a.date.compareTo(b.date));
    return futureRefreshes;
  }
}
