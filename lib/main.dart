import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/template_studio_screen.dart';
import 'utils/language_helper.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const TemplateStudioApp());
}

class TemplateStudioApp extends StatefulWidget {
  const TemplateStudioApp({super.key});

  @override
  State<TemplateStudioApp> createState() => _TemplateStudioAppState();
}

class _TemplateStudioAppState extends State<TemplateStudioApp> {
  // Default to Nord Darker palette
  Color primaryColor = const Color(0xFF5E81AC);
  Color secondaryColor = const Color(0xFF4C566A);
  Color accentColor = const Color(0xFF8FBCBB);
  bool isDarkMode = false;

  void updateTheme({
    required Color primary,
    required Color secondary,
    required Color accent,
    bool? darkMode,
  }) {
    setState(() {
      primaryColor = primary;
      secondaryColor = secondary;
      accentColor = accent;
      if (darkMode != null) {
        isDarkMode = darkMode;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
        ).copyWith(
          primary: primaryColor,
          secondary: secondaryColor,
          tertiary: accentColor,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.dark,
        ).copyWith(
          primary: primaryColor,
          secondary: secondaryColor,
          tertiary: accentColor,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF1F2937),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: TemplateStudioScreen(
        onThemeUpdate: updateTheme,
        currentPrimaryColor: primaryColor,
        currentSecondaryColor: secondaryColor,
        currentAccentColor: accentColor,
        currentDarkMode: isDarkMode,
      ),
    );
  }
}
