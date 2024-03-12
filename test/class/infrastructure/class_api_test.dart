import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/class_type.dart';
import 'package:free_beta/app/enums/day.dart';
import 'package:free_beta/class/infrastructure/class_api.dart';
import 'package:free_beta/class/infrastructure/class_repository.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';
import 'package:free_beta/class/infrastructure/models/day_model.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late ClassApi classApi;
  late MockClassRepository mockClassRepository;

  setUp(() {
    mockClassRepository = MockClassRepository();

    registerFallbackValue(classModel);
    registerFallbackValue(classFormModel);
    registerFallbackValue(Day.sunday);
    registerFallbackValue(dayModel);

    classApi = ClassApi(
      classRepository: mockClassRepository,
    );
  });

  group('ClassApi', () {
    test('getClassSchedule returns schedule from repository', () async {
      when(() => mockClassRepository.getClassSchedule())
          .thenAnswer((_) => Future.value(classSchedule));

      var schedule = await classApi.getClassSchedule();

      expect(schedule.length, classSchedule.length);
      verify(() => mockClassRepository.getClassSchedule()).called(1);
    });

    test('addClass calls repository', () async {
      when(() => mockClassRepository.addClass(any()))
          .thenAnswer((_) => Future.value());

      await classApi.addClass(classFormModel);

      verify(() => mockClassRepository.addClass(any())).called(1);
    });

    test('updateClass calls repository', () async {
      when(() => mockClassRepository.updateClass(any(), any()))
          .thenAnswer((_) => Future.value());

      await classApi.updateClass(classModel, classFormModel);

      verify(() => mockClassRepository.updateClass(any(), any())).called(1);
    });

    test('deleteClass calls repository', () async {
      when(() => mockClassRepository.deleteClass(any()))
          .thenAnswer((_) => Future.value());

      await classApi.deleteClass(classModel);

      verify(() => mockClassRepository.deleteClass(any())).called(1);
    });

    test('addDayImage calls repository', () async {
      when(() => mockClassRepository.addDayImage(any(), any()))
          .thenAnswer((_) => Future.value());

      await classApi.addDayImage(Day.sunday, '');

      verify(() => mockClassRepository.addDayImage(any(), any())).called(1);
    });

    test('deleteDayImage calls repository', () async {
      when(() => mockClassRepository.deleteDayImage(any()))
          .thenAnswer((_) => Future.value());

      await classApi.deleteDayImage(Day.sunday);

      verify(() => mockClassRepository.deleteDayImage(any())).called(1);
    });

    test('getDays returns days from repository', () async {
      when(() => mockClassRepository.getDays())
          .thenAnswer((_) => Future.value(dayModels));

      var days = await classApi.getDays();

      expect(days.length, dayModels.length);
      verify(() => mockClassRepository.getDays()).called(1);
    });
  });
}

class MockClassRepository extends Mock implements ClassRepository {}

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
