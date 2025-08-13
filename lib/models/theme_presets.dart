import 'package:flutter/material.dart';

enum ThemePreset {
  modern,
  classic,
  vibrant,
  pastel,
  ocean,
  forest,
  sun,
  lavender,
  rose,
  graphite,
  nord,
  nordDarker,
  solarized,
  dracula,
  miami,
  tokyo,
}

class ThemePresetDef {
  final ThemePreset id;
  final String name;
  final Color primary;
  final Color secondary;
  final Color accent;

  const ThemePresetDef(this.id, this.name, this.primary, this.secondary, this.accent);
}

const List<ThemePresetDef> kThemePresets = [
  ThemePresetDef(ThemePreset.modern, 'Modern', Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFF06B6D4)),
  ThemePresetDef(ThemePreset.classic, 'Classic', Color(0xFF1F2937), Color(0xFF374151), Color(0xFF6B7280)),
  ThemePresetDef(ThemePreset.vibrant, 'Vibrant', Color(0xFFEF4444), Color(0xFFF59E0B), Color(0xFF10B981)),
  ThemePresetDef(ThemePreset.pastel, 'Pastel', Color(0xFFF472B6), Color(0xFFA78BFA), Color(0xFF34D399)),
  ThemePresetDef(ThemePreset.ocean, 'Ocean', Color(0xFF0EA5E9), Color(0xFF0284C7), Color(0xFF0891B2)),
  ThemePresetDef(ThemePreset.forest, 'Forest', Color(0xFF059669), Color(0xFF047857), Color(0xFF65A30D)),
  ThemePresetDef(ThemePreset.sun, 'Sun', Color(0xFFF59E0B), Color(0xFFD97706), Color(0xFFEA580C)),
  ThemePresetDef(ThemePreset.lavender, 'Lavender', Color(0xFF8B5CF6), Color(0xFF7C3AED), Color(0xFFA855F7)),
  ThemePresetDef(ThemePreset.rose, 'Rose', Color(0xFFEC4899), Color(0xFFDB2777), Color(0xFFBE185D)),
  ThemePresetDef(ThemePreset.graphite, 'Graphite', Color(0xFF475569), Color(0xFF334155), Color(0xFF1E293B)),
  ThemePresetDef(ThemePreset.nord, 'Nord', Color(0xFF88C0D0), Color(0xFF81A1C1), Color(0xFFA3BE8C)),
  // Nord Darker: deeper tones inspired by Nord palette
  ThemePresetDef(ThemePreset.nordDarker, 'Nord Darker', Color(0xFF5E81AC), Color(0xFF4C566A), Color(0xFF8FBCBB)),
  ThemePresetDef(ThemePreset.solarized, 'Solarized', Color(0xFF268BD2), Color(0xFF2AA198), Color(0xFFB58900)),
  ThemePresetDef(ThemePreset.dracula, 'Dracula', Color(0xFFBD93F9), Color(0xFF6272A4), Color(0xFF50FA7B)),
  ThemePresetDef(ThemePreset.miami, 'Miami', Color(0xFF06B6D4), Color(0xFFF472B6), Color(0xFFA855F7)),
  ThemePresetDef(ThemePreset.tokyo, 'Tokyo', Color(0xFF7AA2F7), Color(0xFF9ECE6A), Color(0xFFE0AF68)),
];

ThemePresetDef? findPresetByColors(Color primary, Color secondary, Color accent) {
  for (final p in kThemePresets) {
    if (p.primary.value == primary.value && p.secondary.value == secondary.value && p.accent.value == accent.value) {
      return p;
    }
  }
  return null;
}


