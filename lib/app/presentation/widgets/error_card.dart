import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    this.child,
    Key? key,
  }) : super(key: key);
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
          if (child != null) ...[
            SizedBox(height: FreeBetaSizes.m),
            child!,
          ],
        ],
      ),
    );
  }
}
