import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/routes/infrastructure/route_providers.dart';
import 'package:free_beta/user/infrastructure/models/user_rating_model.dart';
import 'package:free_beta/user/presentation/widgets/user_route_graph.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockCrashlyticsApi mockCrashlyticsApi;

  setUp(() {
    mockCrashlyticsApi = MockCrashlyticsApi();
    when(() => mockCrashlyticsApi.logError(any(), any(), any(), any()))
        .thenAnswer((_) => Future.value());
  });

  Widget buildFrame(AsyncValue<List<Series<UserRatingModel, String>>> value) {
    return ProviderScope(
      overrides: [
        fetchRatingUserGraph(ClimbType.boulder).overrideWithValue(value),
        crashlyticsApiProvider.overrideWithValue(mockCrashlyticsApi),
      ],
      child: MaterialApp(
        home: UserRouteGraph(
          climbType: ClimbType.boulder,
        ),
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame(AsyncData([])));

    expect(find.byType(BarChart), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byKey(Key('UserRouteGraph-error')), findsNothing);
  });

  testWidgets('loading shows progress indicator', (tester) async {
    await tester.pumpWidget(buildFrame(
      AsyncLoading(),
    ));

    expect(find.byType(BarChart), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byKey(Key('UserRouteGraph-error')), findsNothing);
  });

  testWidgets('error shows error card', (tester) async {
    await tester.pumpWidget(buildFrame(
      AsyncError(''),
    ));

    expect(find.byType(BarChart), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byKey(Key('UserRouteGraph-error')), findsOneWidget);
  });
}

class MockCrashlyticsApi extends Mock implements CrashlyticsApi {}
