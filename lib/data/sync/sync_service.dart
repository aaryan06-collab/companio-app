import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../local/app_database.dart';
import '../models/enums.dart';
import '../repositories/contact_repository.dart';
import '../repositories/memory_repository.dart';
import '../repositories/reminder_repository.dart';
import '../repositories/sos_repository.dart';
import '../remote/companio_api.dart';
import 'connectivity_monitor.dart';
import 'sync_repository.dart';

/// Applies incoming (downstream) records to the local database.
///
/// Every application is idempotent: records already delivered by this
/// device, or already applied, are skipped.
class RemoteApplier {
  RemoteApplier({
    required this.memoryRepo,
    required this.contactRepo,
    required this.reminderRepo,
    required this.syncRepo,
    required this.sosRepo,
  });

  final MemoryRepository memoryRepo;
  final ContactRepository contactRepo;
  final ReminderRepository reminderRepo;
  final SyncRepository syncRepo;
  final SosRepository sosRepo;

  int applied = 0;

  Future<bool> apply(CompanioRecord record) async {
    // Never re-apply one of our own deliveries.
    if (await syncRepo.isDelivered(record.idempotencyKey)) return false;

    final entityId = record.entityId;
    final already = await syncRepo.alreadyApplied(
      record.entityType,
      entityId,
      operation: record.operation,
    );
    if (already) return false;

    final payload = record.decodePayload();

    switch (record.entityType) {
      case 'memory':
        final patientId = (payload['patientId'] as String?) ?? '';
        if (patientId.isEmpty) return false;
        await memoryRepo.addMemory(
          id: entityId,
          patientId: patientId,
          kind: enumFromName(
            (payload['kind'] as String?) ?? 'text',
            MemoryKind.values,
          ),
          title: (payload['title'] as String?) ?? 'Memory',
          caption: payload['caption'] as String?,
          relation: payload['relation'] as String?,
          mediaPath: payload['mediaPath'] as String?,
          mediaUrl: payload['mediaUrl'] as String?,
          category: enumFromName(
            (payload['category'] as String?) ?? 'family',
            MemoryCategory.values,
          ),
          placeName: payload['placeName'] as String?,
          createdBy: (payload['createdBy'] as String?) ?? 'family',
        );
        applied++;
        return true;

      case 'contact':
        final relation = payload['relation'] as String?;
        await contactRepo.addContact(
          id: entityId,
          patientId: (payload['patientId'] as String?) ?? '',
          name: (payload['name'] as String?) ?? '',
          phone: (payload['phone'] as String?) ?? '',
          relation: relation,
          priority: enumFromName(
            (payload['priority'] as String?) ?? 'primary',
            EscalationPriority.values,
          ),
        );
        applied++;
        return true;

      case 'reminder':
        await reminderRepo.addReminder(
          id: entityId,
          patientId: (payload['patientId'] as String?) ?? '',
          title: (payload['title'] as String?) ?? 'Reminder',
          detail: payload['detail'] as String?,
          hour: (payload['hour'] as num?)?.toInt() ?? 9,
          minute: (payload['minute'] as num?)?.toInt() ?? 0,
          kind: (payload['kind'] as String?) ?? 'routine',
        );
        applied++;
        return true;

      case 'sos_ack':
        await sosRepo.updateIncident(
          entityId,
          status: SosStatus.acknowledged,
          acknowledgedAt: DateTime.tryParse(
            (payload['acknowledgedAt'] as String?) ?? '',
          ),
        );
        applied++;
        return true;

      default:
        return false;
    }
  }
}

T enumFromName<T extends Enum>(String name, List<T> values) {
  for (final v in values) {
    if (v.name == name) return v;
  }
  return values.first;
}

/// Runtime sync snapshot shown to users in calm, non-technical language.
class SyncSnapshot {
  const SyncSnapshot({
    this.online = true,
    this.pending = 0,
    this.lastSyncedAt,
    this.inProgress = false,
  });

  final bool online;
  final int pending;
  final DateTime? lastSyncedAt;
  final bool inProgress;

  bool get hasPending => pending > 0;

  SyncSnapshot copyWith({
    bool? online,
    int? pending,
    DateTime? lastSyncedAt,
    bool? inProgress,
  }) => SyncSnapshot(
    online: online ?? this.online,
    pending: pending ?? this.pending,
    lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    inProgress: inProgress ?? this.inProgress,
  );
}

/// The synchronization engine.
///
/// Local-first: writes always land in the local database first and are
/// queued. When connectivity returns (or on a retry timer) pending changes
/// are uploaded idempotently and downstream changes are pulled in.
class SyncService extends ChangeNotifier {
  SyncService({
    required CompanioApi api,
    required SyncRepository queue,
    required RemoteApplier applier,
    required ConnectivityMonitor monitor,
    Duration retryInterval = const Duration(seconds: 45),
    Future<String?> Function(String localPath)? mediaUploader,
    Future<void> Function(String memoryId, String url)? onMemoryUploaded,
    Future<void> Function()? onPullComplete,
  }) : _api = api,
       _queue = queue,
       _applier = applier,
       _monitor = monitor,
       _retryInterval = retryInterval,
       _mediaUploader = mediaUploader,
       _onMediaUploaded = onMemoryUploaded,
       onPullComplete = onPullComplete;

  final CompanioApi _api;
  final SyncRepository _queue;
  final RemoteApplier _applier;
  final ConnectivityMonitor _monitor;
  final Duration _retryInterval;
  final Future<String?> Function(String localPath)? _mediaUploader;
  final Future<void> Function(String memoryId, String url)? _onMediaUploaded;

  /// Invoked after a successful downstream pull so UI providers can refresh.
  Future<void> Function()? onPullComplete;

  SyncSnapshot _snapshot = const SyncSnapshot();
  SyncSnapshot get snapshot => _snapshot;

  Timer? _retryTimer;
  bool _running = false;

  void startAutoSync() {
    _monitor.onlineStream.listen((online) async {
      _snapshot = _snapshot.copyWith(online: online);
      if (online) {
        await syncNow();
      }
      notifyListeners();
    });
    _scheduleRetry();
    syncNow();
  }

  void stop() {
    _retryTimer?.cancel();
  }

  Future<void> setOnline(bool online) async {
    _snapshot = _snapshot.copyWith(online: online);
    if (online) await syncNow();
    notifyListeners();
  }

  void _scheduleRetry() {
    _retryTimer?.cancel();
    _retryTimer = Timer.periodic(_retryInterval, (_) {
      if (_snapshot.online) syncNow();
    });
  }

  /// Uploads pending changes, then downloads caregiver updates.
  Future<void> syncNow() async {
    if (_running) return;
    _running = true;
    _snapshot = _snapshot.copyWith(inProgress: true);
    notifyListeners();
    try {
      final online = await _monitor.check();
      _snapshot = _snapshot.copyWith(online: online);
      notifyListeners();
      if (!online) return;

      await _pushPending();
      await _pullRemote();

      final pending = await _queue.pendingCount();
      _snapshot = _snapshot.copyWith(
        pending: pending,
        lastSyncedAt: DateTime.now(),
      );
    } catch (_) {
      // Transport errors leave the queue intact; the retry timer (or the next
      // connectivity change) will attempt the upload again.
    } finally {
      _running = false;
      _snapshot = _snapshot.copyWith(inProgress: false);
      notifyListeners();
    }
  }

  Future<void> _pushPending() async {
    final items = await _queue.pending();
    if (items.isEmpty) return;

    // Media memories (photos, videos, voice recordings) are held back until
    // their file is uploaded: the uploader gives us the mediaUrl, which is
    // written back into the queued payload so the pushed record carries it
    // for the receiving device. Failed uploads stay queued and are retried by
    // the next sync tick.
    final queuedItems = <SyncQueueItem>[];
    final records = <CompanioRecord>[];
    for (final e in items) {
      final payload = _decode(e.payloadJson);
      if (e.entityType == 'memory' && _mediaUploader != null) {
        final path = payload['mediaPath'] as String?;
        final url = payload['mediaUrl'] as String?;
        final needsUpload =
            path != null && path.isNotEmpty && (url == null || url.isEmpty);
        if (needsUpload) {
          try {
            final uploaded = await _mediaUploader(path);
            if (uploaded == null || uploaded.isEmpty) {
              await _queue.markFailed(e, 'media upload pending');
              continue;
            }
            payload['mediaUrl'] = uploaded;
            await _queue.updatePayload(e.id, payload);
            await _onMediaUploaded?.call(e.entityId, uploaded);
          } catch (err) {
            await _queue.markFailed(e, err.toString());
            continue;
          }
        }
      }
      queuedItems.add(e);
      records.add(
        CompanioRecord.create(
          entityType: e.entityType,
          entityId: e.entityId,
          operation: e.operation,
          payload: payload,
          idempotencyKey: e.idempotencyKey,
          deviceId: _api.deviceId,
          clientAt: e.createdAt,
        ),
      );
    }
    if (records.isEmpty) return;

    final queuedIds = queuedItems.map((e) => e.id).toList();
    await _queue.markSyncing(queuedIds);

    try {
      final accepted = await _api.push(records);
      final syncedIds = <String>[];
      for (var i = 0; i < records.length; i++) {
        if (accepted.contains(records[i].idempotencyKey)) {
          syncedIds.add(queuedItems[i].id);
        } else {
          await _queue.markFailed(queuedItems[i], 'server rejected');
        }
      }
      await _queue.markSynced(syncedIds);
    } catch (_) {
      // Transport failure (offline, server down): items must stay queued so
      // the next sync tick re-uploads them. Nothing is lost.
      await _queue.markPending(queuedIds);
      rethrow;
    }
  }

  Future<void> _pullRemote() async {
    final records = await _api.pull();
    for (final record in records) {
      try {
        await _applier.apply(record);
      } catch (_) {
        // A malformed record must not break the rest of the queue.
      }
    }
    final pending = await _queue.pendingCount();
    _snapshot = _snapshot.copyWith(pending: pending);
    await onPullComplete?.call();
  }

  Future<void> enqueueAndCommit({
    required String entityType,
    required String entityId,
    required SyncOperation operation,
    required Map<String, Object?> payload,
  }) async {
    await _queue.enqueue(
      entityType: entityType,
      entityId: entityId,
      operation: operation,
      payload: payload,
    );
    final pending = await _queue.pendingCount();
    _snapshot = _snapshot.copyWith(pending: pending);
    notifyListeners();
    if (_snapshot.online) syncNow();
  }

  /// Pushes a caregiver-created memory as if coming from another device —
  /// used by the demo caregiver flow.
  Future<void> publishRemote(CompanioRecord record) async {
    await (_api as dynamic).publishFromCaregiver(record);
  }

  static Map<String, Object?> _decode(String raw) => _safeDecode(raw);

  static Map<String, Object?> _safeDecode(String raw) {
    try {
      final d = const JsonCodec().decode(raw);
      if (d is Map<String, dynamic>) return d;
      return {};
    } catch (_) {
      return {};
    }
  }
}
