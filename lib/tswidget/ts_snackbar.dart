import 'package:flutter/material.dart';
import 'ts_theme.dart';

void showTSSnackBar(BuildContext context, String message) {
  final config = TSTheme.of(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: config.primaryColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: config.useRoundedCorners
            ? config.borderRadius
            : BorderRadius.zero,
      ),
    ),
  );
}


