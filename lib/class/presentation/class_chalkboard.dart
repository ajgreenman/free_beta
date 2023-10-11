import 'package:flutter/material.dart';
import 'package:free_beta/app/presentation/widgets/chalkboard.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';
import 'package:free_beta/class/presentation/class_image.dart';
import 'package:free_beta/class/presentation/class_image_screen.dart';

import 'widgets/class_row.dart';

class ClassChalkboard extends StatelessWidget {
  const ClassChalkboard({
    super.key,
    required this.height,
    required this.classes,
    required this.imageUrl,
  });

  final double height;
  final List<ClassModel> classes;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return _ImageChalkboard(
        height: height,
        imageUrl: imageUrl!,
      );
    }

    if (classes.isEmpty) {
      return _EmptyChalkboard(height: height);
    }

    return Chalkboard(
      height: height,
      child: Padding(
        padding: FreeBetaPadding.lAll,
        child: Column(
          children: classes
              .map((classModel) => ClassRow(classModel: classModel))
              .toList(),
        ),
      ),
    );
  }
}

class _ImageChalkboard extends StatelessWidget {
  const _ImageChalkboard({
    required this.height,
    required this.imageUrl,
  });

  final double height;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Chalkboard(
      height: height,
      child: Center(
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
            ClassImageScreen.route(imageUrl: imageUrl),
          ),
          child: ClassImage(
            height: height - (2 * Chalkboard.frameSize),
            imageUrl: imageUrl,
          ),
        ),
      ),
    );
  }
}

class _EmptyChalkboard extends StatelessWidget {
  const _EmptyChalkboard({
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Chalkboard(
      height: height,
      child: Center(
        child: Padding(
          padding: FreeBetaPadding.lVertical,
          child: Text(
            "No classes scheduled",
            style: FreeBetaTextStyle.body3.copyWith(
              color: FreeBetaColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
