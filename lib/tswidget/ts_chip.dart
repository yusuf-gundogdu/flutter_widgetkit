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
        style: TextStyle(
          fontSize: config.fontSize * 0.95,
          fontWeight: FontWeight.w600,
          letterSpacing: config.letterSpacing,
          height: config.lineHeight,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        child: label,
      ),
      backgroundColor: config.primaryColor.withValues(alpha: 0.08),
      shape: StadiumBorder(side: BorderSide(color: config.primaryColor.withValues(alpha: 0.3))),
    );
  }
}


