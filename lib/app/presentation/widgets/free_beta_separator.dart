import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class FreeBetaSeparator extends StatelessWidget {
  const FreeBetaSeparator({
    Key? key,
    this.textStyle = FreeBetaTextStyle.body2,
  }) : super(key: key);

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FreeBetaPadding.sHorizontal,
      child: Text(
        '|',
        style: textStyle.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
