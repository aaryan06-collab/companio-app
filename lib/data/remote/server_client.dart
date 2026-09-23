import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'companio_api.dart';
import 'server_session.dart';

/// The backend answered with a non-2xx status (auth rejected, bad request...).
class ServerException implements Exception {
  const ServerException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  bool get isUnauthorized => statusCode == 401 || statusCode == 403;

  @override
  String toString() => 'ServerException($statusCode): $message';
}

/// Could not reach the backend at all (offline, DNS, timeout).
class ServerUnreachableException implements Exception {
  const ServerUnreachableException(this.message);

  final String message;

  @override
  String toString() => 'ServerUnreachableException: $message';
}

/// Result of an auth operation (signup/login/link/register-device).
class ServerAuthResult {
  const ServerAuthResult({
    required this.token,
    required this.accountId,
    required this.role,
    required this.name,
    this.pairingCode,
    this.linkedPatientId,
    this.linkedPatientName,
    this.linkedCaregiverName,
  });

  factory ServerAuthResult.fromJson(Map<String, dynamic> json) =>
      ServerAuthResult(
        token: (json['token'] as String?) ?? '',
        accountId: (json['accountId'] as String?) ?? '',
        role: (json['role'] as String?) ?? 'patient',
        name: (json['name'] as String?) ?? '',
        pairingCode: json['pairingCode'] as String?,
        linkedPatientId: json['linkedPatientId'] as String?,
        linkedPatientName: json['linkedPatientName'] as String?,
        linkedCaregiverName: json['linkedCaregiverName'] as String?,
      );

  final String token;
  final String accountId;
  final String role;
  final String name;
  final String? pairingCode;
  final String? linkedPatientId;
  final String? linkedPatientName;
  final String? linkedCaregiverName;

  ServerSession toSession() => ServerSession(
    token: token,
    accountId: accountId,
    role: role,
    name: name,
    pairingCode: pairingCode,
    linkedPatientId: linkedPatientId,
    linkedPatientName: linkedPatientName,
    linkedCaregiverName: linkedCaregiverName,
  );
}

class ServerAlert {
  const ServerAlert({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.status,
    required this.startedAt,
    this.acknowledgedAt,
    this.acknowledgedBy,
  });

  factory ServerAlert.fromJson(Map<String, dynamic> json) => ServerAlert(
    id: (json['id'] as String?) ?? '',
    patientId: (json['patientId'] as String?) ?? '',
    patientName: (json['patientName'] as String?) ?? '',
    status: (json['status'] as String?) ?? 'active',
    startedAt: (json['startedAt'] as String?) ?? '',
    acknowledgedAt: json['acknowledgedAt'] as String?,
    acknowledgedBy: json['acknowledgedBy'] as String?,
  );

  final String id;
  final String patientId;
  final String patientName;
  final String status;
  final String startedAt;
  final String? acknowledgedAt;
  final String? acknowledgedBy;

  bool get acknowledged => status == 'acknowledged';
}

class ServerModelCard {
  const ServerModelCard({
    this.deployed = false,
    this.trainedAt,
    this.demoSamples = 0,
    this.realSamples = 0,
    this.holdoutAccuracy,
    this.baselineAccuracy,
    this.domains = const [],
    this.message = '',
  });

  factory ServerModelCard.fromJson(Map<String, dynamic> json) =>
      ServerModelCard(
        deployed: (json['deployed'] as bool?) ?? false,
        trainedAt: json['trainedAt'] as String?,
        demoSamples: (json['demoSamples'] as num?)?.toInt() ?? 0,
        realSamples: (json['realSamples'] as num?)?.toInt() ?? 0,
        holdoutAccuracy: (json['holdoutAccuracy'] as num?)?.toDouble(),
        baselineAccuracy: (json['baselineAccuracy'] as num?)?.toDouble(),
        domains: (json['domains'] as List?)?.cast<String>() ?? const [],
        message: (json['message'] as String?) ?? '',
      );

  final bool deployed;
  final String? trainedAt;
  final int demoSamples;
  final int realSamples;
  final double? holdoutAccuracy;
  final double? baselineAccuracy;
  final List<String> domains;
  final String message;

  String get accuracyLabel => holdoutAccuracy == null
      ? '—'
      : '${(holdoutAccuracy! * 100).toStringAsFixed(0)}%';
}

class ServerDomainPoint {
  const ServerDomainPoint({
    required this.date,
    required this.attempts,
    required this.correct,
    required this.accuracy,
  });

  factory ServerDomainPoint.fromJson(Map<String, dynamic> json) =>
      ServerDomainPoint(
        date: (json['date'] as String?) ?? '',
        attempts: (json['attempts'] as num?)?.toInt() ?? 0,
        correct: (json['correct'] as num?)?.toInt() ?? 0,
        accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0,
      );

  final String date;
  final int attempts;
  final int correct;
  final double accuracy;
}

class ServerDomainSeries {
  const ServerDomainSeries({required this.category, required this.points});

  factory ServerDomainSeries.fromJson(Map<String, dynamic> json) =>
      ServerDomainSeries(
        category: (json['category'] as String?) ?? '',
        points: (json['points'] as List? ?? const [])
            .map((e) => ServerDomainPoint.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  final String category;
  final List<ServerDomainPoint> points;
}

class ServerEngagementDay {
  const ServerEngagementDay({
    required this.date,
    required this.completed,
    required this.started,
  });

  factory ServerEngagementDay.fromJson(Map<String, dynamic> json) =>
      ServerEngagementDay(
        date: (json['date'] as String?) ?? '',
        completed: (json['completed'] as num?)?.toInt() ?? 0,
        started: (json['started'] as num?)?.toInt() ?? 0,
      );

  final String date;
  final int completed;
  final int started;
}

class ServerAnalytics {
  const ServerAnalytics({
    required this.patientId,
    required this.patientName,
    this.series = const [],
    this.engagement = const [],
    this.totalAttempts = 0,
    this.completedThisWeek = 0,
    this.weekGoal = 0,
    this.streakDays = 0,
    this.model = const ServerModelCard(),
  });

  factory ServerAnalytics.fromJson(Map<String, dynamic> json) =>
      ServerAnalytics(
        patientId: (json['patientId'] as String?) ?? '',
        patientName: (json['patientName'] as String?) ?? '',
        series: (json['series'] as List? ?? const [])
            .map((e) => ServerDomainSeries.fromJson(e as Map<String, dynamic>))
            .toList(),
        engagement: (json['engagement'] as List? ?? const [])
            .map((e) => ServerEngagementDay.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalAttempts: (json['totalAttempts'] as num?)?.toInt() ?? 0,
        completedThisWeek: (json['completedThisWeek'] as num?)?.toInt() ?? 0,
        weekGoal: (json['weekGoal'] as num?)?.toInt() ?? 0,
        streakDays: (json['streakDays'] as num?)?.toInt() ?? 0,
        model: ServerModelCard.fromJson(
          (json['model'] as Map<String, dynamic>?) ?? const {},
        ),
      );

  final String patientId;
  final String patientName;
  final List<ServerDomainSeries> series;
  final List<ServerEngagementDay> engagement;
  final int totalAttempts;
  final int completedThisWeek;
  final int weekGoal;
  final int streakDays;
  final ServerModelCard model;

  /// The domain with the most attempts (plotted by default).
  ServerDomainSeries? get topSeries {
    if (series.isEmpty) return null;
    return series.reduce(
      (a, b) =>
          a.points.fold<int>(0, (s, p) => s + p.attempts) >=
              b.points.fold<int>(0, (s, p) => s + p.attempts)
          ? a
          : b,
    );
  }
}

/// Thin HTTP wrapper around the Companio FastAPI backend.
///
/// The base URL comes from the `COMPANIO_API_URL` dart-define:
///
///     flutter run --dart-define=COMPANIO_API_URL=http://192.168.0.10:8000
///
/// When it is absent [enabled] is false and the app stays fully offline.
class ServerClient {
  ServerClient({String? baseUrl, http.Client? httpClient})
    : _baseUrl = baseUrl ?? _defaultBaseUrl,
      _http = httpClient ?? http.Client();

  static const String _defaultBaseUrl = String.fromEnvironment(
    'COMPANIO_API_URL',
  );

  final String _baseUrl;
  final http.Client _http;
  static const Duration _timeout = Duration(seconds: 30);

  bool get enabled =>
      _baseUrl.trim().isNotEmpty && !_baseUrl.startsWith('http://localhost:0');

  String get baseUrl => _baseUrl;

  Uri _uri(String path, [Map<String, String>? query]) {
    final base = _baseUrl.endsWith('/')
        ? _baseUrl.substring(0, _baseUrl.length - 1)
        : _baseUrl;
    return Uri.parse('$base$path').replace(queryParameters: query);
  }

  Map<String, String> _headers(String? token) => {
    'Content-Type': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };

  /// Executes a request. Returns decoded JSON for 2xx, throws [ServerException]
  /// on a rejected request, and [ServerUnreachableException] on network loss.
  ///
  /// Transport errors (timeouts / refused connections) are retried with
  /// backoff so a cold-started backend (e.g. Render free tier spinning up)
  /// has time to boot before the app reports it offline. Retries are safe:
  /// writes carry idempotency keys and server-side duplicate guards.
  Future<Object?> _send(
    Future<http.Response> Function() request, {
    int attempts = 3,
    Duration backoff = const Duration(seconds: 2),
  }) async {
    Object? lastError;
    for (var attempt = 0; attempt < attempts; attempt++) {
      if (attempt > 0) {
        await Future<void>.delayed(backoff * attempt);
      }
      try {
        final response = await request().timeout(_timeout);
        if (response.statusCode < 200 || response.statusCode >= 300) {
          throw ServerException(
            _bodyOrMessage(response),
            statusCode: response.statusCode,
          );
        }
        if (response.body.isEmpty) return null;
        return jsonDecode(response.body);
      } on ServerException {
        rethrow;
      } on FormatException {
        rethrow; // Malformed body — retrying won't change the payload.
      } on TimeoutException catch (e) {
        lastError = e;
      } on http.ClientException catch (e) {
        lastError = e;
      }
    }
    if (lastError is TimeoutException) {
      throw const ServerUnreachableException('Request timed out');
    }
    throw ServerUnreachableException(
      (lastError as http.ClientException?)?.message ?? 'Backend unreachable',
    );
  }

  static String _bodyOrMessage(http.Response response) {
    final body = response.body.trim();
    if (body.isEmpty) return 'HTTP ${response.statusCode}';
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic> && decoded['detail'] is String) {
        return decoded['detail'] as String;
      }
    } catch (_) {}
    return body.length > 200 ? body.substring(0, 200) : body;
  }

  // ── Auth ──────────────────────────────────────────────────────────────
  Future<ServerAuthResult?> signup({
    required String username,
    required String password,
    required String name,
    required String role,
  }) async {
    if (!enabled) return null;
    final body = await _send(
      () => _http.post(
        _uri('/auth/signup'),
        headers: _headers(null),
        body: jsonEncode({
          'username': username,
          'password': password,
          'name': name,
          'role': role,
        }),
      ),
    );
    if (body is Map<String, dynamic>) {
      return ServerAuthResult.fromJson(body);
    }
    return null;
  }

  Future<ServerAuthResult?> login({
    required String username,
    required String password,
  }) async {
    if (!enabled) return null;
    final body = await _send(
      () => _http.post(
        _uri('/auth/login'),
        headers: _headers(null),
        body: jsonEncode({'username': username, 'password': password}),
      ),
    );
    if (body is Map<String, dynamic>) {
      return ServerAuthResult.fromJson(body);
    }
    return null;
  }

  Future<ServerAuthResult?> registerDevice({
    required String deviceId,
    String? patientId,
    required String token,
  }) async {
    if (!enabled) return null;
    final body = await _send(
      () => _http.post(
        _uri('/auth/register-device'),
        headers: _headers(token),
        body: jsonEncode({'deviceId': deviceId, 'patientId': patientId}),
      ),
    );
    if (body is Map<String, dynamic>) {
      return ServerAuthResult.fromJson(body);
    }
    return null;
  }

  Future<ServerAuthResult?> link({
    required String pairingCode,
    String? relationship,
    required String token,
  }) async {
    if (!enabled) return null;
    final body = await _send(
      () => _http.post(
        _uri('/auth/link'),
        headers: _headers(token),
        body: jsonEncode({
          'pairingCode': pairingCode,
          'relationship': relationship,
        }),
      ),
    );
    if (body is Map<String, dynamic>) {
      return ServerAuthResult.fromJson(body);
    }
    return null;
  }

  Future<ServerAuthResult?> me(String token) async {
    if (!enabled) return null;
    final body = await _send(
      () => _http.get(_uri('/auth/me'), headers: _headers(token)),
    );
    if (body is Map<String, dynamic>) {
      return ServerAuthResult.fromJson(body);
    }
    return null;
  }

  // ── Sync ───────────────────────────────────────────────────────────────
  Future<Set<String>> pushRecords(
    List<CompanioRecord> records, {
    required String token,
    required String deviceId,
  }) async {
    if (!enabled) return const {};
    final body = await _send(
      () => _http.post(
        _uri('/sync/push'),
        headers: _headers(token),
        body: jsonEncode({'records': records.map((r) => r.toJson()).toList()}),
      ),
    );
    if (body is Map<String, dynamic>) {
      final accepted = (body['accepted'] as List? ?? const [])
          .map((v) => v as String)
          .toSet();
      if (accepted.isNotEmpty) return accepted;
    }
    // Empty accept means nothing was stored; nothing to mark synced.
    return const {};
  }

  Future<List<CompanioRecord>> pullRecords({
    required String token,
    required String deviceId,
  }) async {
    if (!enabled) return const [];
    final body = await _send(
      () => _http.get(
        _uri('/sync/pull', {'deviceId': deviceId, 'limit': '200'}),
        headers: _headers(token),
      ),
    );
    if (body is Map<String, dynamic>) {
      final records = (body['records'] as List? ?? const []);
      return records
          .whereType<Map>()
          .map((e) => CompanioRecord.fromJson(e.cast<String, Object?>()))
          .toList();
    }
    return const [];
  }

  // ── SOS ────────────────────────────────────────────────────────────────
  Future<List<ServerAlert>> alerts(String token) async {
    if (!enabled) return const [];
    try {
      final body = await _send(
        () => _http.get(_uri('/sos/alerts'), headers: _headers(token)),
      );
      if (body is List) {
        return body
            .whereType<Map>()
            .map((e) => ServerAlert.fromJson(e.cast<String, dynamic>()))
            .toList();
      }
    } on ServerException {
      // Rejected polls just report nothing.
    } on ServerUnreachableException {
      // Offline dashboard keeps working with the last known data.
    }
    return const [];
  }

  Future<bool> ackSos(String incidentId, {required String token}) async {
    if (!enabled) return false;
    try {
      final body = await _send(
        () => _http.post(
          _uri('/sos/ack'),
          headers: _headers(token),
          body: jsonEncode({'incidentId': incidentId}),
        ),
      );
      return body is Map<String, dynamic>;
    } catch (_) {
      return false;
    }
  }

  // ── Media (caregiver photo memories) ───────────────────────────────────
  /// Uploads the image file at [localPath] to the server. Returns the
  /// server-relative media path (e.g. ``/media/<id>.png``) or null on any
  /// failure (offline, rejected). The sync engine retries failed photos.
  Future<String?> uploadMemoryPhoto({
    required String localPath,
    required String token,
    required String deviceId,
  }) async {
    if (!enabled) return null;
    try {
      final request = http.MultipartRequest(
        'POST',
        _uri('/media/upload'),
      )
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['deviceId'] = deviceId
        ..files.add(
          await http.MultipartFile.fromPath('file', localPath),
        );
      final streamed = await request.send().timeout(_timeout);
      final response = await http.Response.fromStream(streamed);
      if (response.statusCode < 200 || response.statusCode >= 300) return null;
      final body = jsonDecode(response.body);
      if (body is Map<String, dynamic>) return body['url'] as String?;
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Turns a server-relative media path into an absolute URL the app can
  /// load, preserving any already-absolute URL.
  String resolveMediaUrl(String path) {
    if (path.startsWith('http')) return path;
    final base = _baseUrl.endsWith('/')
        ? _baseUrl.substring(0, _baseUrl.length - 1)
        : _baseUrl;
    return Uri.parse('$base$path').toString();
  }

  // ── Analytics ──────────────────────────────────────────────────────────
  Future<ServerAnalytics?> analyticsFor(
    String patientId, {
    required String token,
  }) async {
    if (!enabled) return null;
    try {
      final body = await _send(
        () => _http.get(
          _uri('/analytics/patient/$patientId'),
          headers: _headers(token),
        ),
      );
      if (body is Map<String, dynamic>) {
        return ServerAnalytics.fromJson(body);
      }
    } catch (_) {}
    return null;
  }

  /// Rich per-range analytics for a linked patient (used by the caregiver
  /// Progress screen). Falls back to `null` when offline/unreachable.
  Future<Map<String, dynamic>?> analyticsDetail(
    String patientId, {
    required String range,
    required String token,
  }) async {
    if (!enabled) return null;
    try {
      final body = await _send(
        () => _http.get(
          _uri('/analytics/patient/$patientId/detail?range=$range'),
          headers: _headers(token),
        ),
      );
      if (body is Map<String, dynamic>) return body;
    } catch (_) {}
    return null;
  }

  // ── Health / ML demo surface ──────────────────────────────────────────
  Future<bool> isReachable() async {
    if (!enabled) return false;
    try {
      final response = await _http
          .get(_uri('/health'))
          .timeout(const Duration(seconds: 15));
      return response.statusCode >= 200 && response.statusCode < 500;
    } catch (_) {
      return false;
    }
  }

  Future<Map<String, Object?>> nextDifficulty({
    required String category,
    required String token,
  }) async {
    if (!enabled) return const {};
    try {
      final body = await _send(
        () => _http.post(
          _uri('/difficulty/next'),
          headers: _headers(token),
          body: jsonEncode({'category': category}),
        ),
      );
      if (body is Map<String, dynamic>) {
        return body.map((k, v) => MapEntry(k, v as Object?));
      }
    } catch (_) {}
    return const {};
  }
}
