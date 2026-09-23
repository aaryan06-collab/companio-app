import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// Persists the caregiver's chosen UI language on this device so the choice
/// survives restarts (caregiver accounts have no patient preferences row).
abstract final class CaregiverLocaleStore {
  static const String _fileName = 'companio_caregiver_language.txt';

  static Future<String?> load() async {
    if (kIsWeb) return null;
    try {
      final dir = await getApplicationSupportDirectory();
      final file = File('${dir.path}${Platform.pathSeparator}$_fileName');
      if (await file.exists()) {
        final value = (await file.readAsString()).trim();
        if (value.isNotEmpty) return value;
      }
    } catch (_) {}
    return null;
  }

  static Future<void> save(String code) async {
    if (kIsWeb) return;
    try {
      final dir = await getApplicationSupportDirectory();
      final file = File('${dir.path}${Platform.pathSeparator}$_fileName');
      await file.create(recursive: true);
      await file.writeAsString(code);
    } catch (_) {}
  }
}
