import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:free_beta/app/extensions/extensions.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          classModel.name,
          style: FreeBetaTextStyle.body2.copyWith(
            color: darkMode ? classModel.chalkboardColor : FreeBetaColors.black,
          ),
          maxLines: 1,
          minFontSize: 10,
        ),
        Row(
          children: [
            Text(
              classModel.instructor,
              style: FreeBetaTextStyle.body4.copyWith(
                color: darkMode ? FreeBetaColors.white : FreeBetaColors.black,
              ),
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
        ),
        if (!classModel.notes.isNullOrEmpty)
          AutoSizeText(
            classModel.notes!,
            style: FreeBetaTextStyle.body5.copyWith(
              color: darkMode ? FreeBetaColors.white : FreeBetaColors.black,
              fontStyle: FontStyle.italic,
            ),
            maxLines: 2,
            minFontSize: 10,
          ),
        SizedBox(height: FreeBetaSizes.s),
      ],
    );
  }
}
