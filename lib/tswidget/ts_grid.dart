import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSGrid extends StatelessWidget {
  final int? columns;
  final double spacing;
  final List<Widget> children;
  const TSGrid({super.key, this.columns, this.spacing = 12, required this.children});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    final width = MediaQuery.of(context).size.width;
    final int cross = columns ?? (width >= 1200 ? 4 : width >= 800 ? 3 : width >= 600 ? 2 : 1);
    return GridView.count(
      crossAxisCount: cross,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      padding: const EdgeInsets.all(12),
      children: children
          .map((c) => Container(
                decoration: BoxDecoration(
                  color: Color.alphaBlend(
                    config.surfaceTintColor.withValues(alpha: config.surfaceTintStrength),
                    config.backgroundColor,
                  ),
                  borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero,
                  boxShadow: config.useShadows
                      ? [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: config.elevation, offset: Offset(0, config.elevation / 2))]
                      : null,
                  border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12)),
                ),
                child: c,
              ))
          .toList(),
    );
  }
}


