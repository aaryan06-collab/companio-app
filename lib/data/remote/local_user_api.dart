import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'companio_api.dart';

/// Offline-first implementation of [CompanioApi].
///
/// Instead of a real server, changes are stored in a JSON "inbox" file on the
/// device. This gives the app a real, idempotent, persistent sync path that
/// is fully testable and demos offline → reconnect flows, while the same
/// interface can later be backed by FastAPI without touching app code.
class LocalUserApi implements CompanioApi {
  LocalUserApi({
    required String deviceId,
    Future<bool> Function()? reachability,
  }) : _deviceId = deviceId,
       _reachability = reachability;

  final String _deviceId;
  final Future<bool> Function()? _reachability;

  static const String inboxFileName = 'companio_remote_inbox.json';

  /// Web has no file system; keep the inbox in memory (non-persistent).
  static List<Map<String, Object?>> _webInbox = [];

  /// Simulates the caregiver-on-another-device scenario.
  String get caregiverDeviceId => 'caregiver-device';

  @override
  String get deviceId => _deviceId;

  @override
  Future<bool> isReachable() async {
    if (_reachability != null) return _reachability();
    return true;
  }

  Future<File> _inboxFile() async {
    final dir = await getApplicationSupportDirectory();
    return File('${dir.path}${Platform.pathSeparator}$inboxFileName');
  }

  Future<List<Map<String, Object?>>> _readAll() async {
    if (kIsWeb) return List.of(_webInbox);
    final file = await _inboxFile();
    if (!await file.exists()) return [];
    try {
      final raw = await file.readAsString();
      final decoded = jsonDecode(raw);
      if (decoded is List) return decoded.cast<Map<String, Object?>>();
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<void> _writeAll(List<Map<String, Object?>> records) async {
    if (kIsWeb) {
      _webInbox = List.of(records);
      return;
    }
    final file = await _inboxFile();
    await file.create(recursive: true);
    await file.writeAsString(jsonEncode(records));
  }

  @override
  Future<Set<String>> push(List<CompanioRecord> records) async {
    if (records.isEmpty) return {};
    final all = await _readAll();
    final knownKeys = all
        .map((e) => (e['idempotencyKey'] as String?) ?? '')
        .toSet();

    final accepted = <String>{};
    for (final record in records) {
      if (knownKeys.contains(record.idempotencyKey)) {
        // Idempotent: already delivered on a previous attempt.
        accepted.add(record.idempotencyKey);
        continue;
      }
      all.add(record.toJson());
      knownKeys.add(record.idempotencyKey);
      accepted.add(record.idempotencyKey);
    }
    await _writeAll(all);
    return accepted;
  }

  @override
  Future<List<CompanioRecord>> pull() async {
    final all = await _readAll();
    return all
        .map(CompanioRecord.fromJson)
        .where((r) => r.entityType == 'memory' || r.entityType == 'contact')
        .toList();
  }

  /// Helper used by the demo caregiver flow: publish a family memory from a
  /// "different device".
  Future<void> publishFromCaregiver(CompanioRecord record) async {
    final all = await _readAll();
    all.add(record.toJson());
    await _writeAll(all);
  }
}
