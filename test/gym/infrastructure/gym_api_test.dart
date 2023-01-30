import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/gym/infrastructure/gym_api.dart';
import 'package:free_beta/gym/infrastructure/gym_repository.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late GymApi gymApi;
  late MockGymRepository mockGymRepository;

  setUp(() {
    mockGymRepository = MockGymRepository();

    registerFallbackValue(resetModel);
    registerFallbackValue(resetFormModel);

    gymApi = GymApi(
      gymRepository: mockGymRepository,
    );
  });

  group('GymApi', () {
    test('getResetSchedule calls repository', () async {
      when(() => mockGymRepository.getResetSchedule())
          .thenAnswer((_) => Future.value([]));

      await gymApi.getResetSchedule();

      verify(() => mockGymRepository.getResetSchedule()).called(1);
    });
    test('addReset calls data provider', () async {
      when(() => mockGymRepository.addReset(any()))
          .thenAnswer((_) => Future.value());

      await gymApi.addReset(resetFormModel);

      verify(() => mockGymRepository.addReset(any())).called(1);
    });
    test('updateReset calls data provider', () async {
      when(() => mockGymRepository.updateReset(any(), any()))
          .thenAnswer((_) => Future.value());

      await gymApi.updateReset(resetModel, resetFormModel);

      verify(() => mockGymRepository.updateReset(any(), any())).called(1);
    });
    test('deleteReset calls data provider', () async {
      when(() => mockGymRepository.deleteReset(any()))
          .thenAnswer((_) => Future.value());

      await gymApi.deleteReset(resetModel);

      verify(() => mockGymRepository.deleteReset(any())).called(1);
    });
  });
}

class MockGymRepository extends Mock implements GymRepository {}

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
