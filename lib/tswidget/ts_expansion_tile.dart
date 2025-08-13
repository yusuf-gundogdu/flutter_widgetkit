import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSExpansionTile extends StatelessWidget {
  final Widget title;
  final List<Widget> children;
  final Widget? leading;
  final bool initiallyExpanded;

  const TSExpansionTile({
    super.key,
    required this.title,
    this.children = const [],
    this.leading,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero,
        boxShadow: config.useShadows
            ? [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: config.elevation, offset: Offset(0, config.elevation / 2))]
            : null,
        border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          leading: leading,
          iconColor: Theme.of(context).colorScheme.primary,
          collapsedIconColor: Theme.of(context).colorScheme.primary,
          title: DefaultTextStyle.merge(
            style: tsTextStyleForConfig(
              config,
              weight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            child: title,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: DefaultTextStyle.merge(
                style: tsTextStyleForConfig(config, color: Theme.of(context).colorScheme.onSurface),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  for (final w in children) ...[w, const SizedBox(height: 8)],
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


