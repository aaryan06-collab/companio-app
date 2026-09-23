import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// Auth state for the Companio backend (JWT + account context).
///
/// Persisted to the app support directory so an app restart can resume
/// talking to the server without asking for credentials again. When the
/// backend is not configured (no `COMPANIO_API_URL` dart-define) this is
/// never written and the app keeps its fully-offline demo mode.
class ServerSession {
  const ServerSession({
    required this.token,
    required this.accountId,
    required this.role,
    required this.name,
    this.pairingCode,
    this.linkedPatientId,
    this.linkedPatientName,
    this.linkedCaregiverName,
  });

  final String token;
  final String accountId;
  final String role;
  final String name;

  /// Patient-only: the code a caregiver enters to "link" to the family.
  final String? pairingCode;

  /// Caregiver-only: the server patient account currently being cared for.
  final String? linkedPatientId;
  final String? linkedPatientName;

  /// Patient-only: the family caregiver currently looking after them.
  final String? linkedCaregiverName;

  bool get isCaregiver => role == 'caregiver';
  bool get isPatient => role == 'patient';
  bool get hasPatient => linkedPatientId != null;

  Map<String, Object?> toJson() => {
    'token': token,
    'accountId': accountId,
    'role': role,
    'name': name,
    'pairingCode': pairingCode,
    'linkedPatientId': linkedPatientId,
    'linkedPatientName': linkedPatientName,
    'linkedCaregiverName': linkedCaregiverName,
  };

  factory ServerSession.fromJson(Map<String, Object?> json) => ServerSession(
    token: (json['token'] as String?) ?? '',
    accountId: (json['accountId'] as String?) ?? '',
    role: (json['role'] as String?) ?? 'patient',
    name: (json['name'] as String?) ?? '',
    pairingCode: json['pairingCode'] as String?,
    linkedPatientId: json['linkedPatientId'] as String?,
    linkedPatientName: json['linkedPatientName'] as String?,
    linkedCaregiverName: json['linkedCaregiverName'] as String?,
  );
}

/// Loads/saves the current [ServerSession] from disk.
class ServerSessionStore {
  static const String _fileName = 'companio_server_session.json';

  ServerSession? _cached;

  Future<File> _file() async {
    final dir = await getApplicationSupportDirectory();
    return File('${dir.path}${Platform.pathSeparator}$_fileName');
  }

  Future<ServerSession?> load() async {
    if (_cached != null) return _cached;
    if (kIsWeb) return null;
    try {
      final file = await _file();
      if (!await file.exists()) return null;
      final decoded = jsonDecode(await file.readAsString());
      if (decoded is Map<String, dynamic>) {
        final session = ServerSession.fromJson(
          decoded.map((k, v) => MapEntry(k, v as Object?)),
        );
        if (session.token.isNotEmpty) _cached = session;
      }
    } catch (_) {
      // Corrupt/missing session is fine — treated as signed-out.
    }
    return _cached;
  }

  Future<void> save(ServerSession session) async {
    _cached = session;
    if (kIsWeb) return;
    try {
      final file = await _file();
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(session.toJson()));
    } catch (_) {}
  }

  Future<void> clear() async {
    _cached = null;
    if (kIsWeb) return;
    try {
      final file = await _file();
      if (await file.exists()) await file.delete();
    } catch (_) {}
  }
}
