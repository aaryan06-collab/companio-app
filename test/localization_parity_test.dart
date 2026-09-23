import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:companio/core/localization/strings/strings_as.dart';
import 'package:companio/core/localization/strings/strings_bn.dart';
import 'package:companio/core/localization/strings/strings_brx.dart';
import 'package:companio/core/localization/strings/strings_en.dart';
import 'package:companio/core/localization/strings/strings_grt.dart';
import 'package:companio/core/localization/strings/strings_gu.dart';
import 'package:companio/core/localization/strings/strings_hi.dart';
import 'package:companio/core/localization/strings/strings_kha.dart';
import 'package:companio/core/localization/strings/strings_kn.dart';
import 'package:companio/core/localization/strings/strings_lus.dart';
import 'package:companio/core/localization/strings/strings_ml.dart';
import 'package:companio/core/localization/strings/strings_mni.dart';
import 'package:companio/core/localization/strings/strings_mr.dart';
import 'package:companio/core/localization/strings/strings_ne.dart';
import 'package:companio/core/localization/strings/strings_or.dart';
import 'package:companio/core/localization/strings/strings_pa.dart';
import 'package:companio/core/localization/strings/strings_sat.dart';
import 'package:companio/core/localization/strings/strings_ta.dart';
import 'package:companio/core/localization/strings/strings_te.dart';
import 'package:companio/core/localization/strings/strings_ur.dart';

/// Guards the localization dictionaries against three regressions:
/// 1. Drift between the `L10nKeys` manifest and the English source.
/// 2. Missing/extra/empty keys or mismatched `{placeholder}` tokens across
///    all 20 dictionaries.
/// 3. Encoding corruption (mojibake / U+FFFD / vanished native scripts),
///    which would otherwise silently display garbled text in the app.
void main() {
  final all = <String, Map<String, String>>{
    'en': stringsEn,
    'hi': stringsHi,
    'as': stringsAs,
    'bn': stringsBn,
    'brx': stringsBrx,
    'ne': stringsNe,
    'kha': stringsKha,
    'grt': stringsGrt,
    'lus': stringsLus,
    'mni': stringsMni,
    'mr': stringsMr,
    'gu': stringsGu,
    'pa': stringsPa,
    'or': stringsOr,
    'ta': stringsTa,
    'te': stringsTe,
    'kn': stringsKn,
    'ml': stringsMl,
    'ur': stringsUr,
    'sat': stringsSat,
  };

  const en = stringsEn;

  test('l10n_keys.dart manifest matches the English dictionary', () {
    final source = File('lib/core/localization/l10n_keys.dart')
        .readAsStringSync();
    final constants = RegExp(r"static const (\w+) = '([^']+)';")
        .allMatches(source)
        .toList();
    expect(
      constants.length,
      en.length,
      reason:
          'l10n_keys has ${constants.length} keys, English has '
          '${en.length}',
    );
    final fromManifest = <String, String>{};
    for (final m in constants) {
      expect(
        m.group(1),
        m.group(2),
        reason:
            'constant name must equal its string value in '
            'l10n_keys.dart',
      );
      fromManifest[m.group(2)!] = m.group(1)!;
    }
    expect(
      fromManifest.keys.toSet(),
      en.keys.toSet(),
      reason: 'L10nKeys keys differ from the English dictionary',
    );
  });

  for (final entry in all.entries) {
    final lang = entry.key;
    final dict = entry.value;
    test('$lang dictionary matches English keys, values and placeholders', () {
      expect(
        dict.length,
        en.length,
        reason: '$lang has ${dict.length} keys, English has ${en.length}',
      );
      for (final key in en.keys) {
        expect(
          dict.containsKey(key),
          isTrue,
          reason: '$lang is missing key $key',
        );
      }
      for (final key in dict.keys) {
        expect(en.containsKey(key), isTrue, reason: '$lang has extra key $key');
      }
      for (final key in en.keys) {
        final value = dict[key]!;
        expect(value.trim(), isNotEmpty, reason: '$lang.$key is empty');
        expect(
          _tokens(value),
          _tokens(en[key]!),
          reason:
              '$lang.$key has different {placeholder} tokens '
              'than English',
        );
      }
    });
  }

  test('no dictionary contains replacement characters (U+FFFD)', () {
    for (final e in all.entries) {
      for (final value in e.value.values) {
        expect(
          value.contains('\uFFFD'),
          isFalse,
          reason: '${e.key} contains U+FFFD',
        );
      }
    }
  });

  test('scripts are intact (no mojibake regression)', () {
    for (final e in all.entries) {
      final x = _ScriptCheck.forLanguage(e.key);
      if (x == null) continue;
      final count = e.value.values.fold<int>(
        0,
        (sum, v) => sum + v.runes.where(x.isNative).length,
      );
      expect(
        count,
        greaterThanOrEqualTo(x.minimum),
        reason:
            '${e.key} has only $count characters in its native '
            'script (${x.name}) — likely encoding corruption',
      );
    }
  });
}

final _tokenPattern = RegExp(r'\{(\w+)\}');

Set<String> _tokens(String s) =>
    _tokenPattern.allMatches(s).map((m) => m.group(1)!).toSet();

class _ScriptCheck {
  const _ScriptCheck(this.name, this.minimum, this.isNative);

  final String name;
  final int minimum;
  final bool Function(int rune) isNative;

  static _ScriptCheck? forLanguage(String lang) {
    final checks = <String, _ScriptCheck>{
      'hi': _ScriptCheck('Devanagari', 500, (r) => r >= 0x0900 && r <= 0x097F),
      'mr': _ScriptCheck('Devanagari', 500, (r) => r >= 0x0900 && r <= 0x097F),
      'ne': _ScriptCheck('Devanagari', 500, (r) => r >= 0x0900 && r <= 0x097F),
      'brx': _ScriptCheck('Devanagari', 500, (r) => r >= 0x0900 && r <= 0x097F),
      'sat': _ScriptCheck('Devanagari', 500, (r) => r >= 0x0900 && r <= 0x097F),
      'bn': _ScriptCheck('Bengali', 500, (r) => r >= 0x0980 && r <= 0x09FF),
      'as': _ScriptCheck('Bengali', 500, (r) => r >= 0x0980 && r <= 0x09FF),
      'mni': _ScriptCheck(
        'Bengali/Meitei',
        500,
        (r) => (r >= 0x0980 && r <= 0x09FF) || (r >= 0xABC0 && r <= 0xABFF),
      ),
      'gu': _ScriptCheck('Gujarati', 500, (r) => r >= 0x0A80 && r <= 0x0AFF),
      'pa': _ScriptCheck('Gurmukhi', 500, (r) => r >= 0x0A00 && r <= 0x0A7F),
      'or': _ScriptCheck('Oriya', 500, (r) => r >= 0x0B00 && r <= 0x0B7F),
      'ta': _ScriptCheck('Tamil', 500, (r) => r >= 0x0B80 && r <= 0x0BFF),
      'te': _ScriptCheck('Telugu', 500, (r) => r >= 0x0C00 && r <= 0x0C7F),
      'kn': _ScriptCheck('Kannada', 500, (r) => r >= 0x0C80 && r <= 0x0CFF),
      'ml': _ScriptCheck('Malayalam', 500, (r) => r >= 0x0D00 && r <= 0x0D7F),
      'ur': _ScriptCheck('Arabic', 500, (r) => r >= 0x0600 && r <= 0x06FF),
    };
    return checks[lang];
  }
}
