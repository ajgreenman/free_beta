import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class FreeBetaBackButton extends StatelessWidget {
  const FreeBetaBackButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
      icon: Icon(
        Icons.keyboard_arrow_left,
        size: FreeBetaSizes.xxl,
        color: FreeBetaColors.white,
      ),
    );
  }
}
