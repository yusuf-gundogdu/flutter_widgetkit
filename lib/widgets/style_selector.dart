import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/template_config.dart';
import '../l10n/app_localizations.dart';

class StyleSelector extends StatelessWidget {
  final TemplateConfig config;
  final Function(TemplateConfig) onConfigChanged;

  const StyleSelector({
    super.key,
    required this.config,
    required this.onConfigChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Icon(Icons.style, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context).t('style_settings'),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Stil Varyantı
            _buildStyleVariantSelector(context),
            const SizedBox(height: 16),
            
            // Stil Seçenekleri
            _buildStyleOptions(context),
            const SizedBox(height: 16),
            
            // Border Radius (Yuvarlak Köşeler anahtarının ALTINA taşındı)
            _buildBorderRadiusSlider(context),
            const SizedBox(height: 16),
            // Icon Size
            _buildIconSizeSlider(context),
            const SizedBox(height: 16),
            // Surface Tint
            _buildSurfaceTintControls(context),
          ],
        ),
      ),
    );
  }

  String _variantName(BuildContext context, StyleVariant v) {
    final t = AppLocalizations.of(context);
    switch (v) {
      case StyleVariant.modern:
        return t.t('variant_modern');
      case StyleVariant.classic:
        return t.t('variant_classic');
      case StyleVariant.minimal:
        return t.t('variant_minimal');
      case StyleVariant.colorful:
        return t.t('variant_colorful');
      case StyleVariant.neumorphic:
        return t.t('variant_neumorphic');
      case StyleVariant.glass:
        return t.t('variant_glass');
    }
  }

  Widget _buildStyleVariantSelector(BuildContext context) {
    final variants = [
      {'name': 'Modern', 'variant': StyleVariant.modern},
      {'name': 'Klasik', 'variant': StyleVariant.classic},
      {'name': 'Minimal', 'variant': StyleVariant.minimal},
      {'name': 'Renkli', 'variant': StyleVariant.colorful},
      {'name': 'Neumorfik', 'variant': StyleVariant.neumorphic},
      {'name': 'Cam (Glass)', 'variant': StyleVariant.glass},
    ];

        return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).t('style_variant'),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<StyleVariant>(
            value: config.styleVariant,
            isExpanded: true,
            underline: Container(), // Alt çizgiyi kaldır
            icon: Icon(Icons.arrow_drop_down, color: Theme.of(context).colorScheme.primary),
            dropdownColor: Theme.of(context).colorScheme.surface,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            menuMaxHeight: 300,
            borderRadius: BorderRadius.circular(8),
            elevation: 4,
            items: variants.map((variant) {
              return DropdownMenuItem<StyleVariant>(
                value: variant['variant'] as StyleVariant,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      _variantName(context, variant['variant'] as StyleVariant),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (StyleVariant? newValue) {
              if (newValue != null) {
                // Stile göre yardımcı ayarları da uygula
                final brightness = Theme.of(context).brightness;
                Color background;
                bool useRounded;
                bool useShadows;
                bool useGradient;
                double elevation;
                Color surfaceTint = config.surfaceTintColor;
                double surfaceTintStrength = config.surfaceTintStrength;

                switch (newValue) {
                  case StyleVariant.modern:
                    background = Theme.of(context).colorScheme.surface;
                    useRounded = true;
                    useShadows = false;
                    useGradient = false;
                    elevation = 2;
                    surfaceTint = const Color(0x00000000);
                    surfaceTintStrength = 0.0;
                    break;
                  case StyleVariant.classic:
                    background = Theme.of(context).colorScheme.surface;
                    useRounded = true;
                    useShadows = true;
                    useGradient = false;
                    elevation = 4;
                    surfaceTint = const Color(0x00000000);
                    surfaceTintStrength = 0.0;
                    break;
                  case StyleVariant.minimal:
                    background = Colors.transparent;
                    useRounded = false;
                    useShadows = false;
                    useGradient = false;
                    elevation = 0;
                    surfaceTint = const Color(0x00000000);
                    surfaceTintStrength = 0.0;
                    break;
                  case StyleVariant.colorful:
                    background = Theme.of(context).colorScheme.primary.withValues(alpha: 0.05);
                    useRounded = true;
                    useShadows = false;
                    useGradient = false;
                    elevation = 2;
                    surfaceTint = const Color(0x00000000);
                    surfaceTintStrength = 0.0;
                    break;
                  case StyleVariant.neumorphic:
                    background = Theme.of(context).colorScheme.surface;
                    useRounded = true;
                    useShadows = true;
                    useGradient = false;
                    elevation = 10;
                    surfaceTint = const Color(0x00000000);
                    surfaceTintStrength = 0.0;
                    break;
                  case StyleVariant.glass:
                    background = Theme.of(context).colorScheme.surface.withValues(alpha: 0.12);
                    useRounded = true;
                    useShadows = true;
                    useGradient = false;
                    elevation = 6;
                    surfaceTint = Theme.of(context).colorScheme.surface;
                    surfaceTintStrength = 0.25;
                    break;
                }

                onConfigChanged(
                  config.copyWith(
                    styleVariant: newValue,
                    backgroundColor: background,
                    useRoundedCorners: useRounded,
                    useShadows: useShadows,
                    useGradient: useGradient,
                    elevation: elevation,
                    surfaceTintColor: surfaceTint,
                    surfaceTintStrength: surfaceTintStrength,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBorderRadiusSlider(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Corner Radius',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface
                      .withValues(alpha: config.useRoundedCorners ? 1.0 : 0.5),
                ),
              ),
            ),
            Text(
              '${config.borderRadius.topLeft.x.round()}px',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface
                    .withValues(alpha: config.useRoundedCorners ? 0.9 : 0.5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: config.borderRadius.topLeft.x,
          min: 0,
          max: 24,
          divisions: 24,
          activeColor: Theme.of(context).colorScheme.primary,
          onChanged: config.useRoundedCorners
              ? (value) => onConfigChanged(config.copyWith(
                    borderRadius: BorderRadius.all(Radius.circular(value)),
                  ))
              : null,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                'Keskin',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface
                      .withValues(alpha: config.useRoundedCorners ? 0.8 : 0.5),
                ),
              ),
            ),
            Text(
              'Yuvarlak',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface
                    .withValues(alpha: config.useRoundedCorners ? 0.8 : 0.5),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildElevationSlider(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Shadow Depth',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface
                      .withValues(alpha: config.useShadows ? 1.0 : 0.5),
                ),
              ),
            ),
            Text(
              '${config.elevation.round()}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface
                    .withValues(alpha: config.useShadows ? 0.9 : 0.5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: config.elevation,
          min: 0,
          max: 12,
          divisions: 12,
          activeColor: Theme.of(context).colorScheme.primary,
          onChanged: config.useShadows
              ? (value) => onConfigChanged(config.copyWith(elevation: value))
              : null,
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            Text(
              'Flat',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface
                    .withValues(alpha: config.useShadows ? 0.8 : 0.5),
              ),
            ),
            Text(
              'Deep',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface
                    .withValues(alpha: config.useShadows ? 0.8 : 0.5),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStyleOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).t('style_options'),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        
        // Gradient Kullanımı
        _buildStyleOption(
          context,
          AppLocalizations.of(context).t('use_gradient'),
          AppLocalizations.of(context).t('add_gradients'),
          Icons.gradient,
          config.useGradient,
          (value) => onConfigChanged(config.copyWith(useGradient: value)),
        ),
        
        const SizedBox(height: 8),
        
        // Gölge Kullanımı
        _buildStyleOption(
          context,
          AppLocalizations.of(context).t('shadow_effect'),
          AppLocalizations.of(context).t('add_shadows'),
          Icons.visibility,
          config.useShadows,
          (value) => onConfigChanged(config.copyWith(useShadows: value)),
        ),

        // Gölge derinliği (tam olarak Gölge Efekti anahtarının altında)
        const SizedBox(height: 8),
        _buildElevationSlider(context),
        const SizedBox(height: 8),
        
        // Yuvarlak Köşeler
        _buildStyleOption(
          context,
          AppLocalizations.of(context).t('rounded_corners'),
          AppLocalizations.of(context).t('round_corners'),
          Icons.rounded_corner,
          config.useRoundedCorners,
          (value) => onConfigChanged(config.copyWith(useRoundedCorners: value)),
        ),
      ],
    );
  }

  Widget _buildStyleOption(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: value 
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: value 
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      child: Row(
        children: [
          Icon(
            icon,
            color: value 
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: value ? FontWeight.w600 : FontWeight.normal,
                    color: value 
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildIconSizeSlider(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                AppLocalizations.of(context).t('icon_size'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              '${config.iconSize.round()}px',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: config.iconSize,
          min: 12,
          max: 40,
          divisions: 28,
          activeColor: Theme.of(context).colorScheme.primary,
          onChanged: (value) => onConfigChanged(config.copyWith(iconSize: value)),
        ),
      ],
    );
  }

  Widget _buildSurfaceTintControls(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).t('surface_tint'),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: config.surfaceTintColor.withValues(alpha: 1.0),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: Slider(
                value: config.surfaceTintStrength,
                min: 0.0,
                max: 0.6,
                divisions: 12,
                activeColor: Theme.of(context).colorScheme.primary,
                onChanged: (value) => onConfigChanged(config.copyWith(surfaceTintStrength: value)),
              ),
            ),
          ],
        ),
      ],
    );
  }
} 