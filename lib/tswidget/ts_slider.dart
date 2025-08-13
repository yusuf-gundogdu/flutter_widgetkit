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
    return Theme(
      data: Theme.of(context).copyWith(
        sliderTheme: SliderThemeData(
          activeTrackColor: Theme.of(context).colorScheme.primary,
          inactiveTrackColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
          thumbColor: Theme.of(context).colorScheme.primary,
          overlayColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Slider(
        value: value,
        onChanged: onChanged,
        min: min,
        max: max,
      ),
    );
  }
}


