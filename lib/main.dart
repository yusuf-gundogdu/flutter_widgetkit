import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'tswidget/ts_theme.dart';
import 'screens/template_studio_screen.dart';
import 'utils/language_helper.dart';
import 'l10n/app_localizations.dart';
import 'models/template_config.dart';

void main() {
  runApp(const TemplateStudioApp());
}

class TemplateStudioApp extends StatefulWidget {
  const TemplateStudioApp({super.key});

  @override
  State<TemplateStudioApp> createState() => _TemplateStudioAppState();
}

class _TemplateStudioAppState extends State<TemplateStudioApp> {
  TemplateConfig appConfig = TemplateConfig();
  bool isDarkMode = false;

  void updateConfig(TemplateConfig newConfig) {
    setState(() {
      appConfig = newConfig;
    });
  }

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme lightScheme = ColorScheme.fromSeed(
      seedColor: appConfig.primaryColor,
      brightness: Brightness.light,
    ).copyWith(
      primary: appConfig.primaryColor,
      secondary: appConfig.secondaryColor,
      tertiary: appConfig.accentColor,
    );

    final ColorScheme darkSchemeBase = ColorScheme.fromSeed(
      seedColor: appConfig.primaryColor,
      brightness: Brightness.dark,
    ).copyWith(
      primary: appConfig.primaryColor,
      secondary: appConfig.secondaryColor,
      tertiary: appConfig.accentColor,
    );
    // Koyu temayı zifiri değil, yumuşak koyu yapmak için yüzeyleri hafifçe aydınlat
    final Color softenedSurface = Color.alphaBlend(Colors.white.withOpacity(0.06), darkSchemeBase.surface);
    final Color softenedBackground = Color.alphaBlend(Colors.white.withOpacity(0.04), darkSchemeBase.background);
    final ColorScheme darkScheme = darkSchemeBase.copyWith(
      surface: softenedSurface,
      background: softenedBackground,
      surfaceVariant: Color.alphaBlend(Colors.white.withOpacity(0.05), darkSchemeBase.surfaceVariant),
    );

    return MaterialApp(
      title: 'Template Studio',
      debugShowCheckedModeBanner: false,
      builder: (context, child) => child!,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: LanguageHelper.getSystemLocale(),
      theme: ThemeData(
        colorScheme: lightScheme,
        useMaterial3: true,
        textTheme: tsTextThemeFromConfig(appConfig, ThemeData.light().textTheme),
        scaffoldBackgroundColor: lightScheme.surface,
        canvasColor: lightScheme.surface,
        appBarTheme: AppBarTheme(
          backgroundColor: appConfig.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: appConfig.primaryColor,
            foregroundColor: Colors.white,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: appConfig.primaryColor,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          color: lightScheme.surface,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: darkScheme,
        useMaterial3: true,
        applyElevationOverlayColor: true,
        textTheme: tsTextThemeFromConfig(appConfig, ThemeData.dark().textTheme),
        scaffoldBackgroundColor: darkScheme.background,
        canvasColor: darkScheme.background,
        appBarTheme: AppBarTheme(
          backgroundColor: appConfig.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: appConfig.primaryColor,
            foregroundColor: Colors.white,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: appConfig.primaryColor,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          color: darkScheme.surface,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: TemplateStudioScreen(
        onConfigUpdate: updateConfig,
        currentConfig: appConfig,
        currentDarkMode: isDarkMode,
        onDarkModeToggle: toggleDarkMode,
      ),
    );
  }
}
