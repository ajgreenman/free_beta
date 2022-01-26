import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class FreeBetaTextField extends StatelessWidget {
  const FreeBetaTextField({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  final String? initialValue;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 600,
      maxLines: 6,
      style: FreeBetaTextStyle.body5,
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: FreeBetaPadding.mlAll,
        hintText: 'Enter notes here:\n\nex. flag your left foot',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
