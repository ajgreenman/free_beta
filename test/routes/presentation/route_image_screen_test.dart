import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/routes/presentation/route_image_screen.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockCacheManager mockCacheManager;

  setUp(() {
    mockCacheManager = MockCacheManager();
  });

  Widget buildFrame({
    required List<String> images,
    required VoidCallback onLeft,
    required VoidCallback onRight,
  }) {
    return ProviderScope(
      overrides: [
        cacheManagerProvider.overrideWith((_) => mockCacheManager),
      ],
      child: MaterialApp(
        home: RouteImageScreen(
          images: images,
          initialIndex: 0,
          onSwipeLeft: onLeft,
          onSwipeRight: onRight,
        ),
      ),
    );
  }

  group('RouteImageScreen', () {
    testWidgets('smoke test', (tester) async {
      var count = 0;
      await tester.pumpWidget(
        buildFrame(
          images: ['image.png'],
          onLeft: () => count--,
          onRight: () => count++,
        ),
      );

      expect(find.byType(RouteImageScreen), findsOneWidget);
    });
  });
}

class MockCacheManager extends Mock implements BaseCacheManager {}
