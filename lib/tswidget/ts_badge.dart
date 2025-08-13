import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSBadge extends StatelessWidget {
  final Widget child;
  final String label;
  const TSBadge({super.key, required this.child, required this.label});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: -4,
          top: -4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: config.accentColor,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: ((config.fontSize * 0.7).clamp(8.0, 12.0)).toDouble(),
                fontWeight: FontWeight.w700,
                letterSpacing: config.letterSpacing,
                height: config.lineHeight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


