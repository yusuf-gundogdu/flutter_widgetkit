import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSBadge extends StatelessWidget {
  final Widget child;
  final String label;
  const TSBadge({super.key, required this.child, required this.label});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: -4,
          top: -4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Theme.of(context).colorScheme.surface, width: 2),
            ),
        child: Text(
          label,
          style: tsTextStyleForConfig(
            config,
            size: ((config.fontSize * 0.7).clamp(8.0, 12.0)).toDouble(),
            weight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onTertiary,
          ),
        ),
          ),
        ),
      ],
    );
  }
}


