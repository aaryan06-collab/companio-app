import 'dart:convert';
import 'dart:io';

/// One-off recovery for the locale dictionaries.
///
/// A previous maintenance pass round-tripped the files through PowerShell
/// `Get-Content` (ANSI/cp1252) + `Set-Content -Encoding UTF8`, which
/// re-encoded the original UTF-8 bytes as Latin-1-style characters
/// (double-encoding / mojibake) and added a UTF-8 BOM.
///
/// This script reverses that damage: it decodes each file, maps every
/// suspicious Latin-1-range character back to its original byte, re-decodes
/// as UTF-8, and rewrites the files without a BOM. Values that are already
/// clean (or that mix real accented characters with mojibake) are left
/// untouched and reported to `tool/edge_report.txt` for manual review.
///
/// Run with: `dart run tool/recover_locales.dart`
Future<void> main() async {
  final dir = Directory('lib/core/localization/strings');
  final entries = await dir.list().toList();
  final files = entries
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart') && f.path.contains('strings_'))
      .toList();
  files.sort((a, b) => a.path.compareTo(b.path));

  final edges = <String>[];
  final report = StringBuffer();
  for (final f in files) {
    final name = f.uri.pathSegments.last;
    final lang = name.replaceFirst('strings_', '').replaceFirst('.dart', '');
    final original = utf8.decode(_stripBom(await f.readAsBytes()));
    final result = _process(original, lang, edges);
    if (result.fixed > 0) {
      await f.writeAsString(result.text, encoding: utf8);
    }
    final now = utf8.decode(_stripBom(await f.readAsBytes()));
    final nNative = now.runes.where(_nativeFor(lang)).length;
    final nSusp = now.runes.where(_isSuspicious).length;
    report.writeln(
      '$name: fixed=${result.fixed} native=$nNative suspicious=$nSusp',
    );
  }
  stdout.writeln(report.toString());
  File(
    'tool/edge_report.txt',
  ).writeAsStringSync(edges.isEmpty ? '(no edges)\n' : '${edges.join('\n')}\n');
  stdout.writeln('Edge cases -> tool/edge_report.txt (${edges.length})');
}

({String text, int fixed}) _process(
  String text,
  String lang,
  List<String> edges,
) {
  final native = _nativeFor(lang);
  final latin = _latinLangs.contains(lang);
  final us = text.codeUnits;
  final out = StringBuffer();
  var fixed = 0;
  var prev = 0;
  var i = 0;
  var inString = false;
  var esc = false;
  var start = 0;
  while (i < us.length) {
    final c = us[i];
    if (inString) {
      if (esc) {
        esc = false;
      } else if (c == 0x5C) {
        esc = true;
      } else if (c == 0x27) {
        final content = text.substring(start + 1, i);
        final recovered = _recover(content, lang, native, latin, edges);
        if (recovered != null) {
          fixed++;
          out.write(text.substring(prev, start + 1));
          out.write(recovered);
          prev = i;
        }
        inString = false;
      }
    } else if (c == 0x27) {
      inString = true;
      start = i;
    }
    i++;
  }
  out.write(text.substring(prev));
  return (text: out.toString(), fixed: fixed);
}

/// Returns the reversed value, or null when the value should stay as-is
/// (clean text, mixed text, or an irrecoverable byte sequence).
String? _recover(
  String s,
  String lang,
  bool Function(int) native,
  bool latin,
  List<String> edges,
) {
  if (s.isEmpty || !s.runes.any(_isSuspicious)) return null;
  final nNative = s.runes.where(native).length;
  if (!latin && nNative > 0) {
    edges.add('$lang [mixed] $s');
    return null;
  }
  final reversed = _reverse(s);
  if (reversed == null || reversed.contains('\uFFFD')) {
    edges.add('$lang [skip] $s');
    return null;
  }
  return reversed;
}

String? _reverse(String s) {
  try {
    return utf8.decode(_reverseBytes(s), allowMalformed: false);
  } catch (_) {
    return null;
  }
}

List<int> _reverseBytes(String s) {
  final out = <int>[];
  for (final cp in s.runes) {
    if (cp < 0x80) {
      out.add(cp);
    } else if (_cp1252.containsKey(cp)) {
      out.add(_cp1252[cp]!);
    } else if (cp < 0x100) {
      out.add(cp);
    } else {
      _appendUtf8(out, cp);
    }
  }
  return out;
}

void _appendUtf8(List<int> bytes, int cp) {
  if (cp <= 0x7F) {
    bytes.add(cp);
  } else if (cp <= 0x7FF) {
    bytes.add(0xC0 | (cp >> 6));
    bytes.add(0x80 | (cp & 0x3F));
  } else if (cp <= 0xFFFF) {
    bytes.add(0xE0 | (cp >> 12));
    bytes.add(0x80 | ((cp >> 6) & 0x3F));
    bytes.add(0x80 | (cp & 0x3F));
  } else {
    bytes.add(0xF0 | (cp >> 18));
    bytes.add(0x80 | ((cp >> 12) & 0x3F));
    bytes.add(0x80 | ((cp >> 6) & 0x3F));
    bytes.add(0x80 | (cp & 0x3F));
  }
}

List<int> _stripBom(List<int> bytes) {
  if (bytes.length >= 3 &&
      bytes[0] == 0xEF &&
      bytes[1] == 0xBB &&
      bytes[2] == 0xBF) {
    return List.of(bytes.sublist(3));
  }
  return bytes;
}

bool _isSuspicious(int cp) =>
    (cp >= 0x80 && cp <= 0xFF) || _cp1252.containsKey(cp);

const Set<String> _latinLangs = {'en', 'kha', 'grt', 'lus'};

/// The script each language should be written in, used to protect clean
/// values while still reversing pure mojibake.
bool Function(int) _nativeFor(String lang) => switch (lang) {
  'en' || 'kha' || 'grt' || 'lus' => _latinNative,
  'hi' || 'mr' || 'ne' || 'brx' || 'sat' => _devanagari,
  'bn' || 'as' => _bengali,
  'mni' => _meiteiOrBengali,
  'gu' => _gujarati,
  'pa' => _gurmukhi,
  'or' => _oriya,
  'ta' => _tamil,
  'te' => _telugu,
  'kn' => _kannada,
  'ml' => _malayalam,
  'ur' => _arabic,
  _ => _none,
};

bool _latinNative(int cp) =>
    (cp >= 0x00C0 && cp <= 0x00FF) ||
    (cp >= 0x0100 && cp <= 0x017F) ||
    (cp >= 0x0180 && cp <= 0x024F) ||
    (cp >= 0x1E00 && cp <= 0x1EFF);

bool _devanagari(int cp) => cp >= 0x0900 && cp <= 0x097F;
bool _bengali(int cp) => cp >= 0x0980 && cp <= 0x09FF;
bool _meitei(int cp) => cp >= 0xABC0 && cp <= 0xABFF;
bool _meiteiOrBengali(int cp) => _bengali(cp) || _meitei(cp);
bool _gujarati(int cp) => cp >= 0x0A80 && cp <= 0x0AFF;
bool _gurmukhi(int cp) => cp >= 0x0A00 && cp <= 0x0A7F;
bool _oriya(int cp) => cp >= 0x0B00 && cp <= 0x0B7F;
bool _tamil(int cp) => cp >= 0x0B80 && cp <= 0x0BFF;
bool _telugu(int cp) => cp >= 0x0C00 && cp <= 0x0C7F;
bool _kannada(int cp) => cp >= 0x0C80 && cp <= 0x0CFF;
bool _malayalam(int cp) => cp >= 0x0D00 && cp <= 0x0D7F;
bool _arabic(int cp) => cp >= 0x0600 && cp <= 0x06FF;
bool _none(int cp) => false;

/// Windows code page 1252 -> byte for the single-byte assignments that differ
/// from plain Latin-1 (values in 0x80-0x9F).
const Map<int, int> _cp1252 = {
  0x20AC: 0x80,
  0x201A: 0x82,
  0x0192: 0x83,
  0x201E: 0x84,
  0x2026: 0x85,
  0x2020: 0x86,
  0x2021: 0x87,
  0x02C6: 0x88,
  0x2030: 0x89,
  0x0160: 0x8A,
  0x2039: 0x8B,
  0x0152: 0x8C,
  0x017D: 0x8E,
  0x2018: 0x91,
  0x2019: 0x92,
  0x201C: 0x93,
  0x201D: 0x94,
  0x2022: 0x95,
  0x2013: 0x96,
  0x2014: 0x97,
  0x02DC: 0x98,
  0x2122: 0x99,
  0x0161: 0x9A,
  0x203A: 0x9B,
  0x0153: 0x9C,
  0x017E: 0x9E,
  0x0178: 0x9F,
};
