import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/app/presentation/widgets/error_card.dart';
import 'package:free_beta/gym/infrastructure/gym_api.dart';
import 'package:free_beta/gym/infrastructure/gym_providers.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';
import 'package:free_beta/gym/infrastructure/models/wall_section_model.dart';
import 'package:free_beta/gym/presentation/reset_schedule_screen.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockCrashlyticsApi mockCrashlyticsApi;
  late MockGymApi mockGymApi;

  setUp(() {
    mockCrashlyticsApi = MockCrashlyticsApi();
    when(() => mockCrashlyticsApi.logError(any(), any(), any(), any()))
        .thenAnswer((_) => Future.value());

    mockGymApi = MockGymApi();

    when(() => mockGymApi.getResetSchedule())
        .thenAnswer((_) => Future.value(resets));
  });

  Widget buildFrame() {
    return ProviderScope(
      overrides: [
        crashlyticsApiProvider.overrideWithValue(mockCrashlyticsApi),
        gymApiProvider.overrideWithValue(mockGymApi),
      ],
      child: MaterialApp(
        home: ResetScheduleScreen(),
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame());

    await tester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(WallSectionMap), findsNWidgets(2));
    expect(find.text('Upcoming resets'), findsOneWidget);
    expect(find.text('No upcoming resets'), findsNothing);
    expect(find.text('Previous resets'), findsOneWidget);
    expect(find.text('No previous resets'), findsNothing);
    expect(find.text('Last reset: n/a'), findsNothing);
    expect(find.byType(ErrorCard), findsNothing);
  });

  testWidgets('On error show error card', (tester) async {
    when(() => mockGymApi.getResetSchedule()).thenThrow(UnimplementedError());

    await tester.pumpWidget(buildFrame());

    await tester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsNothing);
    expect(find.byType(WallSectionMap), findsNothing);
    expect(find.text('Upcoming resets'), findsNothing);
    expect(find.text('No upcoming resets'), findsNothing);
    expect(find.text('Previous resets'), findsNothing);
    expect(find.text('No previous resets'), findsNothing);
    expect(find.text('Last reset: n/a'), findsNothing);
    expect(find.byType(ErrorCard), findsOneWidget);
  });

  testWidgets('No resets shows empty schedule', (tester) async {
    when(() => mockGymApi.getResetSchedule())
        .thenAnswer((_) => Future.value([]));

    await tester.pumpWidget(buildFrame());

    await tester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsNothing);
    expect(find.byType(WallSectionMap), findsNothing);
    expect(find.text('Upcoming resets'), findsNothing);
    expect(find.text('No upcoming resets'), findsNothing);
    expect(find.text('Previous resets'), findsNothing);
    expect(find.text('No previous resets'), findsNothing);
    expect(find.text('Last reset: n/a'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(ErrorCard), findsNothing);
  });

  testWidgets('No previous resets shows only upcoming', (tester) async {
    when(() => mockGymApi.getResetSchedule())
        .thenAnswer((_) => Future.value([tomorrow]));

    await tester.pumpWidget(buildFrame());

    await tester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(WallSectionMap), findsNWidgets(1));
    expect(find.text('Upcoming resets'), findsOneWidget);
    expect(find.text('No upcoming resets'), findsNothing);
    expect(find.text('Previous resets'), findsOneWidget);
    expect(find.text('No previous resets'), findsOneWidget);
    expect(find.text('Last reset: n/a'), findsNothing);
    expect(find.byType(ErrorCard), findsNothing);
  });
}

class MockCrashlyticsApi extends Mock implements CrashlyticsApi {}

class MockGymApi extends Mock implements GymApi {}

var resets = [
  yesterday,
  today,
  tomorrow,
];

var yesterday = ResetModel(
  id: '',
  date: DateTime.now().subtract(Duration(days: 1)),
  sections: [
    WallSectionModel(
      wallLocation: WallLocation.boulder,
      wallSection: 1,
    ),
  ],
);

var today = ResetModel(
  id: '',
  date: DateTime.now(),
  sections: [],
);

var tomorrow = ResetModel(
  id: '',
  date: DateTime.now().add(Duration(days: 1)),
  sections: [
    WallSectionModel(
      wallLocation: WallLocation.boulder,
      wallSection: 2,
    ),
  ],
);
