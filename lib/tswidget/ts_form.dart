import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSFormSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const TSFormSection({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: config.useGradient ? LinearGradient(colors: [config.primaryColor, config.secondaryColor]) : null,
            color: config.useGradient ? null : config.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(config.borderRadius.topLeft.x),
              topRight: Radius.circular(config.borderRadius.topRight.x),
            ),
          ),
          child: Text(
            title,
            style: tsTextStyleForConfig(
              config,
              weight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color.alphaBlend(
              config.surfaceTintColor.withValues(alpha: config.surfaceTintStrength),
              config.backgroundColor,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(config.borderRadius.bottomLeft.x),
              bottomRight: Radius.circular(config.borderRadius.bottomRight.x),
            ),
            border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12)),
          ),
          child: DefaultTextStyle.merge(
            style: tsTextStyleForConfig(config, color: Theme.of(context).colorScheme.onSurface),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              for (final w in children) ...[w, const SizedBox(height: 12)],
            ]),
          ),
        ),
      ],
    );
  }
}


