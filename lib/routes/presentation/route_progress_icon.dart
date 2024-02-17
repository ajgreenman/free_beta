import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class RouteProgressIcon extends StatelessWidget {
  final bool isAttempted;
  final bool isCompleted;

  const RouteProgressIcon({
    Key? key,
    required this.isAttempted,
    required this.isCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FreeBetaPadding.sHorizontal,
      child: _getIcon(),
    );
  }

  Widget _getIcon() {
    if (!isAttempted) {
      return Icon(
        Icons.check_box_outline_blank,
        size: 20.0,
      );
    }

    if (!isCompleted) {
      return Icon(
        Icons.disabled_by_default_outlined,
        size: 20.0,
      );
    }

    return Icon(
      Icons.check_box,
      size: 20.0,
    );
  }
}
