import 'package:flutter/material.dart';
import 'package:free_beta/app/infrastructure/models/wall_section.dart';
import 'package:free_beta/app/theme.dart';

class GymSection extends StatelessWidget {
  const GymSection({
    required this.color,
    required this.wallSection,
    required this.size,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Color color;
  final WallSection wallSection;
  final Size size;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: size,
      child: InkWell(
        onTap: onTap?.call(),
        child: Stack(
          children: [
            ClipPath(
              clipper: _SectionClipper(
                path: _path,
              ),
              child: Container(
                color: color,
              ),
            ),
            CustomPaint(
              painter: _SectionPainter(
                path: _path,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Path get _path {
    var path = Path();
    for (var i = 0; i < wallSection.points.length; i++) {
      if (i == 0) {
        path.moveTo(
          wallSection.points[i].dx * size.width,
          wallSection.points[i].dy * size.height,
        );
      } else {
        path.lineTo(
          wallSection.points[i].dx * size.width,
          wallSection.points[i].dy * size.height,
        );
      }
    }
    path.close();
    return path;
  }
}

class _SectionClipper extends CustomClipper<Path> {
  _SectionClipper({
    required this.path,
  });

  final Path path;

  @override
  Path getClip(Size _) {
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> old) => false;
}

class _SectionPainter extends CustomPainter {
  _SectionPainter({
    required this.path,
  });

  final Path path;

  @override
  void paint(Canvas canvas, Size _) {
    final paint = Paint()
      ..color = FreeBetaColors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = FreeBetaSizes.xxs;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
