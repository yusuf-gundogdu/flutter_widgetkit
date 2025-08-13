import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  const TSCheckbox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return Theme(
      data: Theme.of(context).copyWith(
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: config.useRoundedCorners ? BorderRadius.circular(4) : BorderRadius.zero,
          ),
          side: BorderSide(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6)),
          fillColor: WidgetStateProperty.resolveWith(
            (states) => Theme.of(context).colorScheme.primary,
          ),
          checkColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      child: Checkbox(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}


