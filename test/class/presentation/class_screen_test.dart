import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/class_type.dart';
import 'package:free_beta/app/enums/day.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/app/presentation/widgets/dots.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/class/infrastructure/class_api.dart';
import 'package:free_beta/class/infrastructure/class_providers.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';
import 'package:free_beta/class/infrastructure/models/day_model.dart';
import 'package:free_beta/class/presentation/class_chalkboard.dart';
import 'package:free_beta/class/presentation/class_image.dart';
import 'package:free_beta/class/presentation/class_screen.dart';
import 'package:free_beta/class/presentation/widgets/class_row.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockCrashlyticsApi mockCrashlyticsApi;
  late MockClassApi mockClassApi;

  setUp(() {
    mockCrashlyticsApi = MockCrashlyticsApi();
    when(() => mockCrashlyticsApi.logError(any(), any(), any(), any()))
        .thenAnswer((_) => Future.value());

    mockClassApi = MockClassApi();
    when(() => mockClassApi.getDays()).thenAnswer((_) => Future.value(days));
    when(() => mockClassApi.getClassSchedule())
        .thenAnswer((_) => Future.value(classSchedule));
  });

  Widget buildFrame() {
    return ProviderScope(
      overrides: [
        classApiProvider.overrideWithValue(mockClassApi),
        crashlyticsApiProvider.overrideWithValue(mockCrashlyticsApi),
      ],
      child: MaterialApp(home: ClassScreen()),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame());

    await tester.pumpAndSettle();

    expect(find.byKey(Key('class-screen')), findsOneWidget);
    expect(find.byType(CarouselSlider), findsOneWidget);
    expect(find.byType(FreeBetaDots), findsOneWidget);
    expect(find.byType(ClassChalkboard), findsNWidgets(3));
    expect(find.byType(ClassImage), findsNothing);
    expect(find.text('No classes scheduled'), findsNothing);
    expect(find.byType(ErrorCard), findsNothing);
  });

  testWidgets('show error when api errors', (tester) async {
    when(() => mockClassApi.getClassSchedule()).thenThrow(UnimplementedError());

    await tester.pumpWidget(buildFrame());

    await tester.pumpAndSettle();

    expect(find.byKey(Key('class-screen')), findsOneWidget);
    expect(find.byType(CarouselSlider), findsNothing);
    expect(find.byType(FreeBetaDots), findsNothing);
    expect(find.byType(ClassChalkboard), findsNothing);
    expect(find.byType(ClassImage), findsNothing);
    expect(find.text('No classes scheduled'), findsNothing);
    expect(find.byType(ErrorCard), findsOneWidget);
  });

  testWidgets('show image when day has image set', (tester) async {
    when(() => mockClassApi.getDays())
        .thenAnswer((_) => Future.value(daysWithImages));

    await tester.pumpWidget(buildFrame());

    await tester.pump();

    expect(find.byKey(Key('class-screen')), findsOneWidget);
    expect(find.byType(CarouselSlider), findsOneWidget);
    expect(find.byType(FreeBetaDots), findsOneWidget);
    expect(find.byType(ClassChalkboard), findsNWidgets(3));
    expect(find.byType(ClassImage), findsNWidgets(3));
    expect(find.text('No classes scheduled'), findsNothing);
    expect(find.byType(ErrorCard), findsNothing);
  });

  testWidgets('show empty chalkboard if there are no classes', (tester) async {
    when(() => mockClassApi.getClassSchedule())
        .thenAnswer((_) => Future.value([]));

    await tester.pumpWidget(buildFrame());

    await tester.pump();

    expect(find.byKey(Key('class-screen')), findsOneWidget);
    expect(find.byType(CarouselSlider), findsOneWidget);
    expect(find.byType(FreeBetaDots), findsOneWidget);
    expect(find.byType(ClassChalkboard), findsNWidgets(3));
    expect(find.byType(ClassImage), findsNothing);
    expect(find.byType(ClassRow), findsNothing);
    expect(find.text('No classes scheduled'), findsNWidgets(3));
    expect(find.byType(ErrorCard), findsNothing);
  });
}

class MockClassApi extends Mock implements ClassApi {}

class MockCrashlyticsApi extends Mock implements CrashlyticsApi {}

var days = Day.values.map((day) => DayModel(day: day, image: null)).toList();
var daysWithImages =
    Day.values.map((day) => DayModel(day: day, image: '')).toList();

var classSchedule = List.generate(
  Day.values.length,
  (index) => ClassModel(
    id: '',
    name: '',
    classType: ClassType.values[index % 3],
    instructor: '',
    day: Day.values[index],
    hour: 0,
    minute: 0,
    notes: 'note',
  ),
).toList();
