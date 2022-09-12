import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';

class FreeBetaNumberInput extends StatelessWidget {
  const FreeBetaNumberInput({
    Key? key,
    this.value = 0,
    this.minValue = 0,
    this.maxValue = 99,
    this.iconColor = FreeBetaColors.black,
    required this.onChanged,
  }) : super(key: key);

  final int value;
  final int minValue;
  final int maxValue;
  final Color iconColor;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          key: Key('FreeBetaNumberInput-subtract'),
          onPressed: () {
            if (value > minValue) {
              onChanged(value - 1);
            }
          },
          icon: Icon(
            Icons.remove,
            color: iconColor,
            size: FreeBetaSizes.xxl,
          ),
        ),
        Text(
          value == maxValue ? '$value+' : '$value',
          style: FreeBetaTextStyle.body2.copyWith(fontWeight: FontWeight.bold),
        ),
        IconButton(
          key: Key('FreeBetaNumberInput-add'),
          onPressed: () {
            if (value < maxValue) {
              onChanged(value + 1);
            }
          },
          icon: Icon(
            Icons.add,
            color: iconColor,
            size: FreeBetaSizes.xxl,
          ),
        ),
      ],
    );
  }
}
