import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;

  const TSAppBar({
    super.key,
    this.title,
    this.actions,
    this.centerTitle = false,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.bottom,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return AppBar(
      title: IconTheme(
        data: IconThemeData(size: config.iconSize),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: config.fontSize,
            fontWeight: config.fontWeight,
            letterSpacing: config.letterSpacing,
            height: config.lineHeight,
          ),
          child: title ?? const SizedBox.shrink(),
        ),
      ),
      actions: actions,
      centerTitle: centerTitle,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      bottom: bottom,
      backgroundColor: config.primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    );
  }
}


