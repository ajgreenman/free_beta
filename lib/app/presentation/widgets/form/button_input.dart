import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class FreeBetaButtonInput extends StatelessWidget {
  const FreeBetaButtonInput({
    Key? key,
    required this.label,
    required this.hintText,
    required this.onTap,
    required this.controller,
    this.isImageField = false,
  }) : super(key: key);

  final String label;
  final String hintText;
  final Function() onTap;
  final TextEditingController controller;
  final bool isImageField;

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
          onTap: onTap,
          validator: (value) {
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
            hintText: hintText,
          ),
          style: FreeBetaTextStyle.h4,
        ),
        SizedBox(height: FreeBetaSizes.l),
      ],
    );
  }
}
