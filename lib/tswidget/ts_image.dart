import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSImage extends StatelessWidget {
  final ImageProvider image;
  final BoxFit fit;
  const TSImage({super.key, required this.image, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return ClipRRect(
      borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero,
      child: Image(image: image, fit: fit),
    );
  }
}


