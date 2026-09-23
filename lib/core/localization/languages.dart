import 'package:flutter/material.dart';

/// One supported language in Companio.
class AppLanguage {
  const AppLanguage(this.code, this.nativeName);

  /// ISO-639-1/3 language code used everywhere (DB, locale, TTS map).
  final String code;

  /// The language's own name (shown in the language picker).
  final String nativeName;

  Locale get locale => Locale(code);
}

/// All supported languages. Order matters for the picker:
/// primary (hi/en) first, then North-East India, then major Indian languages.
const List<AppLanguage> appLanguages = [
  AppLanguage('hi', 'हिन्दी'),
  AppLanguage('en', 'English'),
  // North-East India
  AppLanguage('as', 'অসমীয়া'),
  AppLanguage('bn', 'বাংলা'),
  AppLanguage('brx', 'बरʼ (बड़ो)'),
  AppLanguage('ne', 'नेपाली'),
  AppLanguage('kha', 'Ka Ktien Khasi'),
  AppLanguage('grt', 'A·chik (Garo)'),
  AppLanguage('lus', 'Mizo ṭawng'),
  AppLanguage('mni', 'মৈতৈলোন্ (Meeteilon)'),
  // Major Indian languages
  AppLanguage('mr', 'मराठी'),
  AppLanguage('gu', 'ગુજરાતી'),
  AppLanguage('pa', 'ਪੰਜਾਬੀ'),
  AppLanguage('or', 'ଓଡ଼ିଆ'),
  AppLanguage('ta', 'தமிழ்'),
  AppLanguage('te', 'తెలుగు'),
  AppLanguage('kn', 'ಕನ್ನಡ'),
  AppLanguage('ml', 'മലയാളം'),
  AppLanguage('ur', 'اردو'),
  AppLanguage('sat', 'ᱥᱟᱱᱛᱟᱲᱤ'),
];

/// Codes of the North-East India group shown first in the picker.
const Set<String> northEastCodes = {
  'as',
  'bn',
  'brx',
  'ne',
  'kha',
  'grt',
  'lus',
  'mni',
};

/// Primary keys: Hindi + English always surface at the top of the picker.
String? languageNameOf(String code) {
  for (final l in appLanguages) {
    if (l.code == code) return l.nativeName;
  }
  return null;
}

bool isSupportedLanguage(String code) {
  final c = code.toLowerCase();
  for (final l in appLanguages) {
    if (l.code == c) return true;
  }
  return false;
}

/// Best default language for a sign-up region ('en' -> English).
String suggestedLanguageForRegion(String region) => switch (region) {
  'assam' => 'as',
  'meghalaya' => 'en',
  'arunachal' => 'en',
  'nagaland' => 'en',
  'manipur' => 'mni',
  'mizoram' => 'lus',
  'tripura' => 'bn',
  'westbengal' => 'bn',
  _ => 'hi',
};

/// Language codes that `flutter_localizations` (GlobalMaterialLocalizations)
/// actually bundles. Minority NER codes (brx, kha, grt, lus, mni, sat) are NOT
/// among them, so driving MaterialApp.locale directly with any of those throws
/// "No MaterialLocalizations found". Our AppLocalizations renders the real
/// language via delegate overrideLanguage; the framework locale just needs to
/// be a code the Global delegates can resolve.
const Set<String> _globallyLocalized = {
  'en',
  'hi',
  'as',
  'bn',
  'ne',
  'mr',
  'gu',
  'pa',
  'or',
  'ta',
  'te',
  'kn',
  'ml',
  'ur',
};

/// Safe [code] for MaterialApp.locale: stays on the chosen language when the
/// framework ships Material strings, otherwise falls back to 'en'.
String globalLocaleFor(String code) =>
    _globallyLocalized.contains(code) ? code : 'en';

/// BCP-47 voice code for [languageCode]. Voices below are best-effort:
/// Android Hindi TTS covers most Indic scripts; minority NER languages
/// fall back to English until device voices exist.
String voiceLocaleFor(String languageCode) => switch (languageCode) {
  'hi' => 'hi-IN',
  'bn' => 'bn-IN',
  'ta' => 'ta-IN',
  'te' => 'te-IN',
  'kn' => 'kn-IN',
  'ml' => 'ml-IN',
  'mr' => 'mr-IN',
  'gu' => 'gu-IN',
  'pa' => 'pa-IN',
  'or' => 'or-IN',
  'as' => 'as-IN',
  'ur' => 'ur-IN',
  'ne' => 'ne-IN',
  _ => 'en-IN',
};
