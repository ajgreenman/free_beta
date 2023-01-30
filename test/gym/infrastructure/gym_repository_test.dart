import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/gym/infrastructure/gym_remote_data_provider.dart';
import 'package:free_beta/gym/infrastructure/gym_repository.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late GymRepository gymRepository;
  late MockGymRemoteDataProvider mockGymRemoteDataProvider;

  setUp(() {
    mockGymRemoteDataProvider = MockGymRemoteDataProvider();

    registerFallbackValue(resetModel);
    registerFallbackValue(resetFormModel);

    gymRepository = GymRepository(
      gymRemoteDataProvider: mockGymRemoteDataProvider,
    );
  });

  group('GymRepository', () {
    test('getResetSchedule only retrieves non-deleted resets', () async {
      when(() => mockGymRemoteDataProvider.getResetSchedule())
          .thenAnswer((_) => Future.value(resetSchedule));

      var resets = await gymRepository.getResetSchedule();

      expect(resets.length, 2);
      verify(() => mockGymRemoteDataProvider.getResetSchedule()).called(1);
    });
    test('addReset calls data provider', () async {
      when(() => mockGymRemoteDataProvider.addReset(any()))
          .thenAnswer((_) => Future.value());

      await gymRepository.addReset(resetFormModel);

      verify(() => mockGymRemoteDataProvider.addReset(any())).called(1);
    });
    test('updateReset calls data provider', () async {
      when(() => mockGymRemoteDataProvider.updateReset(any(), any()))
          .thenAnswer((_) => Future.value());

      await gymRepository.updateReset(resetModel, resetFormModel);

      verify(() => mockGymRemoteDataProvider.updateReset(any(), any()))
          .called(1);
    });
    test('deleteReset calls data provider', () async {
      when(() => mockGymRemoteDataProvider.deleteReset(any()))
          .thenAnswer((_) => Future.value());

      await gymRepository.deleteReset(resetModel);

      verify(() => mockGymRemoteDataProvider.deleteReset(any())).called(1);
    });
  });
}

class MockGymRemoteDataProvider extends Mock implements GymRemoteDataProvider {}

var resetSchedule = [
  deletedResetModel,
  resetModel,
  resetModel,
  deletedResetModel,
];

var resetModel = ResetModel(
  id: 'id',
  date: DateTime.now(),
  sections: [],
);

var deletedResetModel = ResetModel(
  id: 'id',
  date: DateTime.now(),
  sections: [],
  isDeleted: true,
);

var resetFormModel = ResetFormModel(
  date: DateTime.now(),
  sections: [],
);
