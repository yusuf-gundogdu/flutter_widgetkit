import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  const TSRadio({super.key, required this.value, required this.groupValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return Theme(
      data: Theme.of(context).copyWith(
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primary),
        ),
      ),
      child: Radio<T>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}


