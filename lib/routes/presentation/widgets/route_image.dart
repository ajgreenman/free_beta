import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class RouteImage extends StatelessWidget {
  const RouteImage({
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageUrl,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (_, __) => _LoadingColumn(),
      ),
    );
  }
}

class _LoadingColumn extends StatelessWidget {
  const _LoadingColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: FreeBetaSizes.ml),
        Text(
          'Loading images...',
          style: FreeBetaTextStyle.body3,
        ),
        SizedBox(height: FreeBetaSizes.ml),
      ],
    );
  }
}
