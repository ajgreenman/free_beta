import 'package:flutter/material.dart';
import 'package:free_beta/app/extensions/date_extensions.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';
import 'package:intl/intl.dart';

class ClassRow extends StatelessWidget {
  const ClassRow({
    required this.classModel,
    this.darkMode = true,
  });

  final ClassModel classModel;
  final bool darkMode;

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
                color: darkMode
                    ? classModel.chalkboardColor
                    : FreeBetaColors.black,
              ),
            ),
            Text(
              classModel.instructor,
              style: FreeBetaTextStyle.body4.copyWith(
                color: darkMode ? FreeBetaColors.white : FreeBetaColors.black,
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
            color: darkMode ? FreeBetaColors.white : FreeBetaColors.black,
          ),
        ),
      ],
    );
  }
}
