import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/routes/presentation/route_video_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:video_player/video_player.dart';

void main() {
  late MockVideoPlayerController mockVideoPlayerController;

  setUp(() {
    mockVideoPlayerController = MockVideoPlayerController();

    when(() => mockVideoPlayerController.setLooping(any()))
        .thenAnswer((_) => Future.value());
    when(() => mockVideoPlayerController.setVolume(any()))
        .thenAnswer((_) => Future.value());
    when(() => mockVideoPlayerController.initialize())
        .thenAnswer((_) => Future.value());
    when(() => mockVideoPlayerController.play())
        .thenAnswer((_) => Future.value());
    when(() => mockVideoPlayerController.value)
        .thenReturn(VideoPlayerValue(duration: Duration(seconds: 1)));
    when(() => mockVideoPlayerController.textureId).thenReturn(1);
    when(() => mockVideoPlayerController.dispose())
        .thenAnswer((_) => Future.value());
  });

  Widget buildFrame() {
    return MaterialApp(
      home: RouteVideoScreen(
        videoPlayerController: mockVideoPlayerController,
      ),
    );
  }

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(buildFrame());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(RouteVideoScreen), findsOneWidget);
    expect(find.byType(VideoPlayer), findsOneWidget);
  });

  testWidgets('loading state shows loading icon', (tester) async {
    await tester.pumpWidget(buildFrame());

    expect(find.byType(RouteVideoScreen), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}

class MockVideoPlayerController extends Mock implements VideoPlayerController {}
