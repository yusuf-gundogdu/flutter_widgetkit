import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const TSCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return Container(
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          config.surfaceTintColor.withValues(alpha: config.surfaceTintStrength),
          Theme.of(context).colorScheme.surface,
        ),
        borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero,
        boxShadow: config.useShadows
            ? [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.06),
                  blurRadius: config.elevation,
                  offset: Offset(0, config.elevation / 2),
                )
              ]
            : null,
        border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.15)),
      ),
      child: DefaultTextStyle.merge(
        style: tsTextStyleForConfig(config, color: Theme.of(context).colorScheme.onSurface),
        child: child,
      ),
    );
  }
}


