import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class Chalkboard extends StatelessWidget {
  const Chalkboard({
    required this.height,
    required this.child,
  });

  final double height;
  final Widget child;

  double get _frameSize => 12.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: FreeBetaColors.brown,
            width: _frameSize,
          ),
          color: FreeBetaColors.chalkboard,
        ),
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}
