import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  const TSDropdown({super.key, this.value, required this.items, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      style: tsTextStyleForConfig(config),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero),
        focusedBorder: OutlineInputBorder(
          borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero,
          borderSide: BorderSide(color: config.primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      dropdownColor: Theme.of(context).colorScheme.surface,
      borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero,
      iconEnabledColor: config.primaryColor,
    );
  }
}


