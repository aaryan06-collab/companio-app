import 'dart:async';
import 'dart:convert';

import '../../data/local/app_database.dart';
import '../../data/repositories/reminder_repository.dart';

/// Pure scheduling rules for offline reminders.
abstract final class ReminderRules {
  /// Days of week as 0=Mon … 6=Sun.
  static const List<String> dayNames = [
    'dayMon',
    'dayTue',
    'dayWed',
    'dayThu',
    'dayFri',
    'daySat',
    'daySun',
  ];

  /// Whether a reminder fires on the weekday of [date] (empty days list
  /// means every day).
  static bool firesOn(Reminder reminder, DateTime date) {
    final days = _parseDays(reminder);
    if (days.isEmpty) return true;
    // DateTime.weekday: 1=Mon..7=Sun
    final index = date.weekday - 1;
    return days.contains(index);
  }

  /// Next absolute occurrence at or after [from].
  static DateTime nextOccurrence(Reminder reminder, DateTime from) {
    var candidate = DateTime(
      from.year,
      from.month,
      from.day,
      reminder.hour,
      reminder.minute,
    );
    var guard = 0;
    while (!firesOn(reminder, candidate) || candidate.isBefore(from)) {
      candidate = candidate.add(const Duration(days: 1));
      guard++;
      if (guard > 366) break;
    }
    return candidate;
  }

  /// True when [now] falls within the minute the reminder fires.
  static bool isDue(Reminder reminder, DateTime now) {
    if (!reminder.enabled) return false;
    if (!firesOn(reminder, now)) return false;
    return now.hour == reminder.hour && now.minute == reminder.minute;
  }

  static List<int> _parseDays(Reminder reminder) {
    try {
      final raw = const JsonCodec().decode(reminder.daysJson) as List;
      return raw.cast<int>();
    } catch (_) {
      return const [];
    }
  }
}

/// Keeps offline reminders firing. Single periodic tick checks all enabled
/// reminders and emits those that are due (guards against duplicate fires
/// within the same minute).
class ReminderScheduler {
  ReminderScheduler(this._repo);

  final ReminderRepository _repo;

  Timer? _timer;
  final Set<String> _lastFiredMinute = {};
  Future<void> Function(Reminder reminder)? onDue;

  void start() {
    stop();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) => checkNow());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  /// Checks due reminders now; returns the reminders that fired.
  Future<List<Reminder>> checkNow() async {
    final now = DateTime.now();
    final minuteKey =
        '${now.year}-${now.month}-${now.day}-${now.hour}:${now.minute}';
    final reminders = await _repo.enabledReminders();
    final fired = <Reminder>[];
    for (final reminder in reminders) {
      if (!ReminderRules.isDue(reminder, now)) continue;
      final key = '${reminder.id}.$minuteKey';
      if (_lastFiredMinute.contains(key)) continue;
      _lastFiredMinute.add(key);
      if (_lastFiredMinute.length > 200) _lastFiredMinute.clear();
      fired.add(reminder);
    }
    for (final reminder in fired) {
      try {
        await _repo.logNotification(
          id: 'ntf.${reminder.id}.${DateTime.now().microsecondsSinceEpoch}',
          patientId: reminder.patientId,
          title: reminder.title,
          body: reminder.detail ?? '',
          type: reminder.kind,
        );
        await onDue?.call(reminder);
      } catch (_) {}
    }
    return fired;
  }

  Future<void> dispose() async => stop();
}
