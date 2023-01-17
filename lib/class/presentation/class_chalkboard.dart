import 'package:flutter/material.dart';
import 'package:free_beta/app/extensions/date_extensions.dart';
import 'package:free_beta/app/presentation/widgets/chalkboard.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';
import 'package:intl/intl.dart';

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
              .map((classModel) => _ClassRow(classModel: classModel))
              .toList(),
        ),
      ),
    );
  }
}

class _ClassRow extends StatelessWidget {
  const _ClassRow({
    required this.classModel,
  });

  final ClassModel classModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              classModel.name,
              style: FreeBetaTextStyle.body2.copyWith(
                color: classModel.chalkboardColor,
              ),
            ),
            Text(
              classModel.instructor,
              style: FreeBetaTextStyle.body4.copyWith(
                color: FreeBetaColors.white,
              ),
            ),
          ],
        ),
        Spacer(),
        Text(
          DateFormat('h:mm a').formatWithNull(
            DateTime.now().copyWith(
              hour: classModel.hour,
              minute: classModel.minute,
            ),
          ),
          style: FreeBetaTextStyle.body3.copyWith(
            color: FreeBetaColors.white,
          ),
        ),
      ],
    );
  }
}
