import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSList extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final bool separated;

  const TSList({
    super.key,
    required this.children,
    this.padding,
    this.separated = true,
  });

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    final borderRadius = config.useRoundedCorners ? config.borderRadius : BorderRadius.zero;
    Widget card(Widget child) => Container(
          decoration: BoxDecoration(
            color: Color.alphaBlend(
              config.surfaceTintColor.withValues(alpha: config.surfaceTintStrength),
              Theme.of(context).colorScheme.surface,
            ),
            borderRadius: borderRadius,
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
          child: child,
        );

    if (separated) {
      return DefaultTextStyle.merge(
        style: tsTextStyleForConfig(config, color: Theme.of(context).colorScheme.onSurface),
        child: ListView.separated(
          padding: padding ?? const EdgeInsets.all(12),
          itemCount: children.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) => card(Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), child: children[index])),
        ),
      );
    }

    return DefaultTextStyle.merge(
      style: tsTextStyleForConfig(config, color: Theme.of(context).colorScheme.onSurface),
      child: ListView(
        padding: padding ?? const EdgeInsets.all(12),
        children: children
            .map((w) => Padding(padding: const EdgeInsets.only(bottom: 8), child: card(Padding(padding: const EdgeInsets.all(8), child: w))))
            .toList(),
      ),
    );
  }
}


