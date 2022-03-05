import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FreeBetaPadding.mlAll,
      child: Container(
        decoration: BoxDecoration(
          color: FreeBetaColors.white,
          boxShadow: [FreeBetaShadows.fluffy],
          borderRadius: BorderRadius.circular(FreeBetaSizes.ml),
        ),
        child: Padding(
          padding: FreeBetaPadding.mlAll,
          child: child,
        ),
      ),
    );
  }
}
