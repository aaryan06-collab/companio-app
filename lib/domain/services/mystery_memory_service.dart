import 'package:drift/drift.dart';

import '../../core/utilities/local_dates.dart';
import '../../data/local/app_database.dart';
import '../../data/repositories/activity_repository.dart';
import '../../data/repositories/memory_repository.dart';

/// State of today's special (mystery) memory.
class MysteryLockState {
  const MysteryLockState({
    required this.dateKey,
    required this.completions,
    required this.unlocked,
    this.memoryId,
    this.previewMemory,
  });

  final String dateKey;
  final int completions;
  final bool unlocked;
  final String? memoryId;

  /// Shown while locked, so curiosity bends to a gentle face.
  final Memory? previewMemory;

  int get completionsNeeded => MysteryUnlockRules.minCompletions;

  int get remaining =>
      (completionsNeeded - completions).clamp(0, completionsNeeded);
}

/// Rules for the memory-of-the-day unlock. Kept pure for tests.
abstract final class MysteryUnlockRules {
  /// After this many completed activities in a day the memory unlocks.
  static const int minCompletions = 2;

  static bool shouldUnlock(int completedToday) =>
      completedToday >= minCompletions;
}

/// Tracks and unlocks today's special memory.
class MysteryMemoryService {
  MysteryMemoryService(this._db, this._activityRepo, this._memoryRepo);

  final AppDatabase _db;
  final ActivityRepository _activityRepo;
  final MemoryRepository _memoryRepo;

  Future<MysteryLockState> stateFor(String patientId) async {
    final dateKey = LocalDates.todayKey();
    final row = await _findToday(patientId, dateKey);
    final completions = await _activityRepo.completionsOn(patientId, dateKey);
    final unlocked = row?.unlocked ?? false;
    final memoryId = row?.memoryId;

    Memory? preview;
    if (!unlocked) {
      preview = await _memoryRepo.pickFamilyMemory(patientId);
    }

    return MysteryLockState(
      dateKey: dateKey,
      completions: completions,
      unlocked: unlocked,
      memoryId: memoryId,
      previewMemory: preview,
    );
  }

  Future<Memory?> unlockedMemoryFor(String patientId) async {
    final state = await stateFor(patientId);
    if (!state.unlocked || state.memoryId == null) return null;
    return _memoryRepo.memoryById(state.memoryId!);
  }

  /// Called after each completed activity. Unlocks when the rule is met.
  Future<MysteryLockState> onActivityCompleted(String patientId) async {
    final dateKey = LocalDates.todayKey();
    final row = await _findToday(patientId, dateKey);
    final completions = await _activityRepo.completionsOn(patientId, dateKey);

    if (row != null && row.unlocked) {
      return stateFor(patientId);
    }

    if (MysteryUnlockRules.shouldUnlock(completions)) {
      final candidates = await _memoryRepo.memoriesFor(patientId);
      final alreadyUsed = row?.memoryId;
      final pick = candidates
          .where((m) => m.id != alreadyUsed)
          .toList()
          .firstOrNullNullable();
      final chosen = pick ?? candidates.firstOrNullNullable();

      if (chosen != null) {
        await _upsert(
          patientId,
          dateKey,
          completions: completions,
          memoryId: chosen.id,
          unlocked: true,
          unlockedAt: DateTime.now(),
        );
        return stateFor(patientId);
      }
    }

    await _upsert(
      patientId,
      dateKey,
      completions: completions,
      unlocked: false,
    );
    return stateFor(patientId);
  }

  Future<DailyUnlock?> _findToday(String patientId, String dateKey) async {
    final rows =
        await (_db.select(_db.dailyUnlocks)..where(
              (t) => t.patientId.equals(patientId) & t.forDate.equals(dateKey),
            ))
            .get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<void> _upsert(
    String patientId,
    String dateKey, {
    required int completions,
    String? memoryId,
    required bool unlocked,
    DateTime? unlockedAt,
  }) async {
    await (_db.into(_db.dailyUnlocks)).insert(
      DailyUnlocksCompanion.insert(
        patientId: patientId,
        forDate: dateKey,
        completions: Value(completions),
        memoryId: Value(memoryId),
        unlocked: Value(unlocked),
        unlockedAt: Value(unlockedAt),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }
}

extension _FirstOrNull<T> on List<T> {
  T? firstOrNullNullable() => isEmpty ? null : first;
}
