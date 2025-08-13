import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSLinearProgress extends StatelessWidget {
  final double? value;
  const TSLinearProgress({super.key, this.value});
  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return LinearProgressIndicator(
      value: value,
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Color.alphaBlend(
        Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
        Theme.of(context).colorScheme.surface,
      ),
    );
  }
}

class TSCircularProgress extends StatelessWidget {
  final double? value;
  final double strokeWidth;
  const TSCircularProgress({super.key, this.value, this.strokeWidth = 4});
  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return CircularProgressIndicator(
      value: value,
      strokeWidth: strokeWidth,
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
    );
  }
}


