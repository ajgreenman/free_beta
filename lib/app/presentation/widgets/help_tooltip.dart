import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class HelpTooltip extends StatelessWidget {
  const HelpTooltip({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      triggerMode: TooltipTriggerMode.tap,
      margin: FreeBetaPadding.xxlHorizontal,
      padding: FreeBetaPadding.mAll,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(FreeBetaSizes.m),
        color: FreeBetaColors.black,
      ),
      textStyle: FreeBetaTextStyle.body4.copyWith(
        color: FreeBetaColors.white,
      ),
      showDuration: Duration(seconds: 10),
      child: Icon(
        Icons.help_outlined,
        color: FreeBetaColors.grayDark,
        size: FreeBetaSizes.xl,
      ),
    );
  }
}
