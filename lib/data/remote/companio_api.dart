import 'dart:convert';

/// Remote API surface for Companio synchronization.
///
/// The only place that knows about the "cloud". The app layer talks to this
/// interface; production will bind to a FastAPI backend while an offline
/// implementation keeps the demo and tests completely independent of
/// infrastructure.
abstract class CompanioApi {
  /// Stable identifier for this installation (used to avoid echoing our own
  /// pull records back at us).
  String get deviceId;

  /// Uploads records idempotently. Backend acknowledges each record it
  /// accepts (deduplicated by [CompanioRecord.idempotencyKey]). Records not
  /// in the returned list were rejected and should be retried.
  Future<Set<String>> push(List<CompanioRecord> records);

  /// Fetches records meant for this device (downstream changes such as new
  /// family memories uploaded by caregivers).
  Future<List<CompanioRecord>> pull();

  /// Whether the transport is currently reachable.
  Future<bool> isReachable();
}

/// One unit of change flowing between device and server.
class CompanioRecord {
  const CompanioRecord({
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payloadJson,
    required this.idempotencyKey,
    required this.deviceId,
    required this.clientAt,
  });

  factory CompanioRecord.create({
    required String entityType,
    required String entityId,
    required String operation,
    required Map<String, Object?> payload,
    required String idempotencyKey,
    required String deviceId,
    DateTime? clientAt,
  }) => CompanioRecord(
    entityType: entityType,
    entityId: entityId,
    operation: operation,
    payloadJson: jsonEncode(payload),
    idempotencyKey: idempotencyKey,
    deviceId: deviceId,
    clientAt: clientAt ?? DateTime.now(),
  );

  final String entityType;
  final String entityId;
  final String operation;

  /// JSON-encoded payload body.
  final String payloadJson;
  final String idempotencyKey;
  final String deviceId;
  final DateTime clientAt;

  Map<String, Object?> decodePayload() => safeDecode(payloadJson);

  Map<String, Object?> toJson() => {
    'entityType': entityType,
    'entityId': entityId,
    'operation': operation,
    'payloadJson': payloadJson,
    'idempotencyKey': idempotencyKey,
    'deviceId': deviceId,
    'clientAt': clientAt.toIso8601String(),
  };

  factory CompanioRecord.fromJson(Map<String, Object?> json) => CompanioRecord(
    entityType: json['entityType']! as String,
    entityId: json['entityId']! as String,
    operation: json['operation']! as String,
    payloadJson: json['payloadJson']! as String,
    idempotencyKey: json['idempotencyKey']! as String,
    deviceId: (json['deviceId'] as String?) ?? '',
    clientAt:
        DateTime.tryParse((json['clientAt'] as String?) ?? '') ??
        DateTime.now(),
  );
}

/// Robust JSON decode that never throws; returns [fallback] on malformed data.
Map<String, Object?> safeDecode(String raw, [Map<String, Object?>? fallback]) {
  try {
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) {
      return decoded.map((k, v) => MapEntry(k, v as Object?));
    }
    return fallback ?? const {};
  } catch (_) {
    return fallback ?? const {};
  }
}
