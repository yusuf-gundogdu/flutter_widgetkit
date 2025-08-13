import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;
  const TSAlertDialog({super.key, required this.title, required this.content, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return AlertDialog(
      backgroundColor: Color.alphaBlend(
        config.surfaceTintColor.withValues(alpha: config.surfaceTintStrength),
        Theme.of(context).colorScheme.surface,
      ),
      shape: RoundedRectangleBorder(borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero),
      title: Text(
        title,
        style: tsTextStyleForConfig(
          config,
          weight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      content: Text(
        content,
        style: tsTextStyleForConfig(
          config,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      actions: actions,
    );
  }
}


