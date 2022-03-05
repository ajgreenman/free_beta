import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class FreeBetaLogo extends StatelessWidget {
  const FreeBetaLogo({Key? key, required this.sideLength}) : super(key: key);

  final double sideLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: FreeBetaSizes.xs,
          color: FreeBetaColors.black,
        ),
      ),
      height: sideLength,
      width: sideLength,
      child: Column(
        children: [
          Flexible(
            child: Container(
              color: FreeBetaColors.greenBrand,
            ),
          ),
        ],
      ),
    );
  }
}
