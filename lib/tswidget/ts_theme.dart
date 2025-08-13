import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/template_config.dart';

class TSTheme extends InheritedWidget {
  final TemplateConfig config;

  const TSTheme({
    super.key,
    required this.config,
    required super.child,
  });

  static TemplateConfig of(BuildContext context) {
    final TSTheme? inherited = context.dependOnInheritedWidgetOfExactType<TSTheme>();
    assert(inherited != null, 'TSTheme.of(context) called with no TSTheme in context');
    return inherited!.config;
  }

  @override
  bool updateShouldNotify(covariant TSTheme oldWidget) => oldWidget.config != config;
}

// Typography helpers to apply selected Google Font consistently
TextStyle tsTextStyleForConfig(TemplateConfig config, {double? size, FontWeight? weight, Color? color}) {
  final TextStyle base = _fontForFamily(config.fontFamily);
  return base.copyWith(
    fontSize: size ?? config.fontSize,
    fontWeight: weight ?? config.fontWeight,
    color: color,
    letterSpacing: config.letterSpacing,
    height: config.lineHeight,
  );
}

TextTheme tsTextThemeForFamily(String family, [TextTheme? base]) {
  switch (family) {
    case 'Gruppo':
      return GoogleFonts.gruppoTextTheme(base);
    case 'Inter':
      return GoogleFonts.interTextTheme(base);
    case 'Roboto':
      return GoogleFonts.robotoTextTheme(base);
    case 'Open Sans':
      return GoogleFonts.openSansTextTheme(base);
    case 'Lato':
      return GoogleFonts.latoTextTheme(base);
    case 'Poppins':
      return GoogleFonts.poppinsTextTheme(base);
    case 'Montserrat':
      return GoogleFonts.montserratTextTheme(base);
    case 'Source Sans 3':
      return GoogleFonts.sourceSans3TextTheme(base);
    case 'Ubuntu':
      return GoogleFonts.ubuntuTextTheme(base);
    case 'Nunito':
      return GoogleFonts.nunitoTextTheme(base);
    case 'Work Sans':
      return GoogleFonts.workSansTextTheme(base);
    case 'Raleway':
      return GoogleFonts.ralewayTextTheme(base);
    case 'PT Sans':
      return GoogleFonts.ptSansTextTheme(base);
    case 'Noto Sans':
      return GoogleFonts.notoSansTextTheme(base);
    case 'Merriweather':
      return GoogleFonts.merriweatherTextTheme(base);
    case 'Playfair Display':
      return GoogleFonts.playfairDisplayTextTheme(base);
    case 'Bebas Neue':
      return GoogleFonts.bebasNeueTextTheme(base);
    case 'Oswald':
      return GoogleFonts.oswaldTextTheme(base);
    case 'Dancing Script':
      return GoogleFonts.dancingScriptTextTheme(base);
    case 'Pacifico':
      return GoogleFonts.pacificoTextTheme(base);
    case 'Fredoka One':
      return GoogleFonts.fredokaTextTheme(base);
    default:
      return GoogleFonts.poppinsTextTheme(base);
  }
}

TextStyle _fontForFamily(String family) {
  switch (family) {
    case 'Gruppo':
      return GoogleFonts.gruppo();
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
      return GoogleFonts.poppins();
  }
}

// Builds a TextTheme from TemplateConfig that applies family, size factor,
// weight, letter spacing and line height consistently across all roles.
TextTheme tsTextThemeFromConfig(TemplateConfig config, TextTheme base) {
  final TextTheme familyApplied = tsTextThemeForFamily(config.fontFamily, base);
  final double baseSize = base.bodyMedium?.fontSize ?? 14.0;
  final double factor = baseSize > 0 ? (config.fontSize / baseSize) : 1.0;

  TextStyle? applyAll(TextStyle? style) {
    if (style == null) return null;
    final double resolvedSize = (style.fontSize ?? baseSize) * factor;
    return style.copyWith(
      fontSize: resolvedSize,
      fontWeight: config.fontWeight,
      letterSpacing: config.letterSpacing,
      height: config.lineHeight,
    );
  }

  return familyApplied.copyWith(
    displayLarge: applyAll(familyApplied.displayLarge),
    displayMedium: applyAll(familyApplied.displayMedium),
    displaySmall: applyAll(familyApplied.displaySmall),
    headlineLarge: applyAll(familyApplied.headlineLarge),
    headlineMedium: applyAll(familyApplied.headlineMedium),
    headlineSmall: applyAll(familyApplied.headlineSmall),
    titleLarge: applyAll(familyApplied.titleLarge),
    titleMedium: applyAll(familyApplied.titleMedium),
    titleSmall: applyAll(familyApplied.titleSmall),
    bodyLarge: applyAll(familyApplied.bodyLarge),
    bodyMedium: applyAll(familyApplied.bodyMedium),
    bodySmall: applyAll(familyApplied.bodySmall),
    labelLarge: applyAll(familyApplied.labelLarge),
    labelMedium: applyAll(familyApplied.labelMedium),
    labelSmall: applyAll(familyApplied.labelSmall),
  );
}


