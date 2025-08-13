import 'package:flutter/material.dart';
import 'ts_theme.dart';
import '../models/template_config.dart';

class TSAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;
  final TemplateConfig? config;

  const TSAppBar({
    super.key,
    this.title,
    this.actions,
    this.centerTitle = false,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.bottom,
    this.config,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final TemplateConfig effective = config ??
        (context.dependOnInheritedWidgetOfExactType<TSTheme>()?.config ?? TemplateConfig());

    Color _shade(Color color, double lightnessDelta) {
      final hsl = HSLColor.fromColor(color);
      final double l = (hsl.lightness + lightnessDelta).clamp(0.0, 1.0).toDouble();
      return hsl.withLightness(l).toColor();
    }
    return AppBar(
      title: IconTheme(
        data: IconThemeData(size: effective.iconSize),
        child: DefaultTextStyle.merge(
          style: tsTextStyleForConfig(
            effective,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          child: title ?? const SizedBox.shrink(),
        ),
      ),
      actions: actions,
      centerTitle: centerTitle,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      bottom: bottom,
      backgroundColor: effective.useGradient ? Colors.transparent : Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      elevation: 0,
      flexibleSpace: effective.useGradient
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _shade(effective.primaryColor, 0.08),
                    _shade(effective.primaryColor, -0.12),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            )
          : null,
    );
  }
}


