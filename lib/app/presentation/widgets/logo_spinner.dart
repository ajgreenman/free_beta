import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_beta/app/presentation/widgets/elevate_logo.dart';
import 'package:free_beta/app/presentation/widgets/free_beta_logo.dart';
import 'package:free_beta/app/theme.dart';

class LogoSpinner extends StatefulWidget {
  const LogoSpinner({
    Key? key,
    required this.onComplete,
  }) : super(key: key);

  final VoidCallback onComplete;

  @override
  State<LogoSpinner> createState() => _LogoSpinnerState();
}

class _LogoSpinnerState extends State<LogoSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _animationController.addStatusListener(_onComplete);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_onComplete);
    _animationController.dispose();
    super.dispose();
  }

  void _onComplete(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredLogo(controller: _animationController);
  }
}

class StaggeredLogo extends StatelessWidget {
  StaggeredLogo({
    Key? key,
    required this.controller,
  })  : opacity = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              _opacityBegin,
              _opacityEnd,
              curve: Curves.linear,
            ),
          ),
        ),
        elevateSpeed = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(.1, _opacityEnd, curve: Curves.easeInCubic),
          ),
        ),
        freeBetaSpeed = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(_opacityBegin, .9, curve: Curves.easeOutCubic),
          ),
        ),
        nameOffset = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.77, 0.87, curve: Curves.easeIn),
          ),
        );

  static const double _opacityBegin = .45;
  static const double _opacityEnd = .55;

  final AnimationController controller;
  final Animation<double> opacity;
  final Animation<double> elevateSpeed;
  final Animation<double> freeBetaSpeed;
  final Animation<double> nameOffset;

  double get _hexagonLength => FreeBetaSizes.xxxl * 2;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: opacity.value,
          child: SizedBox.square(
            dimension: _hexagonLength * 2,
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(elevateSpeed.value * -50),
              alignment: FractionalOffset.center,
              child: ElevateLogo(sideLength: _hexagonLength),
            ),
          ),
        ),
        Opacity(
          opacity: 1.0 - opacity.value,
          child: SizedBox.square(
            dimension: (_hexagonLength * sqrt(3) / 2) * 2,
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(freeBetaSpeed.value * 50),
              alignment: FractionalOffset.center,
              child: FreeBetaLogo(),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(0.0, (nameOffset.value * 1000) - 1000),
          child: Text(
            'FREE BETA',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
