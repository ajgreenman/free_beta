import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class FreeBetaDots extends StatelessWidget {
  const FreeBetaDots({
    Key? key,
    required this.current,
    required this.length,
  })  : withColors = false,
        super(key: key);

  const FreeBetaDots.withColors({
    Key? key,
    required this.current,
    required this.length,
  })  : withColors = true,
        super(key: key);

  final int current;
  final int length;
  final bool withColors;

  Color get _dotColor {
    if (current % 3 == 0) {
      return FreeBetaColors.greenBrand;
    }
    if (current % 3 == 1) {
      return FreeBetaColors.purpleBrand;
    }
    return FreeBetaColors.yellowBrand;
  }

  @override
  Widget build(BuildContext context) {
    if (length <= 1) return SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => Container(
          width: FreeBetaSizes.m,
          height: FreeBetaSizes.m,
          margin: EdgeInsets.symmetric(
            vertical: FreeBetaSizes.m,
            horizontal: FreeBetaSizes.s,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == current
                ? withColors
                    ? _dotColor
                    : FreeBetaColors.black
                : FreeBetaColors.gray,
          ),
        ),
      ),
    );
  }
}
