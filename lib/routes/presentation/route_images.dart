import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class RouteImages extends StatefulWidget {
  const RouteImages({Key? key, required this.images}) : super(key: key);

  final List<String> images;

  @override
  _RouteImagesState createState() => _RouteImagesState();
}

class _RouteImagesState extends State<RouteImages> {
  var _currentImage = 0;
  final _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) return Text('No available images');

    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          items: widget.images
              .map(
                (image) => Container(
                  child: ClipRRect(
                    child: Image.network(
                      image,
                    ),
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: 256,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImage = index;
              });
            },
          ),
        ),
        _buildImageDots(),
      ],
    );
  }

  Widget _buildImageDots() {
    if (widget.images.length <= 1) return SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.images.asMap().entries.map((entry) {
        return Container(
          width: FreeBetaSizes.m,
          height: FreeBetaSizes.m,
          margin: EdgeInsets.symmetric(
            vertical: FreeBetaSizes.m,
            horizontal: FreeBetaSizes.s,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentImage == entry.key
                ? FreeBetaColors.black
                : FreeBetaColors.gray,
          ),
        );
      }).toList(),
    );
  }
}
