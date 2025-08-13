import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/template_config.dart';
import '../l10n/app_localizations.dart';
import '../models/theme_presets.dart';

class ThemeSelector extends StatelessWidget {
  final TemplateConfig config;
  final Function(TemplateConfig) onConfigChanged;

  const ThemeSelector({
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
                Icon(Icons.palette, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context).t('theme_colors'),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Ana Renk
            _buildColorSelector(
              context,
              AppLocalizations.of(context).t('primary_color'),
              config.primaryColor,
              (color) => onConfigChanged(config.copyWith(primaryColor: color)),
            ),
            const SizedBox(height: 12),
            
            // İkincil Renk
            _buildColorSelector(
              context,
              AppLocalizations.of(context).t('secondary_color'),
              config.secondaryColor,
              (color) => onConfigChanged(config.copyWith(secondaryColor: color)),
            ),
            const SizedBox(height: 12),
            
            // Vurgu Rengi
            _buildColorSelector(
              context,
              AppLocalizations.of(context).t('accent_color'),
              config.accentColor,
              (color) => onConfigChanged(config.copyWith(accentColor: color)),
            ),
            const SizedBox(height: 12),
            
            // Arka Plan Rengi
            _buildColorSelector(
              context,
              AppLocalizations.of(context).t('background_color'),
              config.backgroundColor,
              (color) => onConfigChanged(config.copyWith(backgroundColor: color)),
            ),
            const SizedBox(height: 16),
            
        // Hızlı Tema Seçenekleri
        _buildQuickThemeDropdown(context),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSelector(BuildContext context, String label, Color color, Function(Color) onColorChanged) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        GestureDetector(
          onTap: () => _showColorPicker(context, color, onColorChanged),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              Icons.colorize,
              color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickThemeDropdown(BuildContext context) {
    final themes = kThemePresets;

    // Mevcut temayı bul
    String currentThemeName = AppLocalizations.of(context).t('custom');
    final matched = findPresetByColors(config.primaryColor, config.secondaryColor, config.accentColor);
    if (matched != null) currentThemeName = matched.name;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).t('quick_themes'),
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
             value: currentThemeName,
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
            items: [
              DropdownMenuItem<String>(
                value: AppLocalizations.of(context).t('custom'),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [config.primaryColor, config.secondaryColor, config.accentColor],
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(AppLocalizations.of(context).t('custom_theme'), style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
              ...themes.map((p) {
                  return DropdownMenuItem<String>(
                    value: p.name,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Row(
                          children: [
                             Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [p.primary, p.secondary, p.accent],
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 8),
                             Text(p.name, style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            ],
            onChanged: (String? newValue) {
               if (newValue != null && newValue != AppLocalizations.of(context).t('custom')) {
                final selected = themes.firstWhere((t) => t.name == newValue);
                onConfigChanged(config.copyWith(
                  primaryColor: selected.primary,
                  secondaryColor: selected.secondary,
                  accentColor: selected.accent,
                ));
              }
            },
          ),
        ),
      ],
    );
  }

  void _showColorPicker(BuildContext context, Color initialColor, Function(Color) onColorChanged) {
    showDialog(
      context: context,
        builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).t('pick_color')),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: initialColor,
            onColorChanged: onColorChanged,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(AppLocalizations.of(context).t('ok'))),
        ],
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  final Color pickerColor;
  final Function(Color) onColorChanged;
  final double pickerAreaHeightPercent;

  const ColorPicker({
    super.key,
    required this.pickerColor,
    required this.onColorChanged,
    this.pickerAreaHeightPercent = 0.8,
  });

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color currentColor;
  late double hue;
  late double saturation;
  late double value;

  @override
  void initState() {
    super.initState();
    currentColor = widget.pickerColor;
    final hsv = HSVColor.fromColor(currentColor);
    hue = hsv.hue;
    saturation = hsv.saturation;
    value = hsv.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Ana renk paleti
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              onPanUpdate: (details) => _updateColor(details.localPosition),
              onTapDown: (details) => _updateColor(details.localPosition),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      HSVColor.fromAHSV(1.0, hue, 0.0, 1.0).toColor(),
                      HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor(),
                    ],
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.0),
                          Colors.black.withValues(alpha: 1.0),
                        ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Hue slider
        Container(
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: GestureDetector(
              onPanUpdate: (details) => _updateHue(details.localPosition.dx),
              onTapDown: (details) => _updateHue(details.localPosition.dx),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFFF0000), // Kırmızı
                      const Color(0xFFFFFF00), // Sarı
                      const Color(0xFF00FF00), // Yeşil
                      const Color(0xFF00FFFF), // Cyan
                      const Color(0xFF0000FF), // Mavi
                      const Color(0xFFFF00FF), // Magenta
                      const Color(0xFFFF0000), // Kırmızı (tekrar)
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: (hue / 360) * 200 - 10,
                      top: 5,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Value slider
        Container(
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: GestureDetector(
              onPanUpdate: (details) => _updateValue(details.localPosition.dx),
              onTapDown: (details) => _updateValue(details.localPosition.dx),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      HSVColor.fromAHSV(1.0, hue, saturation, 1.0).toColor(),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: value * 200 - 10,
                      top: 5,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Seçili renk gösterimi
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: currentColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            ),
          ),
          child: Center(
            child: Text(
              '#${currentColor.toARGB32().toRadixString(16).toUpperCase().substring(2)}',
              style: TextStyle(
                color: currentColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _updateColor(Offset position) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final size = box.size;
    
    final saturation = (position.dx / size.width).clamp(0.0, 1.0);
    final value = (1.0 - position.dy / size.height).clamp(0.0, 1.0);
    
    setState(() {
      this.saturation = saturation;
      this.value = value;
      currentColor = HSVColor.fromAHSV(1.0, hue, saturation, value).toColor();
    });
    widget.onColorChanged(currentColor);
  }

  void _updateHue(double x) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final width = box.size.width;
    
    final newHue = (x / width * 360).clamp(0.0, 360.0);
    
    setState(() {
      hue = newHue;
      currentColor = HSVColor.fromAHSV(1.0, hue, saturation, value).toColor();
    });
    widget.onColorChanged(currentColor);
  }

  void _updateValue(double x) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final width = box.size.width;
    
    final newValue = (x / width).clamp(0.0, 1.0);
    
    setState(() {
      value = newValue;
      currentColor = HSVColor.fromAHSV(1.0, hue, saturation, value).toColor();
    });
    widget.onColorChanged(currentColor);
  }
} 