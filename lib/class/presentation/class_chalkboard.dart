import 'package:flutter/material.dart';
import 'package:free_beta/app/presentation/widgets/chalkboard.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';

import 'widgets/class_row.dart';

class ClassChalkboard extends StatelessWidget {
  const ClassChalkboard({
    super.key,
    required this.height,
    required this.classes,
  });

  final double height;
  final List<ClassModel> classes;

  @override
  Widget build(BuildContext context) {
    if (classes.isEmpty) {
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
