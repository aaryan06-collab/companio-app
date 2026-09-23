import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

/// LocalizationsDelegate that consults an in-app language preference
/// (stored in the database) instead of only the device locale.
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate({this.overrideLanguage});

  /// When set, this wins over the device locale.
  final String? overrideLanguage;

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales.any(
    (l) => l.languageCode == locale.languageCode,
  );

  @override
  Future<AppLocalizations> load(Locale locale) async {
    if (overrideLanguage != null && overrideLanguage!.isNotEmpty) {
      return AppLocalizations.forLanguageCode(overrideLanguage!);
    }
    return AppLocalizations.forLanguageCode(locale.languageCode);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) =>
      old.overrideLanguage != overrideLanguage;

  @override
  String toString() =>
      'AppLocalizationsDelegate(overrideLanguage: $overrideLanguage)';

  /// An override sentinel that resolves to the device language.
  static const String followDevice = '__device__';

  static String codeOf(String? stored) =>
      stored == null || stored.isEmpty || stored == followDevice ? '' : stored;
}
