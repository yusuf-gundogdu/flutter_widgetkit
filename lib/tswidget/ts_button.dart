import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool filled;
  const TSButton({super.key, required this.child, this.onPressed, this.filled = true});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    final shape = RoundedRectangleBorder(borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero);
    final textStyle = tsTextStyleForConfig(config);
    if (filled) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: shape,
        ),
        child: IconTheme(
          data: IconThemeData(size: config.iconSize),
          child: DefaultTextStyle.merge(style: textStyle, child: child),
        ),
      );
    }
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        side: BorderSide(color: Theme.of(context).colorScheme.primary),
        shape: shape,
      ),
      child: IconTheme(
        data: IconThemeData(size: config.iconSize),
        child: DefaultTextStyle.merge(style: textStyle, child: child),
      ),
    );
  }
}


