import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSBadge extends StatelessWidget {
  final Widget child;
  final String label;
  final double? badgeDiameter;
  final double? offsetRight;
  final double? offsetTop;

  const TSBadge({
    super.key,
    required this.child,
    required this.label,
    this.badgeDiameter,
    this.offsetRight,
    this.offsetTop,
  });

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    final double diameter = badgeDiameter ?? 24;
    final double right = offsetRight ?? -10;
    final double top = offsetTop ?? -10;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: right,
          top: top,
          child: Container(
            width: diameter,
            height: diameter,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).colorScheme.surface, width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: tsTextStyleForConfig(
                config,
                size: badgeDiameter != null
                    ? ((diameter * 0.52).clamp(10.0, 16.0)).toDouble()
                    : ((config.fontSize * 0.9).clamp(11.0, 13.0)).toDouble(),
                weight: FontWeight.w900,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


