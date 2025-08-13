import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  const TSCheckbox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: config.primaryColor,
      side: BorderSide(color: config.primaryColor.withValues(alpha: 0.6)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }
}


