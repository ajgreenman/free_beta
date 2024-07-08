import 'package:flutter/material.dart';

class RouteListScrollController {
  RouteListScrollController();

  final ScrollController scrollController = ScrollController();

  void scrollToTop() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }
}
