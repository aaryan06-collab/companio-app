import 'package:flutter/material.dart';

import 'languages.dart';
import 'strings/strings_as.dart';
import 'strings/strings_bn.dart';
import 'strings/strings_brx.dart';
import 'strings/strings_en.dart';
import 'strings/strings_grt.dart';
import 'strings/strings_gu.dart';
import 'strings/strings_hi.dart';
import 'strings/strings_kha.dart';
import 'strings/strings_kn.dart';
import 'strings/strings_lus.dart';
import 'strings/strings_ml.dart';
import 'strings/strings_mni.dart';
import 'strings/strings_mr.dart';
import 'strings/strings_ne.dart';
import 'strings/strings_or.dart';
import 'strings/strings_pa.dart';
import 'strings/strings_sat.dart';
import 'strings/strings_ta.dart';
import 'strings/strings_te.dart';
import 'strings/strings_ur.dart';

/// Lightweight localization dictionary for Companio, backed by the
/// per-language maps in `strings/`. Any missing key falls back to English,
/// then to the key itself. Each language is one entry in [_all]; add new
/// languages by writing a `strings_<code>.dart` map and registering it here.
class AppLocalizations {
  const AppLocalizations._(this.locale, this._dictionary);

  final Locale locale;
  final Map<String, String> _dictionary;

  static const AppLocalizations en = AppLocalizations._(
    Locale('en'),
    stringsEn,
  );

  static const String fallbackLanguageCode = 'en';

  static const Map<String, AppLocalizations> _all = {
    'en': AppLocalizations._(Locale('en'), stringsEn),
    'hi': AppLocalizations._(Locale('hi'), stringsHi),
    'as': AppLocalizations._(Locale('as'), stringsAs),
    'bn': AppLocalizations._(Locale('bn'), stringsBn),
    'brx': AppLocalizations._(Locale('brx'), stringsBrx),
    'ne': AppLocalizations._(Locale('ne'), stringsNe),
    'kha': AppLocalizations._(Locale('kha'), stringsKha),
    'grt': AppLocalizations._(Locale('grt'), stringsGrt),
    'lus': AppLocalizations._(Locale('lus'), stringsLus),
    'mni': AppLocalizations._(Locale('mni'), stringsMni),
    'mr': AppLocalizations._(Locale('mr'), stringsMr),
    'gu': AppLocalizations._(Locale('gu'), stringsGu),
    'pa': AppLocalizations._(Locale('pa'), stringsPa),
    'or': AppLocalizations._(Locale('or'), stringsOr),
    'ta': AppLocalizations._(Locale('ta'), stringsTa),
    'te': AppLocalizations._(Locale('te'), stringsTe),
    'kn': AppLocalizations._(Locale('kn'), stringsKn),
    'ml': AppLocalizations._(Locale('ml'), stringsMl),
    'ur': AppLocalizations._(Locale('ur'), stringsUr),
    'sat': AppLocalizations._(Locale('sat'), stringsSat),
  };

  /// All supported locales, in picker order (see [appLanguages]).
  static final List<Locale> supportedLocales = appLanguages
      .map((l) => l.locale)
      .toList(growable: false);

  /// Looks up [key], substituting {placeholder} values from [args].
  /// Unknown keys and unsupported languages always resolve to English/demo-key.
  String t(String key, [Map<String, String>? args]) {
    var text = _dictionary[key] ?? stringsEn[key] ?? key;
    args?.forEach((k, v) {
      text = text.replaceAll('{$k}', v);
    });
    return text;
  }

  /// Resolves the localization for the normalised [code] (e.g. 'hi-in' -> hi).
  static AppLocalizations forLanguageCode(String code) {
    final c = code.toLowerCase();
    final base = c.contains('-') ? c.substring(0, c.indexOf('-')) : c;
    return _all[base] ?? en;
  }

  /// Tracks whether [code] has its own dictionary entry (not just English).
  static bool hasLanguageCode(String code) =>
      _all.containsKey(code.toLowerCase());

  static AppLocalizations of(BuildContext context) {
    final loc = Localizations.of<AppLocalizations>(context, AppLocalizations);
    return loc ?? en;
  }
}
