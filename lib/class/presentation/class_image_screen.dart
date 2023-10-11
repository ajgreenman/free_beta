import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/class/presentation/class_image.dart';

class ClassImageScreen extends StatelessWidget {
  static Route<dynamic> route({
    required String imageUrl,
  }) {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return ClassImageScreen(
        imageUrl: imageUrl,
      );
    });
  }

  ClassImageScreen({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height * 0.6;
    return Scaffold(
      backgroundColor: FreeBetaColors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: InteractiveViewer(
          maxScale: 3.0,
          child: Center(
            child: ClassImage(
              height: _height,
              imageUrl: imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}
