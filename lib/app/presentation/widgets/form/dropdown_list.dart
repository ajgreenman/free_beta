import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class FreeBetaDropdownList<T> extends StatelessWidget {
  const FreeBetaDropdownList({
    Key? key,
    required this.label,
    required this.onChanged,
    required this.items,
    this.initialValue,
  }) : super(key: key);

  final String label;
  final void Function(T?) onChanged;
  final List<DropdownMenuItem<T?>> items;
  final T? initialValue;

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
        DropdownButtonFormField<T?>(
          decoration: InputDecoration(
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
            contentPadding: FreeBetaPadding.mAll,
            hintStyle: FreeBetaTextStyle.h4.copyWith(
              color: FreeBetaColors.grayLight,
            ),
            hintText: 'Enter ${label.toLowerCase()}',
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: FreeBetaSizes.xxl,
            color: FreeBetaColors.blueDark,
          ),
          items: items,
          onChanged: onChanged,
          validator: (value) {
            if (value == null) {
              return '$label is required';
            }
          },
          style: FreeBetaTextStyle.h4,
          value: initialValue,
        ),
        SizedBox(height: FreeBetaSizes.l),
      ],
    );
  }
}
