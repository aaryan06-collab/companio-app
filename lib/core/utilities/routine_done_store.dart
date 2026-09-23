import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// Persists which routine (reminder) checkboxes the patient has ticked, in a
/// per-device file, so the ticks survive app restarts.
abstract final class RoutineDoneStore {
  static const String _fileName = 'companio_routine_done.json';

  static Future<Set<String>> load() async {
    if (kIsWeb) return {};
    try {
      final dir = await getApplicationSupportDirectory();
      final file = File('${dir.path}${Platform.pathSeparator}$_fileName');
      if (await file.exists()) {
        final decoded = jsonDecode(await file.readAsString());
        if (decoded is List) {
          return decoded.whereType<String>().toSet();
        }
      }
    } catch (_) {}
    return {};
  }

  static Future<void> save(Set<String> ids) async {
    if (kIsWeb) return;
    try {
      final dir = await getApplicationSupportDirectory();
      final file = File('${dir.path}${Platform.pathSeparator}$_fileName');
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(ids.toList()));
    } catch (_) {}
  }
}