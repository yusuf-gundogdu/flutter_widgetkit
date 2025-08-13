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
      shape: RoundedRectangleBorder(borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      content: Text(content),
      actions: actions,
    );
  }
}


