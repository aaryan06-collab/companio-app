import '../../core/utilities/local_dates.dart';
import '../../data/local/app_database.dart';
import '../../data/models/enums.dart';
import '../../data/repositories/activity_repository.dart';
import '../../data/repositories/garden_repository.dart';
import '../../data/sync/sync_repository.dart';
import 'garden_service.dart';
import 'mystery_memory_service.dart';

/// Everything that happens when a patient finishes an activity:
/// local persistence, garden growth, mystery-memory unlock and sync queue.
class ActivityCompletionResult {
  const ActivityCompletionResult({
    required this.attempt,
    required this.growth,
    required this.mystery,
    required this.completionsToday,
  });

  final ActivityAttempt attempt;
  final GrowthResult growth;
  final MysteryLockState mystery;
  final int completionsToday;
}

class DailyExperienceService {
  DailyExperienceService({
    required this.activityRepo,
    required this.gardenRepo,
    required this.gardenService,
    required this.mysteryService,
    required this.syncRepo,
  });

  final ActivityRepository activityRepo;
  final GardenRepository gardenRepo;
  final GardenService gardenService;
  final MysteryMemoryService mysteryService;
  final SyncRepository syncRepo;

  /// Records a completed activity through the full off-line-first flow.
  Future<ActivityCompletionResult> completeActivity({
    required String patientId,
    required String activityId,
    required int correctCount,
    required int totalCount,
    required int hintCount,
    Difficulty difficulty = Difficulty.gentle,
    bool completed = true,
    Map<String, Object?>? result,
    GardenSection section = GardenSection.garden,
  }) async {
    final now = DateTime.now();
    final attemptId =
        'attempt.$patientId.$activityId.${now.microsecondsSinceEpoch}';

    final attempt = await activityRepo.saveAttempt(
      id: attemptId,
      patientId: patientId,
      activityId: activityId,
      startedAt: now.subtract(const Duration(seconds: 60)),
      finishedAt: now,
      completed: completed,
      correctCount: correctCount,
      totalCount: totalCount,
      hintCount: hintCount,
      difficulty: difficulty,
      result: result,
    );

    // Link to today's daily activity when applicable.
    final today = await activityRepo.todayActivity(patientId);
    if (today != null && today.activityId == activityId) {
      await activityRepo.markDailyCompleted(today.id, attemptId: attemptId);
    }

    // Garden grows.
    final totalCompleted = await _totalCompleted(patientId);
    final growth = await gardenService.onActivityCompleted(
      patientId,
      completionNumber: totalCompleted,
      section: section,
    );

    // Mystery memory may unlock.
    final mystery = await mysteryService.onActivityCompleted(patientId);

    // Sync queue (idempotent uploads when connectivity returns).
    await _enqueueAttempt(attempt);
    if (today != null && today.activityId == activityId) {
      await _enqueueDailyCompletion(today.id);
    }

    final completionsToday = await activityRepo.completionsOn(
      patientId,
      LocalDates.todayKey(),
    );

    return ActivityCompletionResult(
      attempt: attempt,
      growth: growth,
      mystery: mystery,
      completionsToday: completionsToday,
    );
  }

  Future<int> _totalCompleted(String patientId) async {
    final garden = await gardenRepo.gardenFor(patientId);
    if (garden == null) return 1;
    return garden.activitiesCompleted + 1;
  }

  Future<void> _enqueueAttempt(ActivityAttempt attempt) async {
    await syncRepo.enqueue(
      entityType: 'attempt',
      entityId: attempt.id,
      operation: SyncOperation.create,
      payload: {
        'id': attempt.id,
        'patientId': attempt.patientId,
        'activityId': attempt.activityId,
        'completed': attempt.completed,
        'correctCount': attempt.correctCount,
        'totalCount': attempt.totalCount,
        'hintCount': attempt.hintCount,
        'finishedAt': attempt.finishedAt?.toIso8601String(),
        'resultJson': attempt.resultJson,
      },
    );
  }

  Future<void> _enqueueDailyCompletion(String dailyId) async {
    await syncRepo.enqueue(
      entityType: 'daily_activity',
      entityId: dailyId,
      operation: SyncOperation.update,
      payload: {
        'id': dailyId,
        'status': DailyStatus.completed.name,
        'completedAt': DateTime.now().toIso8601String(),
      },
    );
  }
}
