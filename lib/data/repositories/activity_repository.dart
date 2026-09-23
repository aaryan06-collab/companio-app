import 'package:drift/drift.dart';

import '../../core/utilities/local_dates.dart';
import '../../domain/entities/activity_content.dart';
import '../content/activity_catalog.dart';
import '../local/app_database.dart';
import '../models/enums.dart';

/// Activity catalog, daily assignment and attempt records.
class ActivityRepository {
  ActivityRepository(this._db);

  final AppDatabase _db;

  // ── Catalog seeding ───────────────────────────────────────────────────
  /// Re-seeds the `activities` table from [ActivityCatalog] using content
  /// localized for [language].
  Future<void> seedCatalog(String language) async {
    for (final activity in ActivityCatalog.all) {
      final content = activity.content.forLocale(language);
      final row = ActivitiesCompanion.insert(
        id: activity.id,
        type: activity.type.name,
        titleKey: activity.titleKey,
        subtitleKey: Value(activity.subtitleKey),
        category: activity.category,
        baseDifficulty: activity.baseDifficulty,
        durationSec: Value(activity.durationSec),
        contentJson: JsonUtil.encode(content.toJson()),
        isCustom: const Value(false),
        region: Value(null),
        enabled: const Value(true),
      );
      await _db
          .into(_db.activities)
          .insert(row, mode: InsertMode.insertOrReplace);
    }
  }

  Future<List<Activity>> allActivities({bool enabledOnly = true}) async {
    final query = _db.select(_db.activities)
      ..orderBy([(t) => OrderingTerm.asc(t.titleKey)]);
    if (enabledOnly) query.where((t) => t.enabled.equals(true));
    return query.get();
  }

  Future<Activity?> activityById(String id) async {
    final rows = await (_db.select(
      _db.activities,
    )..where((t) => t.id.equals(id))).get();
    return rows.isEmpty ? null : rows.first;
  }

  ActivityContent contentOf(Activity activity) =>
      JsonUtil.decode(activity.contentJson, ActivityContent.fromJson, const {});

  // ── Daily activity ────────────────────────────────────────────────────
  /// Deterministic daily pick: varies by date, patient and region, stable
  /// across re-opens so the same gentle activity stays assigned all day.
  Future<void> ensureTodayAssigned(String patientId, String? region) async {
    final todayKey = LocalDates.todayKey();
    final existing = await todayActivity(patientId);
    if (existing != null) return;

    final all = await allActivities();
    if (all.isEmpty) return;

    var seed = _hashIndex('$patientId|$todayKey|${region ?? ''}');
    final activity = all[seed % all.length];

    final id = 'daily.$patientId.$todayKey';
    await _db
        .into(_db.dailyActivities)
        .insert(
          DailyActivitiesCompanion.insert(
            id: id,
            patientId: patientId,
            activityId: activity.id,
            forDate: todayKey,
            status: DailyStatus.assigned,
            assignedAt: DateTime.now(),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<DailyActivity?> todayActivity(String patientId) async {
    final todayKey = LocalDates.todayKey();
    final rows =
        await (_db.select(_db.dailyActivities)..where(
              (t) => t.patientId.equals(patientId) & t.forDate.equals(todayKey),
            ))
            .get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<List<DailyActivity>> recentDaily(
    String patientId, {
    int limit = 14,
  }) async {
    final query = _db.select(_db.dailyActivities)
      ..where((t) => t.patientId.equals(patientId))
      ..orderBy([(t) => OrderingTerm.desc(t.forDate)])
      ..limit(limit);
    return query.get();
  }

  /// Links a completed daily activity to an attempt.
  Future<void> markDailyCompleted(
    String dailyActivityId, {
    required String attemptId,
  }) async {
    await (_db.update(
      _db.dailyActivities,
    )..where((t) => t.id.equals(dailyActivityId))).write(
      DailyActivitiesCompanion(
        status: const Value(DailyStatus.completed),
        completedAt: Value(DateTime.now()),
      ),
    );
    await (_db.update(
      _db.activityAttempts,
    )..where((t) => t.id.equals(attemptId))).write(
      ActivityAttemptsCompanion(dailyActivityId: Value(dailyActivityId)),
    );
  }

  // ── Attempts ──────────────────────────────────────────────────────────
  Future<ActivityAttempt> saveAttempt({
    required String id,
    required String patientId,
    required String activityId,
    DateTime? startedAt,
    DateTime? finishedAt,
    bool completed = false,
    int correctCount = 0,
    int totalCount = 0,
    int hintCount = 0,
    Difficulty difficulty = Difficulty.gentle,
    Map<String, Object?>? result,
  }) async {
    final row = ActivityAttemptsCompanion.insert(
      id: id,
      patientId: patientId,
      activityId: activityId,
      startedAt: startedAt ?? DateTime.now(),
      finishedAt: Value(finishedAt),
      completed: Value(completed),
      correctCount: Value(correctCount),
      totalCount: Value(totalCount),
      hintCount: Value(hintCount),
      difficulty: difficulty,
      resultJson: Value(result == null ? null : JsonUtil.encode(result)),
      createdAt: DateTime.now(),
    );
    await _db.into(_db.activityAttempts).insert(row);
    return (_db.select(
      _db.activityAttempts,
    )..where((t) => t.id.equals(id))).getSingle();
  }

  Future<ActivityAttempt?> attemptById(String id) async {
    final rows = await (_db.select(
      _db.activityAttempts,
    )..where((t) => t.id.equals(id))).get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<List<ActivityAttempt>> attemptsFor(
    String patientId, {
    int limit = 50,
  }) async {
    final query = _db.select(_db.activityAttempts)
      ..where((t) => t.patientId.equals(patientId))
      ..orderBy([(t) => OrderingTerm.desc(t.startedAt)])
      ..limit(limit);
    return query.get();
  }

  /// Number of completed activities on [dateKey], used by mystery unlock.
  Future<int> completionsOn(String patientId, String dateKey) async {
    final start = LocalDates.fromKey(dateKey);
    final end = start.add(const Duration(days: 1));
    return (await (_db.selectOnly(_db.activityAttempts)
              ..addColumns([_db.activityAttempts.id.count()])
              ..where(
                _db.activityAttempts.patientId.equals(patientId) &
                    _db.activityAttempts.completed.equals(true) &
                    _db.activityAttempts.finishedAt.isBiggerOrEqualValue(
                      start,
                    ) &
                    _db.activityAttempts.finishedAt.isSmallerThanValue(end),
              ))
            .map((e) => e.read(_db.activityAttempts.id.count()) ?? 0)
            .getSingle())
        .toInt();
  }

  int _hashIndex(String seedText) {
    var hash = 0;
    for (final unit in seedText.codeUnits) {
      hash = (hash * 31 + unit) & 0x7fffffff;
    }
    return hash;
  }
}
