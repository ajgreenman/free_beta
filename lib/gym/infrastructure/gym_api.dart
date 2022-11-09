import 'package:free_beta/gym/infrastructure/gym_repository.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';

class GymApi {
  final GymRepository gymRepository;

  GymApi({required this.gymRepository});

  Future<List<ResetModel>> getResetSchedule() {
    return gymRepository.getResetSchedule();
  }

  Future<void> addReset(ResetFormModel resetFormModel) {
    return gymRepository.addReset(resetFormModel);
  }

  Future<void> updateReset(
    ResetModel resetModel,
    ResetFormModel resetFormModel,
  ) {
    return gymRepository.updateReset(
      resetModel,
      resetFormModel,
    );
  }

  Future<void> deleteReset(
    ResetModel resetModel,
  ) async {
    await gymRepository.deleteReset(
      resetModel,
    );
  }
}
