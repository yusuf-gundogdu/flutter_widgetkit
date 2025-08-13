import 'dart:ui';

class LanguageHelper {
  static Locale getSystemLocale() {
    final String systemLanguage = PlatformDispatcher.instance.locale.languageCode;
    switch (systemLanguage) {
      case 'tr':
        return const Locale('tr', 'TR');
      case 'de':
        return const Locale('de', 'DE');
      case 'fr':
        return const Locale('fr', 'FR');
      case 'zh':
        return const Locale('zh', 'CN');
      case 'es':
        return const Locale('es', 'ES');
      case 'en':
      default:
        return const Locale('en', 'US');
    }
  }
  
  

  static bool isTurkish() {
    return getSystemLocale().languageCode == 'tr';
  }
  
  static bool isEnglish() {
    return getSystemLocale().languageCode == 'en';
  }
} 