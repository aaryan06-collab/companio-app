import 'dart:convert';

import 'package:drift/drift.dart';

import '../local/app_database.dart';

/// Offline reminders + the in-app notification log.
class ReminderRepository {
  ReminderRepository(this._db);

  final AppDatabase _db;

  Future<Reminder> addReminder({
    required String id,
    required String patientId,
    required String title,
    String? detail,
    required int hour,
    required int minute,
    String kind = 'routine',
    List<int> days = const [],
    bool enabled = true,
  }) async {
    final row = RemindersCompanion.insert(
      id: id,
      patientId: patientId,
      title: title,
      detail: Value(detail),
      hour: hour,
      minute: minute,
      kind: Value(kind),
      daysJson: Value(jsonEncode(days)),
      enabled: Value(enabled),
      createdAt: DateTime.now(),
    );
    await _db.into(_db.reminders).insert(row, mode: InsertMode.insertOrReplace);
    return (_db.select(
      _db.reminders,
    )..where((t) => t.id.equals(id))).getSingle();
  }

  Future<List<Reminder>> remindersFor(String patientId) async {
    final query = _db.select(_db.reminders)
      ..where((t) => t.patientId.equals(patientId))
      ..orderBy([
        (t) => OrderingTerm.asc(t.hour),
        (t) => OrderingTerm.asc(t.minute),
      ]);
    return query.get();
  }

  Future<List<Reminder>> enabledReminders() async {
    final query = _db.select(_db.reminders)
      ..where((t) => t.enabled.equals(true));
    return query.get();
  }

  Future<Reminder?> reminderById(String id) async {
    final rows = await (_db.select(
      _db.reminders,
    )..where((t) => t.id.equals(id))).get();
    return rows.isEmpty ? null : rows.first;
  }

  List<int> daysOf(Reminder reminder) =>
      ((jsonDecode(reminder.daysJson) as List?) ?? const []).cast<int>();

  Future<void> setEnabled(String id, bool enabled) async {
    await (_db.update(_db.reminders)..where((t) => t.id.equals(id))).write(
      RemindersCompanion(enabled: Value(enabled)),
    );
  }

  Future<void> updateReminder(
    String id, {
    String? title,
    String? detail,
    int? hour,
    int? minute,
    bool? enabled,
  }) async {
    await (_db.update(_db.reminders)..where((t) => t.id.equals(id))).write(
      RemindersCompanion(
        title: title == null ? const Value.absent() : Value(title),
        detail: detail == null ? const Value.absent() : Value(detail),
        hour: hour == null ? const Value.absent() : Value(hour),
        minute: minute == null ? const Value.absent() : Value(minute),
        enabled: enabled == null ? const Value.absent() : Value(enabled),
      ),
    );
  }

  Future<void> deleteReminder(String id) =>
      (_db.delete(_db.reminders)..where((t) => t.id.equals(id))).go();

  // ── Notifications log ─────────────────────────────────────────────────
  Future<Notification> logNotification({
    required String id,
    String? patientId,
    required String title,
    required String body,
    String type = 'info',
  }) async {
    final row = NotificationsCompanion.insert(
      id: id,
      patientId: Value(patientId),
      title: title,
      body: body,
      type: Value(type),
      isRead: const Value(false),
      createdAt: DateTime.now(),
    );
    await _db.into(_db.notifications).insert(row);
    return (_db.select(
      _db.notifications,
    )..where((t) => t.id.equals(id))).getSingle();
  }

  Future<List<Notification>> recentNotifications({int limit = 20}) async {
    final query = _db.select(_db.notifications)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(limit);
    return query.get();
  }

  Future<void> markRead(String id) async {
    await (_db.update(_db.notifications)..where((t) => t.id.equals(id))).write(
      const NotificationsCompanion(isRead: Value(true)),
    );
  }
}
