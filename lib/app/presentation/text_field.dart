import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class FreeBetaTextField extends StatelessWidget {
  const FreeBetaTextField(
      {Key? key,
      this.initialValue,
      this.hintText,
      this.validator,
      this.onChanged,
      this.controller})
      : super(key: key);

  final String? initialValue;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: 600,
      maxLines: 6,
      style: FreeBetaTextStyle.body5,
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: FreeBetaPadding.mlAll,
        hintText: hintText,
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
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FreeBetaColors.red,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
