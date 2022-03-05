import 'package:flutter/material.dart';
import 'package:free_beta/app/presentation/widgets/elevate_logo.dart';
import 'package:free_beta/app/presentation/widgets/free_beta_logo.dart';
import 'package:free_beta/app/theme.dart';

class AppLoading extends StatefulWidget {
  const AppLoading({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  State<AppLoading> createState() => _AppLoadingState();
}

class _AppLoadingState extends State<AppLoading> {
  var _offset = Offset.zero;
  double get _hexagonLength => FreeBetaSizes.xxxl * 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                SizedBox.square(
                  dimension: _hexagonLength * 2,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(0.01 * _offset.dy)
                      ..rotateY(-0.01 * _offset.dx),
                    alignment: FractionalOffset.center,
                    child: GestureDetector(
                      onPanUpdate: (details) =>
                          setState(() => _offset += details.delta),
                      onDoubleTap: () => setState(() => _offset = Offset.zero),
                      child: ElevateLogo(sideLength: _hexagonLength),
                    ),
                  ),
                ),
                SizedBox.square(
                  dimension: _hexagonLength * 2,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(0.01 * _offset.dy)
                      ..rotateY(-0.01 * _offset.dx),
                    alignment: FractionalOffset.center,
                    child: GestureDetector(
                      onPanUpdate: (details) =>
                          setState(() => _offset += details.delta),
                      onDoubleTap: () => setState(() => _offset = Offset.zero),
                      child: FreeBetaLogo(sideLength: _hexagonLength),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: _SkipButton(onPressed: widget.onPressed),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FreeBetaPadding.mAll,
      child: TextButton(
        onPressed: onPressed,
        child: Text('Skip'),
      ),
    );
  }
}
