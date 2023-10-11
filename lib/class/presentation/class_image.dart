import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class ClassImage extends StatelessWidget {
  const ClassImage({
    required this.height,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  final double height;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      alignment: Alignment.centerLeft,
      height: height,
      imageUrl: imageUrl,
      fit: BoxFit.fitHeight,
      placeholder: (_, __) => Center(
        child: CircularProgressIndicator(color: FreeBetaColors.white),
      ),
    );
  }
}
