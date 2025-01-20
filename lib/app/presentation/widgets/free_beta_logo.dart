import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class FreeBetaLogo extends StatelessWidget {
  const FreeBetaLogo({Key? key}) : super(key: key);

  final _borderRadius = FreeBetaSizes.xxl;

  final _colorOpacity = 127;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: FreeBetaSizes.xs,
          color: FreeBetaColors.black,
        ),
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Column(
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                ),
                color: FreeBetaColors.greenBrand.withAlpha(_colorOpacity),
              ),
            ),
          ),
          Flexible(
            child: Container(
              color: FreeBetaColors.purpleBrand.withAlpha(_colorOpacity),
            ),
          ),
          Flexible(
            child: Container(
              color: FreeBetaColors.blueLight.withAlpha(_colorOpacity),
            ),
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                ),
                color: FreeBetaColors.yellowBrand.withAlpha(_colorOpacity),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
