import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class ColorSquare extends StatelessWidget {
  const ColorSquare({
    required this.color,
    this.size = FreeBetaSizes.l,
    Key? key,
  }) : super(key: key);

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(),
          color: color,
        ),
      ),
    );
  }
}
