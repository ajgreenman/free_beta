import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class FreeBetaSubmitButton extends StatelessWidget {
  const FreeBetaSubmitButton({
    super.key,
    required this.onSubmit,
    required this.isAdd,
    required this.isFormComplete,
  });

  final bool isFormComplete;
  final bool isAdd;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isFormComplete ? onSubmit : null,
      child: Padding(
        padding: FreeBetaPadding.xlHorizontal,
        child: Text(
          isAdd ? 'Add' : 'Update',
          style: FreeBetaTextStyle.h4.copyWith(
            color: FreeBetaColors.white,
          ),
        ),
      ),
      style: ButtonStyle(
        alignment: Alignment.centerLeft,
        side: WidgetStateProperty.resolveWith<BorderSide>((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(
              color: FreeBetaColors.grayLight,
              width: 2,
            );
          }
          return BorderSide(
            width: 2,
          );
        }),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: FreeBetaSizes.m,
            vertical: FreeBetaSizes.ml,
          ),
        ),
      ),
    );
  }
}
