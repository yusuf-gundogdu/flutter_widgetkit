import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSTooltip extends StatelessWidget {
  final String message;
  final Widget child;
  const TSTooltip({super.key, required this.message, required this.child});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return Tooltip(
      message: message,
      textStyle: tsTextStyleForConfig(
        config,
        size: (config.fontSize * 0.9).toDouble(),
        color: Theme.of(context).colorScheme.onPrimary,
        weight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: config.useRoundedCorners
            ? BorderRadius.circular(config.borderRadius.topLeft.x)
            : BorderRadius.zero,
      ),
      child: child,
    );
  }
}


