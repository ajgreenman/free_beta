import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/presentation/widgets/route_image.dart';

class RouteImageScreen extends StatefulWidget {
  static Route<dynamic> route({
    required List<String> images,
    required int initialIndex,
    required Function() onSwipeLeft,
    required Function() onSwipeRight,
  }) {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return RouteImageScreen(
        images: images,
        initialIndex: initialIndex,
        onSwipeLeft: onSwipeLeft,
        onSwipeRight: onSwipeRight,
      );
    });
  }

  RouteImageScreen({
    required this.images,
    required this.initialIndex,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    Key? key,
  }) : super(key: key);

  final List<String> images;
  final Function() onSwipeLeft;
  final Function() onSwipeRight;
  final int initialIndex;

  @override
  State<RouteImageScreen> createState() => _RouteImageScreenState();
}

class _RouteImageScreenState extends State<RouteImageScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FreeBetaColors.black,
      body: GestureDetector(
        child: Center(
          child: RouteImage(
            imageUrl: widget.images[_currentIndex],
          ),
        ),
        onTap: () => Navigator.of(context).pop(),
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity == null) return;

          if (details.primaryVelocity! > 0) {
            if (_currentIndex <= 0) return;
            setState(() {
              _currentIndex--;
            });
            widget.onSwipeLeft();
          } else if (details.primaryVelocity! < 0) {
            if (_currentIndex >= widget.images.length - 1) return;
            setState(() {
              _currentIndex++;
            });
            widget.onSwipeRight();
          }
        },
      ),
    );
  }
}
