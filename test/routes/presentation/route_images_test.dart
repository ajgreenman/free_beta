import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/routes/presentation/route_image_screen.dart';
import 'package:free_beta/routes/presentation/route_images.dart';
import 'package:free_beta/routes/presentation/widgets/route_image.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockCacheManager mockCacheManager;

  setUp(() {
    mockCacheManager = MockCacheManager();
  });

  Widget buildFrame() {
    return ProviderScope(
      overrides: [
        cacheManagerProvider.overrideWith((_) => mockCacheManager),
      ],
      child: MaterialApp(
        home: RouteImages(
          images: [''],
        ),
      ),
    );
  }

  group('RouteImages', () {
    testWidgets('smoke test', (tester) async {
      await tester.pumpWidget(buildFrame());

      expect(find.text('No available images'), findsNothing);
      expect(find.byType(CarouselSlider), findsOneWidget);
      expect(find.byType(RouteImage), findsOneWidget);
    });
    testWidgets('tapping on an image takes you to the detail screens',
        (tester) async {
      await tester.pumpWidget(buildFrame());

      var routeImage = find.byType(RouteImage);
      expect(routeImage, findsOneWidget);

      await tester.ensureVisible(routeImage);
      await tester.pumpAndSettle();

      await tester.tap(routeImage);
      await tester.pumpAndSettle();

      expect(find.byType(RouteImageScreen), findsOneWidget);
    });

    testWidgets('empty list returns message', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RouteImages(
            images: [],
          ),
        ),
      );

      expect(find.text('No available images'), findsOneWidget);
      expect(find.byType(CarouselSlider), findsNothing);
      expect(find.byType(RouteImage), findsNothing);
    });
  });
}

class MockCacheManager extends Mock implements BaseCacheManager {}
