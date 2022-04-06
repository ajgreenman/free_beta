import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    required this.error,
    required this.stackTrace,
    this.child,
    Key? key,
  }) : super(key: key);

  final Object? error;
  final StackTrace? stackTrace;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: FreeBetaSizes.xxl),
          Text(
            'Sorry, an unknown error occured.',
            style: FreeBetaTextStyle.body3,
          ),
          if (child != null) ..._buildChild(child!),
        ],
      ),
    );
  }

  List<Widget> _buildChild(Widget errorChild) {
    return [
      SizedBox(height: FreeBetaSizes.m),
      errorChild,
    ];
  }
}
