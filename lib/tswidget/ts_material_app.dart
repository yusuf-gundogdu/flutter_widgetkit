import 'package:flutter/material.dart';
import '../models/template_config.dart';
import '../models/theme_presets.dart';
import 'ts_theme.dart';

class TSMaterialApp extends StatelessWidget {
  // Option A: pass a built config
  final TemplateConfig? config;
  // Option B: pass a preset and optional overrides
  final ThemePreset? preset;
  final String? fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? cornerRadius;
  final double? elevation;
  final bool? rounded;
  final bool? shadows;
  final bool? gradient;
  final StyleVariant? style;
  final ScreenType? screen;

  final Widget home;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale>? supportedLocales;
  final Locale? locale;

  const TSMaterialApp({
    super.key,
    this.config,
    this.preset,
    this.fontFamily,
    this.fontSize,
    this.fontWeight,
    this.cornerRadius,
    this.elevation,
    this.rounded,
    this.shadows,
    this.gradient,
    this.style,
    this.screen,
    required this.home,
    this.localizationsDelegates,
    this.supportedLocales,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    // Build effective config
    TemplateConfig effective =
        config ?? (preset != null ? TemplateConfig.fromPreset(preset!) : TemplateConfig());

    // Apply optional overrides
    if (fontFamily != null ||
        fontSize != null ||
        fontWeight != null ||
        cornerRadius != null ||
        elevation != null ||
        rounded != null ||
        shadows != null ||
        gradient != null ||
        style != null ||
        screen != null) {
      effective = effective.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        borderRadius:
            cornerRadius != null ? BorderRadius.all(Radius.circular(cornerRadius!)) : null,
        elevation: elevation,
        useRoundedCorners: rounded,
        useShadows: shadows,
        useGradient: gradient,
        styleVariant: style,
        screenType: screen,
      );
    }

    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: effective.primaryColor).copyWith(
      primary: effective.primaryColor,
      secondary: effective.secondaryColor,
      tertiary: effective.accentColor,
    );
    return TSTheme(
      config: effective,
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: localizationsDelegates?.toList(),
        supportedLocales: supportedLocales?.toList() ?? const [Locale('en')],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: scheme,
          useMaterial3: true,
          textTheme: tsTextThemeFromConfig(effective, ThemeData.light().textTheme).apply(
            bodyColor: scheme.onSurface,
            displayColor: scheme.onSurface,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: scheme.primary,
            foregroundColor: scheme.onPrimary,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: scheme.primary,
              foregroundColor: scheme.onPrimary,
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: scheme.primary,
            foregroundColor: scheme.onPrimary,
          ),
          cardTheme: CardThemeData(
            color: scheme.surface,
            elevation: effective.elevation,
            shape: RoundedRectangleBorder(borderRadius: effective.borderRadius),
          ),
        ),
        home: home,
      ),
    );
  }
}


