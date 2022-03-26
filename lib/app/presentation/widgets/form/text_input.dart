import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class FreeBetaTextInput extends StatelessWidget {
  const FreeBetaTextInput({
    Key? key,
    required this.label,
    required this.onChanged,
    required this.controller,
    this.skipValidation = false,
  }) : super(key: key);

  final String label;
  final Function(String?) onChanged;
  final TextEditingController controller;
  final bool skipValidation;

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
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: (value) {
            if (skipValidation) return null;

            if (value == null || value.isEmpty) {
              return '$label is required';
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: FreeBetaColors.red,
                width: 2.0,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: FreeBetaSizes.m,
            ),
            hintStyle: FreeBetaTextStyle.h4.copyWith(
              color: FreeBetaColors.grayLight,
            ),
            hintText: 'Enter ${label.toLowerCase()}',
          ),
          style: FreeBetaTextStyle.h4,
        ),
        SizedBox(height: FreeBetaSizes.l),
      ],
    );
  }
}
