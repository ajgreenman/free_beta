import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/presentation/route_image_screen.dart';
import 'package:free_beta/routes/presentation/widgets/route_image.dart';

class RouteImages extends StatefulWidget {
  const RouteImages({Key? key, required this.images}) : super(key: key);

  final List<String> images;

  @override
  _RouteImagesState createState() => _RouteImagesState();
}

class _RouteImagesState extends State<RouteImages> {
  var _currentImage = 0;
  final _carouselController = CarouselController();
  final _imageHeight = 256.0;

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) return Text('No available images');

    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          items: [
            for (var image in widget.images)
              _CachedImage(
                imageUrl: image,
                images: widget.images,
                currentImage: _currentImage,
                imageHeight: _imageHeight,
                onSwipeLeft: _onSwipeLeft,
                onSwipeRight: _onSwipeRight,
              ),
          ],
          options: CarouselOptions(
            height: _imageHeight,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImage = index;
              });
            },
          ),
        ),
        _ImageDots(
          currentImage: _currentImage,
          numberOfImages: widget.images.length,
        ),
      ],
    );
  }

  void _onSwipeLeft() {
    if (_currentImage <= 0) return;
    _carouselController.previousPage();
    setState(() {
      _currentImage--;
    });
  }

  void _onSwipeRight() {
    if (_currentImage >= widget.images.length - 1) return;
    _carouselController.nextPage();
    setState(() {
      _currentImage++;
    });
  }
}

class _CachedImage extends StatelessWidget {
  const _CachedImage({
    Key? key,
    required this.imageUrl,
    required this.images,
    required this.currentImage,
    required this.imageHeight,
    required this.onSwipeLeft,
    required this.onSwipeRight,
  }) : super(key: key);

  final String imageUrl;
  final List<String> images;
  final int currentImage;
  final double imageHeight;
  final void Function() onSwipeLeft;
  final void Function() onSwipeRight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: RouteImage(
        imageUrl: imageUrl,
      ),
      onTap: () => Navigator.of(context).push(
        RouteImageScreen.route(
          images: images,
          initialIndex: currentImage,
          onSwipeLeft: onSwipeLeft,
          onSwipeRight: onSwipeRight,
        ),
      ),
    );
  }
}

class _ImageDots extends StatelessWidget {
  const _ImageDots({
    Key? key,
    required this.currentImage,
    required this.numberOfImages,
  }) : super(key: key);

  final int currentImage;
  final int numberOfImages;

  @override
  Widget build(BuildContext context) {
    if (numberOfImages <= 1) return SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        numberOfImages,
        (index) => Container(
          width: FreeBetaSizes.m,
          height: FreeBetaSizes.m,
          margin: EdgeInsets.symmetric(
            vertical: FreeBetaSizes.m,
            horizontal: FreeBetaSizes.s,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentImage
                ? FreeBetaColors.black
                : FreeBetaColors.gray,
          ),
        ),
      ),
    );
  }
}
