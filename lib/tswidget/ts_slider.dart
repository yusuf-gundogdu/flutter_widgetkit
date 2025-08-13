import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  const TSSlider({super.key, required this.value, required this.onChanged, this.min = 0, this.max = 1});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return Slider(
      value: value,
      onChanged: onChanged,
      min: min,
      max: max,
      activeColor: config.primaryColor,
      inactiveColor: config.primaryColor.withValues(alpha: 0.3),
    );
  }
}


