import 'package:flutter/material.dart';
import 'ts_theme.dart';

Future<T?> showTSBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  final config = TSTheme.of(context);
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: config.useRoundedCorners ? Radius.circular(config.borderRadius.topLeft.x) : Radius.zero)),
    builder: (ctx) => Padding(padding: const EdgeInsets.all(16), child: builder(ctx)),
  );
}


