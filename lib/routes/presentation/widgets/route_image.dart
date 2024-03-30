import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/app_providers.dart';
import 'package:free_beta/app/theme.dart';

class RouteImage extends ConsumerWidget {
  const RouteImage({
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Hero(
      tag: imageUrl,
      child: CachedNetworkImage(
        memCacheHeight: 768,
        memCacheWidth: 576,
        imageUrl: imageUrl,
        placeholder: (_, __) => _LoadingColumn(),
        cacheManager: ref.read(cacheManagerProvider),
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
