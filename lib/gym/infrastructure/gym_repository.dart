import 'package:free_beta/gym/infrastructure/gym_remote_data_provider.dart';
import 'package:free_beta/gym/infrastructure/models/refresh_model.dart';

class GymRepository {
  final GymRemoteDataProvider gymRemoteDataProvider;

  GymRepository({required this.gymRemoteDataProvider});

  Future<List<RefreshModel>> getRefreshSchedule() async {
    var refreshSchedule = await gymRemoteDataProvider.getRefreshSchedule();
    return refreshSchedule.where((refresh) => !refresh.isDeleted).toList();
  }

  Future<void> addRefresh(RefreshFormModel refreshFormModel) async {
    await gymRemoteDataProvider.addRefresh(refreshFormModel);
  }

  Future<void> updateRefresh(
    RefreshModel refreshModel,
    RefreshFormModel refreshFormModel,
  ) async {
    await gymRemoteDataProvider.updateRefresh(
      refreshModel,
      refreshFormModel,
    );
  }

  Future<void> deleteRefresh(
    RefreshModel refreshModel,
  ) async {
    await gymRemoteDataProvider.deleteRefresh(refreshModel);
  }
}
