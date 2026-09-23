import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// A stable per-installation identifier used by the sync layer so the
/// device can tell its own uploads apart from others'.
abstract final class DeviceId {
  static const String _fileName = 'companio_device_id.txt';

  static String? _webId;

  static Future<String> load() async {
    // Web has no file system; keep a session-stable id in memory.
    if (kIsWeb) return _webId ??= const Uuid().v4();
    final dir = await getApplicationSupportDirectory();
    final file = File('${dir.path}${Platform.pathSeparator}$_fileName');
    if (await file.exists()) {
      final existing = (await file.readAsString()).trim();
      if (existing.isNotEmpty) return existing;
    }
    final fresh = const Uuid().v4();
    await file.create(recursive: true);
    await file.writeAsString(fresh);
    return fresh;
  }
}
