import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  const TSTextField({super.key, this.hint, this.controller});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    final radius = config.useRoundedCorners ? config.borderRadius : BorderRadius.zero;
    return TextField(
      controller: controller,
      style: tsTextStyleForConfig(
        config,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: tsTextStyleForConfig(
          config,
          size: config.fontSize * 0.95,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        border: OutlineInputBorder(borderRadius: radius),
        focusedBorder: OutlineInputBorder(borderRadius: radius, borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)),
      ),
    );
  }
}


