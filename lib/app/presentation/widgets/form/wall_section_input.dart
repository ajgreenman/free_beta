import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/gym/presentation/widgets/wall_section_map.dart';

class FreeBetaWallSectionInput extends StatelessWidget {
  const FreeBetaWallSectionInput({
    Key? key,
    required this.label,
    required this.wallLocation,
    required this.onChanged,
    this.value,
  }) : super(key: key);

  final String label;
  final WallLocation wallLocation;
  final Function(int?) onChanged;
  final int? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FreeBetaTextStyle.h3,
        ),
        SizedBox(height: FreeBetaSizes.m),
        WallSectionMap(
          wallLocation: wallLocation,
          highlightedSections: value != null ? [value!] : [],
          onPressed: onChanged,
        ),
      ],
    );
  }
}
