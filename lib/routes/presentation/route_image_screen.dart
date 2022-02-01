import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/presentation/widgets/route_image.dart';

class RouteImageScreen extends StatelessWidget {
  static Route<dynamic> route(
    String tag,
    String imageUrl,
  ) {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return RouteImageScreen(
        tag: tag,
        imageUrl: imageUrl,
      );
    });
  }

  const RouteImageScreen({
    required this.tag,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  final String tag;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FreeBetaColors.black,
      body: GestureDetector(
        child: Center(
          child: RouteImage(
            tag: tag,
            imageUrl: imageUrl,
          ),
        ),
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }
}
