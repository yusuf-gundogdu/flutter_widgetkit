import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool decorated;
  const TSListTile({super.key, this.leading, this.title, this.subtitle, this.trailing, this.onTap, this.decorated = true});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    final listTile = ListTile(
      onTap: onTap,
      leading: leading == null
          ? null
          : IconTheme(data: IconThemeData(size: config.iconSize), child: leading!),
      title: DefaultTextStyle.merge(
        style: tsTextStyleForConfig(config, color: Theme.of(context).colorScheme.onSurface),
        child: title ?? const SizedBox.shrink(),
      ),
      subtitle: DefaultTextStyle.merge(
        style: tsTextStyleForConfig(config, size: config.fontSize * 0.9, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8)),
        child: subtitle ?? const SizedBox.shrink(),
      ),
      trailing: trailing == null
          ? null
          : IconTheme(data: IconThemeData(size: config.iconSize), child: trailing!),
      shape: RoundedRectangleBorder(borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero),
    );

    if (!decorated) return listTile;

    return Container(
      decoration: BoxDecoration(
        color: Color.alphaBlend(config.surfaceTintColor.withValues(alpha: config.surfaceTintStrength), Theme.of(context).colorScheme.surface),
        borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero,
        boxShadow: config.useShadows
            ? [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: config.elevation, offset: Offset(0, config.elevation / 2))]
            : null,
        border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12)),
      ),
      child: listTile,
    );
  }
}


