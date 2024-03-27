import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class FreeBetaCheckbox extends StatelessWidget {
  const FreeBetaCheckbox({
    Key? key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final bool value;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Row(
        children: [
          Text(
            label,
            style: FreeBetaTextStyle.body3,
          ),
          Spacer(),
          SizedBox.square(
            dimension: FreeBetaSizes.xxl,
            child: Checkbox(
              activeColor: FreeBetaColors.blueDark,
              value: value,
              onChanged: (_) => onTap(),
            ),
          ),
        ],
      ),
    );
  }
}
