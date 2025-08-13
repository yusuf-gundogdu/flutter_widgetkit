import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/template_config.dart';
import '../l10n/app_localizations.dart';

class FontSelector extends StatelessWidget {
  final TemplateConfig config;
  final Function(TemplateConfig) onConfigChanged;

  const FontSelector({
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
            Row(
              children: [
                Icon(Icons.font_download, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context).t('font_title'),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Font Ailesi Seçici
            _buildFontFamilyDropdown(context),
            const SizedBox(height: 16),
            
            // Font Boyutu
            _buildFontSizeSlider(context),
            const SizedBox(height: 16),
            
            // Font Kalınlığı
            _buildFontWeightSelector(context),
            const SizedBox(height: 16),

          // Harf Aralığı
          _buildLetterSpacingSlider(context),
          const SizedBox(height: 16),

          // Satır Yüksekliği
          _buildLineHeightSlider(context),
            

          ],
        ),
      ),
    );
  }


  Widget _buildFontFamilyDropdown(BuildContext context) {
    final fonts = [
      {'name': 'Gruppo', 'family': 'Gruppo', 'category': 'Display'},
      {'name': 'Inter', 'family': 'Inter', 'category': 'Modern'},
      {'name': 'Roboto', 'family': 'Roboto', 'category': 'System'},
      {'name': 'Open Sans', 'family': 'Open Sans', 'category': 'Clean'},
      {'name': 'Lato', 'family': 'Lato', 'category': 'Friendly'},
      {'name': 'Poppins', 'family': 'Poppins', 'category': 'Geometric'},
      {'name': 'Montserrat', 'family': 'Montserrat', 'category': 'Elegant'},
      {'name': 'Source Sans 3', 'family': 'Source Sans 3', 'category': 'Professional'},
      {'name': 'Ubuntu', 'family': 'Ubuntu', 'category': 'Modern'},
      {'name': 'Nunito', 'family': 'Nunito', 'category': 'Rounded'},
      {'name': 'Work Sans', 'family': 'Work Sans', 'category': 'Clean'},
      {'name': 'Raleway', 'family': 'Raleway', 'category': 'Elegant'},
      {'name': 'PT Sans', 'family': 'PT Sans', 'category': 'Readable'},
      {'name': 'Noto Sans', 'family': 'Noto Sans', 'category': 'Universal'},
      {'name': 'Merriweather', 'family': 'Merriweather', 'category': 'Serif'},
      {'name': 'Playfair Display', 'family': 'Playfair Display', 'category': 'Serif'},
      {'name': 'Bebas Neue', 'family': 'Bebas Neue', 'category': 'Display'},
      {'name': 'Oswald', 'family': 'Oswald', 'category': 'Condensed'},
      {'name': 'Dancing Script', 'family': 'Dancing Script', 'category': 'Handwriting'},
      {'name': 'Pacifico', 'family': 'Pacifico', 'category': 'Handwriting'},
      {'name': 'Fredoka One', 'family': 'Fredoka One', 'category': 'Display'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).t('font_family'),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
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
          child: DropdownButton<String>(
            value: config.fontFamily,
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
            items: fonts.map((font) {
              return DropdownMenuItem<String>(
                value: font['family'] as String,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${font['name']} (${font['category']})',
                            style: _getGoogleFont(font['family'] as String).copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                onConfigChanged(config.copyWith(fontFamily: newValue));
              }
            },
          ),
        ),
      ],
    );
  }

  TextStyle _getGoogleFont(String fontFamily) {
    switch (fontFamily) {
      case 'Inter':
        return GoogleFonts.inter();
      case 'Roboto':
        return GoogleFonts.roboto();
      case 'Open Sans':
        return GoogleFonts.openSans();
      case 'Lato':
        return GoogleFonts.lato();
      case 'Poppins':
        return GoogleFonts.poppins();
      case 'Montserrat':
        return GoogleFonts.montserrat();
      case 'Source Sans 3':
        return GoogleFonts.sourceSans3();
      case 'Ubuntu':
        return GoogleFonts.ubuntu();
      case 'Nunito':
        return GoogleFonts.nunito();
      case 'Work Sans':
        return GoogleFonts.workSans();
      case 'Raleway':
        return GoogleFonts.raleway();
      case 'PT Sans':
        return GoogleFonts.ptSans();
      case 'Noto Sans':
        return GoogleFonts.notoSans();
      case 'Merriweather':
        return GoogleFonts.merriweather();
      case 'Playfair Display':
        return GoogleFonts.playfairDisplay();
      case 'Bebas Neue':
        return GoogleFonts.bebasNeue();
      case 'Oswald':
        return GoogleFonts.oswald();
      case 'Dancing Script':
        return GoogleFonts.dancingScript();
      case 'Pacifico':
        return GoogleFonts.pacifico();
      case 'Fredoka One':
        return GoogleFonts.fredoka();
      default:
        return GoogleFonts.inter();
    }
  }

  Widget _buildFontSizeSlider(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context).t('font_size'),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${config.fontSize.round()}px',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: config.fontSize,
          min: 12,
          max: 32,
          divisions: 20,
          activeColor: Theme.of(context).colorScheme.primary,
          onChanged: (value) => onConfigChanged(config.copyWith(fontSize: value)),
        ),
      ],
    );
  }

  Widget _buildFontWeightSelector(BuildContext context) {
    final weights = [
      {'name': 'Thin', 'weight': FontWeight.w300},
      {'name': 'Normal', 'weight': FontWeight.normal},
      {'name': 'Medium', 'weight': FontWeight.w500},
      {'name': 'Bold', 'weight': FontWeight.bold},
      {'name': 'Extra Bold', 'weight': FontWeight.w900},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).t('font_weight'),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
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
          child: DropdownButton<FontWeight>(
            value: config.fontWeight,
            isExpanded: true,
            underline: Container(), // Alt çizgiyi kaldır
            icon: Icon(Icons.arrow_drop_down, color: Theme.of(context).colorScheme.primary),
            dropdownColor: Theme.of(context).colorScheme.surface,
            menuMaxHeight: 300,
            borderRadius: BorderRadius.circular(8),
            elevation: 4,
            items: weights.map((weight) {
              return DropdownMenuItem<FontWeight>(
                value: weight['weight'] as FontWeight,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      weight['name'] as String,
                      style: TextStyle(
                        fontWeight: weight['weight'] as FontWeight,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (FontWeight? newValue) {
              if (newValue != null) {
                onConfigChanged(config.copyWith(fontWeight: newValue));
              }
            },
          ),
        ),
      ],
    );
  }


  Widget _buildLetterSpacingSlider(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context).t('letter_spacing'),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              config.letterSpacing.toStringAsFixed(2),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: config.letterSpacing,
          min: -1.0,
          max: 2.0,
          divisions: 30,
          activeColor: Theme.of(context).colorScheme.primary,
          onChanged: (value) => onConfigChanged(config.copyWith(letterSpacing: value)),
        ),
      ],
    );
  }

  Widget _buildLineHeightSlider(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context).t('line_height'),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              config.lineHeight.toStringAsFixed(2),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: config.lineHeight,
          min: 0.8,
          max: 2.0,
          divisions: 24,
          activeColor: Theme.of(context).colorScheme.primary,
          onChanged: (value) => onConfigChanged(config.copyWith(lineHeight: value)),
        ),
      ],
    );
  }

} 