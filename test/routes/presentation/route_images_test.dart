import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/routes/presentation/route_images.dart';
import 'package:free_beta/routes/presentation/widgets/route_image.dart';

void main() {
  group('RouteImages', () {
    testWidgets('smoke test', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RouteImages(
            images: [''],
          ),
        ),
      );

      expect(find.text('No available images'), findsNothing);
      expect(find.byType(CarouselSlider), findsOneWidget);
      expect(find.byType(RouteImage), findsOneWidget);
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
