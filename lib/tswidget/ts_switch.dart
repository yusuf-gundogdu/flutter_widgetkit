import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const TSSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.onPrimary,
      activeTrackColor: Theme.of(context).colorScheme.primary,
    );
  }
}


