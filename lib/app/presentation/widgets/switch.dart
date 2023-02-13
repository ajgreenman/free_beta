import 'package:flutter/material.dart';
import 'package:free_beta/app/presentation/widgets/elevate_logo.dart';
import 'package:free_beta/app/theme.dart';

class FreeBetaSwitch extends StatelessWidget {
  const FreeBetaSwitch({
    Key? key,
    this.initialValue = false,
    required this.onChanged,
    this.label,
    this.labelStyle = FreeBetaTextStyle.h4,
    this.width = 48.0,
    this.expanded = false,
  }) : super(key: key);

  final String? label;
  final TextStyle labelStyle;
  final void Function(bool) onChanged;
  final bool initialValue;
  final bool expanded;

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: labelStyle,
          ),
          SizedBox(width: FreeBetaSizes.m),
        ],
        _Switch(
          initialValue: initialValue,
          onChanged: onChanged,
          width: width,
        ),
      ],
    );
  }
}

class _Switch extends StatefulWidget {
  const _Switch({
    Key? key,
    required this.initialValue,
    required this.onChanged,
    required this.width,
  }) : super(key: key);

  final bool initialValue;
  final void Function(bool) onChanged;
  final double width;

  @override
  State<_Switch> createState() => _SwitchState();
}

class _SwitchState extends State<_Switch> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, 0.0),
    end: const Offset(0.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeOut,
  ));

  late bool _isActive;

  @override
  void initState() {
    super.initState();

    _isActive = widget.initialValue;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _animationController.value = _isActive ? 1.0 : 0.0;
    _animationController.addStatusListener(_onAnimate);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: SizedBox(
        width: widget.width,
        height: widget.width / 2,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: _Track(
                height: widget.width / 2,
                isActive: _isActive,
              ),
            ),
            SlideTransition(
              position: _offsetAnimation,
              child: ElevateLogo.small(
                sideLength: widget.width / 4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    if (_animationController.isCompleted) {
      setState(() => _isActive = false);
      _animationController.reverse();
    } else {
      setState(() => _isActive = true);
      _animationController.forward();
    }
  }

  void _onAnimate(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      widget.onChanged(_isActive);
      return;
    }
    if (status == AnimationStatus.completed) {
      widget.onChanged(_isActive);
      return;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _Track extends StatelessWidget {
  const _Track({
    Key? key,
    required this.height,
    required this.isActive,
  }) : super(key: key);

  final double height;
  final bool isActive;

  BoxDecoration get _decoration {
    return isActive
        ? BoxDecoration(
            gradient: FreeBetaGradients.highlight,
            borderRadius: BorderRadius.all(Radius.circular(height / 2)),
          )
        : BoxDecoration(
            color: FreeBetaColors.grayLight,
            borderRadius: BorderRadius.all(Radius.circular(height / 2)),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _decoration,
    );
  }
}
