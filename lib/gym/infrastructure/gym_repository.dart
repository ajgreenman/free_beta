import 'package:free_beta/gym/infrastructure/gym_remote_data_provider.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';

class GymRepository {
  final GymRemoteDataProvider gymRemoteDataProvider;

  GymRepository({required this.gymRemoteDataProvider});

  Future<List<ResetModel>> getResetSchedule() async {
    var resetSchedule = await gymRemoteDataProvider.getResetSchedule();
    return resetSchedule.where((reset) => !reset.isDeleted).toList();
  }

  Future<void> addReset(ResetFormModel resetFormModel) async {
    await gymRemoteDataProvider.addReset(resetFormModel);
  }

  Future<void> updateReset(
    ResetModel resetModel,
    ResetFormModel resetFormModel,
  ) async {
    await gymRemoteDataProvider.updateReset(
      resetModel,
      resetFormModel,
    );
  }

  Future<void> deleteReset(
    ResetModel resetModel,
  ) async {
    await gymRemoteDataProvider.deleteReset(resetModel);
  }
}
