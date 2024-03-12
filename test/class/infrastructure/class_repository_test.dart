import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/class_type.dart';
import 'package:free_beta/app/enums/day.dart';
import 'package:free_beta/class/infrastructure/class_remote_data_provider.dart';
import 'package:free_beta/class/infrastructure/class_repository.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';
import 'package:free_beta/class/infrastructure/models/day_model.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late ClassRepository classRepository;
  late MockClassRemoteDataProvider mockClassRemoteDataProvider;

  setUp(() {
    mockClassRemoteDataProvider = MockClassRemoteDataProvider();

    registerFallbackValue(classModel);
    registerFallbackValue(classFormModel);
    registerFallbackValue(Day.sunday);
    registerFallbackValue(dayModel);

    classRepository = ClassRepository(
      classRemoteDataProvider: mockClassRemoteDataProvider,
    );
  });

  group('ClassRepository', () {
    test('getClassSchedule returns schedule from data provider', () async {
      when(() => mockClassRemoteDataProvider.getClassSchedule())
          .thenAnswer((_) => Future.value(classSchedule));

      var schedule = await classRepository.getClassSchedule();

      expect(schedule.length, classSchedule.length);
      verify(() => mockClassRemoteDataProvider.getClassSchedule()).called(1);
    });

    test('addClass calls data provider', () async {
      when(() => mockClassRemoteDataProvider.addClass(any()))
          .thenAnswer((_) => Future.value());

      await classRepository.addClass(classFormModel);

      verify(() => mockClassRemoteDataProvider.addClass(any())).called(1);
    });

    test('updateClass calls data provider', () async {
      when(() => mockClassRemoteDataProvider.updateClass(any(), any()))
          .thenAnswer((_) => Future.value());

      await classRepository.updateClass(classModel, classFormModel);

      verify(() => mockClassRemoteDataProvider.updateClass(any(), any()))
          .called(1);
    });

    test('deleteClass calls data provider', () async {
      when(() => mockClassRemoteDataProvider.deleteClass(any()))
          .thenAnswer((_) => Future.value());

      await classRepository.deleteClass(classModel);

      verify(() => mockClassRemoteDataProvider.deleteClass(any())).called(1);
    });

    test('addDayImage calls data provider', () async {
      when(() => mockClassRemoteDataProvider.addDayImage(any(), any()))
          .thenAnswer((_) => Future.value());

      await classRepository.addDayImage(Day.sunday, '');

      verify(() => mockClassRemoteDataProvider.addDayImage(any(), any()))
          .called(1);
    });

    test('deleteDayImage calls data provider', () async {
      when(() => mockClassRemoteDataProvider.deleteDayImage(any()))
          .thenAnswer((_) => Future.value());

      await classRepository.deleteDayImage(Day.sunday);

      verify(() => mockClassRemoteDataProvider.deleteDayImage(any())).called(1);
    });

    test('getDays returns days from data provider', () async {
      when(() => mockClassRemoteDataProvider.getDays())
          .thenAnswer((_) => Future.value(dayModels));

      var days = await classRepository.getDays();

      expect(days.length, dayModels.length);
      verify(() => mockClassRemoteDataProvider.getDays()).called(1);
    });
  });
}

class MockClassRemoteDataProvider extends Mock
    implements ClassRemoteDataProvider {}

var classSchedule = [
  classModel,
  classModel,
  classModel,
];

var classModel = ClassModel(
  id: '',
  name: '',
  classType: ClassType.yoga,
  instructor: '',
  day: Day.sunday,
  hour: 0,
  minute: 0,
);

var classFormModel = ClassFormModel();

var dayModels = [
  dayModel,
  dayModel,
  dayModel,
];

var dayModel = DayModel(day: Day.sunday, image: '');
