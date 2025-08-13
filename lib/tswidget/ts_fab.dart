import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSFab extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  const TSFab({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return IconTheme(
      data: IconThemeData(size: config.iconSize),
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        child: child,
      ),
    );
  }
}


