import 'dart:math';

import 'package:flutter/material.dart';
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
    return AnimatedStaggeredLogo(controller: _animationController);
  }
}

class AnimatedStaggeredLogo extends StatelessWidget {
  AnimatedStaggeredLogo({
    Key? key,
    required this.controller,
  })  : elevateOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(_opacityBegin, _opacityEnd, curve: Curves.linear),
          ),
        ),
        elevateSpeed = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(.15, _opacityEnd, curve: Curves.easeInCubic),
          ),
        ),
        freeBetaSpeed = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(_opacityBegin, .85, curve: Curves.easeOutCubic),
          ),
        ),
        freeBetaFirstOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(_opacityBegin, _opacityEnd, curve: Curves.linear),
          ),
        ),
        freeBetaSecondOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(.92, 1.0, curve: Curves.linear),
          ),
        ),
        freeBetaWidth = Tween<double>(begin: 1.0, end: 2.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.92, 1.0, curve: Curves.easeOutCubic),
          ),
        ),
        freeBetaHeight = Tween<double>(begin: 1.0, end: 4.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.92, 1.0, curve: Curves.easeOutCubic),
          ),
        ),
        nameOffset = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.72, 0.81, curve: Curves.easeIn),
          ),
        );

  static const double _opacityBegin = .47;
  static const double _opacityEnd = .53;

  final AnimationController controller;
  final Animation<double> elevateOpacity;
  final Animation<double> freeBetaFirstOpacity;
  final Animation<double> freeBetaSecondOpacity;
  final Animation<double> elevateSpeed;
  final Animation<double> freeBetaSpeed;
  final Animation<double> freeBetaWidth;
  final Animation<double> freeBetaHeight;
  final Animation<double> nameOffset;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => _StaggeredLogo(
        elevateOpacity: elevateOpacity,
        elevateSpeed: elevateSpeed,
        freeBetaFirstOpacity: freeBetaFirstOpacity,
        freeBetaSecondOpacity: freeBetaSecondOpacity,
        freeBetaWidth: freeBetaWidth,
        freeBetaHeight: freeBetaHeight,
        freeBetaSpeed: freeBetaSpeed,
        nameOffset: nameOffset,
      ),
    );
  }
}

class _StaggeredLogo extends StatelessWidget {
  const _StaggeredLogo({
    Key? key,
    required this.elevateOpacity,
    required this.elevateSpeed,
    required this.freeBetaFirstOpacity,
    required this.freeBetaSecondOpacity,
    required this.freeBetaWidth,
    required this.freeBetaHeight,
    required this.freeBetaSpeed,
    required this.nameOffset,
  }) : super(key: key);

  final Animation<double> elevateOpacity;
  final Animation<double> elevateSpeed;
  final Animation<double> freeBetaFirstOpacity;
  final Animation<double> freeBetaSecondOpacity;
  final Animation<double> freeBetaWidth;
  final Animation<double> freeBetaHeight;
  final Animation<double> freeBetaSpeed;
  final Animation<double> nameOffset;

  double get _hexagonLength => FreeBetaSizes.xxxl * 2;
  double get _squareLength => (_hexagonLength * sqrt(3) / 2) * 2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        FadeTransition(
          opacity: elevateOpacity,
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
        FadeTransition(
          opacity: freeBetaFirstOpacity,
          child: FadeTransition(
            opacity: freeBetaSecondOpacity,
            child: SizedBox(
              width: _squareLength * freeBetaWidth.value,
              height: _squareLength * freeBetaHeight.value,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(freeBetaSpeed.value * 50),
                alignment: FractionalOffset.center,
                child: FreeBetaLogo(),
              ),
            ),
          ),
        ),
        FadeTransition(
          opacity: freeBetaSecondOpacity,
          child: Transform(
            transform: Matrix4.identity()
              ..translate(0.0, (nameOffset.value * 1000) - 1000),
            child: Text(
              'CLIMB\nELEV8',
              maxLines: 2,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: FreeBetaPadding.xxlVertical,
            child: Text(
              'Tap anywhere to skip...',
              style: FreeBetaTextStyle.body4,
            ),
          ),
        ),
      ],
    );
  }
}
