import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class ElevateLogo extends StatelessWidget {
  const ElevateLogo({Key? key, required this.sideLength}) : super(key: key);

  final double sideLength;

  // Length from center to midpoint of any side...google it
  double get _apothem => (sideLength * sqrt(3) / 2);

  Offset get _leftCorner => Offset(0.0, sideLength);
  Offset get _topLeftCorner => Offset(sideLength / 2, sideLength - _apothem);
  Offset get _topRightCorner =>
      Offset(sideLength / 2 + sideLength, sideLength - _apothem);
  Offset get _rightCorner => Offset(sideLength * 2, sideLength);
  Offset get _bottomRightCorner =>
      Offset(sideLength / 2 + sideLength, sideLength + _apothem);
  Offset get _bottomLeftCorner => Offset(sideLength / 2, sideLength + _apothem);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: _LogoClipper(
            [
              _bottomLeftCorner,
              _leftCorner,
              _topLeftCorner,
              _topRightCorner,
            ],
          ),
          child: Container(
            color: FreeBetaColors.greenBrand,
          ),
        ),
        ClipPath(
          clipper: _LogoClipper(
            [
              _bottomLeftCorner,
              _topRightCorner,
              _rightCorner,
            ],
          ),
          child: Container(
            color: FreeBetaColors.purpleBrand,
          ),
        ),
        ClipPath(
          clipper: _LogoClipper(
            [
              _bottomLeftCorner,
              _rightCorner,
              _bottomRightCorner,
            ],
          ),
          child: Container(
            color: FreeBetaColors.yellowBrand,
          ),
        ),
        CustomPaint(
          painter: _LogoPainter([
            _bottomLeftCorner,
            _topRightCorner,
          ]),
        ),
        CustomPaint(
          painter: _LogoPainter([
            _bottomLeftCorner,
            _rightCorner,
          ]),
        ),
        CustomPaint(
          painter: _LogoPainter([
            _leftCorner,
            _topLeftCorner,
            _topRightCorner,
            _rightCorner,
            _bottomRightCorner,
            _bottomLeftCorner,
            _leftCorner
          ]),
        ),
      ],
    );
  }
}

class _LogoClipper extends CustomClipper<Path> {
  _LogoClipper(this.points);

  final List<Offset> points;

  @override
  Path getClip(Size _) {
    var path = Path();
    for (var i = 0; i < points.length; i++) {
      if (i == 0) {
        path.moveTo(points[i].dx, points[i].dy);
      } else {
        path.lineTo(points[i].dx, points[i].dy);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> old) => old != this;
}

class _LogoPainter extends CustomPainter {
  _LogoPainter(this.points);

  final List<Offset> points;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = FreeBetaSizes.xs
      ..strokeCap = StrokeCap.butt;

    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => old != this;
}
