import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSChip extends StatelessWidget {
  final Widget label;
  const TSChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return Chip(
      label: DefaultTextStyle.merge(
        style: tsTextStyleForConfig(
          config,
          size: config.fontSize * 0.95,
          weight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        child: label,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
      shape: StadiumBorder(side: BorderSide(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3))),
    );
  }
}


