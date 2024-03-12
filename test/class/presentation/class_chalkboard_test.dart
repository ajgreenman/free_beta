import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/class_type.dart';
import 'package:free_beta/app/enums/day.dart';
import 'package:free_beta/app/presentation/widgets/chalkboard.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';
import 'package:free_beta/class/presentation/class_chalkboard.dart';
import 'package:free_beta/class/presentation/class_image.dart';
import 'package:free_beta/class/presentation/widgets/class_row.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockNavigatorObserver = MockNavigatorObserver();

    registerFallbackValue(MockRoute());
  });

  Widget buildFrame(List<ClassModel> classes, String? imageUrl) {
    return MaterialApp(
      home: ClassChalkboard(height: 100, classes: classes, imageUrl: imageUrl),
      navigatorObservers: [mockNavigatorObserver],
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame([classModel], null));

    expect(find.byType(ClassChalkboard), findsOneWidget);
    expect(find.byType(Chalkboard), findsOneWidget);
    expect(find.byType(ClassRow), findsOneWidget);
    expect(find.byType(ClassImage), findsNothing);
    expect(find.text("No classes scheduled"), findsNothing);
  });

  testWidgets('show image chalkboard when image is present', (tester) async {
    await tester.pumpWidget(buildFrame([], 'image'));

    expect(find.byType(ClassChalkboard), findsOneWidget);
    expect(find.byType(Chalkboard), findsOneWidget);
    expect(find.byType(ClassRow), findsNothing);
    expect(find.byType(ClassImage), findsOneWidget);
    expect(find.text("No classes scheduled"), findsNothing);
  });

  testWidgets('tapping class image pushes ClassImageScreen', (tester) async {
    await tester.pumpWidget(buildFrame([], 'image'));

    var classImage = find.byType(ClassImage);
    expect(classImage, findsOneWidget);

    await tester.tap(classImage);
    await tester.pump();

    verify(() => mockNavigatorObserver.didPush(any(), any())).called(2);
  });

  testWidgets('show empty chalkboard when no classes', (tester) async {
    await tester.pumpWidget(buildFrame([], null));

    expect(find.byType(ClassChalkboard), findsOneWidget);
    expect(find.byType(Chalkboard), findsOneWidget);
    expect(find.byType(ClassRow), findsNothing);
    expect(find.byType(ClassImage), findsNothing);
    expect(find.text("No classes scheduled"), findsOneWidget);
  });
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.noSuchMethod(Invocation.method(#didPush, [route, previousRoute]));
  }
}

class MockRoute extends Mock implements Route<dynamic> {}

var classModel = ClassModel(
  id: '',
  name: '',
  classType: ClassType.yoga,
  instructor: '',
  day: Day.sunday,
  hour: 0,
  minute: 0,
);
