import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class RouteImage extends StatelessWidget {
  const RouteImage({
    required this.tag,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  final String tag;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'imageHero',
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (_, __) => _buildImageLoader(),
      ),
    );
  }

  Widget _buildImageLoader() => Column(
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
