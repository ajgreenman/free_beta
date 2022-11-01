import 'package:free_beta/gym/infrastructure/gym_repository.dart';
import 'package:free_beta/gym/infrastructure/models/refresh_model.dart';

class GymApi {
  final GymRepository gymRepository;

  GymApi({required this.gymRepository});

  Future<List<RefreshModel>> getRefreshSchedule() {
    return gymRepository.getRefreshSchedule();
  }

  Future<void> addRefresh(RefreshFormModel refreshFormModel) {
    return gymRepository.addRefresh(refreshFormModel);
  }

  Future<void> updateRefresh(
    RefreshModel refreshModel,
    RefreshFormModel refreshFormModel,
  ) {
    return gymRepository.updateRefresh(
      refreshModel,
      refreshFormModel,
    );
  }

  Future<void> deleteRefresh(
    RefreshModel refreshModel,
  ) async {
    await gymRepository.deleteRefresh(
      refreshModel,
    );
  }
}
