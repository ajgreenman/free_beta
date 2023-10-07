import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class FreeBetaTimeInput extends StatelessWidget {
  const FreeBetaTimeInput({
    Key? key,
    required this.label,
    required this.onChanged,
    this.value,
  }) : super(key: key);

  final String label;
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
      ],
    );
  }
}
