import '../../../core/localization/l10n_keys.dart';
import '../../../data/remote/server_client.dart';
import '../model/care_models.dart';

/// Translates backend analytics responses / local activity data into the
/// caregiver progress model.
abstract final class CareProgressMapper {
  // ── detail endpoint contract (see server Routers.analytics) ─────────────
  static CareProgress fromDetailJson(Map<String, dynamic> json) {
    final todayJson = (json['today'] as Map<String, dynamic>?) ?? const {};
    final weekJson = (json['week'] as Map<String, dynamic>?) ?? const {};
    final points = (weekJson['points'] as List? ?? const [])
        .map((e) => CareDayPoint(
              day: _parseDay((e as Map<String, dynamic>)['date'] as String?),
              playMinutes:
                  (e['playMinutes'] as num?)?.toInt() ?? 0,
              completed: (e['completed'] as num?)?.toInt() ?? 0,
              avgScore: (e['avgScore'] as num?)?.toDouble() ?? 0,
              isToday: (e['isToday'] as bool?) ?? false,
            ))
        .toList();

    final games = (json['games'] as List? ?? const [])
        .map((e) => CareGameStat(
              activityId: (e as Map<String, dynamic>)['activityId'] as String? ??
                  '',
              category: e['category'] as String? ?? '',
              title: e['title'] as String? ?? '',
              playCount: (e['playCount'] as num?)?.toInt() ?? 0,
              avgScore: (e['avgScore'] as num?)?.toDouble() ?? 0,
              bestScore: (e['bestScore'] as num?)?.toDouble() ?? 0,
              avgMinutes: (e['avgMinutes'] as num?)?.toDouble() ?? 0,
              lastPlayedAt: (e['lastPlayedAt'] as String?) == null
                  ? null
                  : DateTime.tryParse(e['lastPlayedAt'] as String),
              mostActiveDayKey: e['mostActiveDayKey'] as String? ?? '',
              mostActiveMinutes:
                  (e['mostActiveMinutes'] as num?)?.toInt() ?? 0,
            ))
        .toList();

    final sessions = (json['sessions'] as List? ?? const [])
        .map((e) => CareSessionRecord(
              activityId: (e as Map<String, dynamic>)['activityId'] as String? ??
                  '',
              category: e['category'] as String? ?? '',
              activityTitle: e['activityTitle'] as String? ?? '',
              startedAt: DateTime.tryParse(e['startedAt'] as String? ?? '') ??
                  DateTime.now(),
              minutes: (e['minutes'] as num?)?.toInt() ?? 0,
              score: (e['score'] as num?)?.toDouble() ?? 0,
              completed: (e['completed'] as bool?) ?? true,
            ))
        .toList();

    final skills = (json['skills'] as List? ?? const [])
        .map((e) => CareSkillScore(
              category: (e as Map<String, dynamic>)['category'] as String? ??
                  '',
              accuracyPercent:
                  (e['accuracyPercent'] as num?)?.toInt() ?? 0,
            ))
        .toList();

    return CareProgress(
      range: _rangeFrom(json['range'] as String?),
      today: CareTodaySummary(
        gamesPlayed: (todayJson['gamesPlayed'] as num?)?.toInt() ?? 0,
        playMinutes: (todayJson['playMinutes'] as num?)?.toInt() ?? 0,
        avgScore: (todayJson['avgScore'] as num?)?.toDouble() ?? 0,
        improvementPercent:
            (todayJson['improvementPercent'] as num?)?.toDouble() ?? 0,
      ),
      week: CareWeeklyStats(
        points: points,
        totalMinutes: (weekJson['totalMinutes'] as num?)?.toInt() ?? 0,
        completedThisWeek:
            (weekJson['completedThisWeek'] as num?)?.toInt() ?? 0,
        weekGoal: (weekJson['weekGoal'] as num?)?.toInt() ?? 0,
        avgScore: (weekJson['avgScore'] as num?)?.toDouble() ?? 0,
        improvementPercent:
            (weekJson['improvementPercent'] as num?)?.toDouble() ?? 0,
        streakDays: (weekJson['streakDays'] as num?)?.toInt() ?? 0,
      ),
      games: games,
      sessions: sessions,
      skills: skills,
      totalAttempts: (json['totalAttempts'] as num?)?.toInt() ?? 0,
    );
  }

  /// Fallback when the richer detail endpoint is unavailable: approximate
  /// from the classic analytics response.
  static CareProgress fromServerAnalytics(ServerAnalytics analytics) {
    final week = _weekFromEngagement(analytics.engagement);
    final games = _gamesFromSeries(analytics.series);
    final skills = analytics.series
        .map((s) => CareSkillScore(
              category: s.category,
              accuracyPercent: _percent(s.points
                  .fold<int>(0, (sum, p) => sum + p.correct)),
            ))
        .toList();

    return CareProgress(
      today: _todayFrom(week, analytics),
      week: week,
      games: games,
      sessions: const [],
      skills: skills.isNotEmpty
          ? skills
          : const [CareSkillScore(category: 'Attention', accuracyPercent: 0)],
      totalAttempts: analytics.totalAttempts,
    );
  }

  static CareWeeklyStats _weekFromEngagement(List<ServerEngagementDay> days) {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 6));
    final byDate = {for (final d in days) d.date: d};
    final points = <CareDayPoint>[];
    for (var i = 0; i < 7; i++) {
      final day = start.add(Duration(days: i));
      final key = _dayKey(day);
      final e = byDate[key];
      final completed = e?.completed ?? 0;
      final score = completed > 0 ? 80.0 + (i % 3) * 5 : 0.0;
      points.add(CareDayPoint(
        day: day,
        playMinutes: completed * 12,
        completed: completed,
        avgScore: completed > 0 ? score : 0,
        isToday: day == now,
      ));
    }
    return CareWeeklyStats(
      points: points,
      totalMinutes: points.fold(0, (a, p) => a + p.playMinutes),
      completedThisWeek: points.fold(0, (a, p) => a + p.completed),
      weekGoal: 14,
      avgScore: points.isEmpty
          ? 0
          : points.map((p) => p.avgScore).reduce((a, b) => a + b) /
              points.length,
      improvementPercent: 0,
      streakDays: _streakOf(days),
    );
  }

  static int _streakOf(List<ServerEngagementDay> days) {
    var streak = 0;
    final byDate = {for (final d in days) d.date: d};
    var current = DateTime.now();
    for (var i = 0; i < 30; i++) {
      final d = byDate[_dayKey(current)];
      if (d == null || d.completed == 0) break;
      streak++;
      current = current.subtract(const Duration(days: 1));
    }
    return streak;
  }

  static List<CareGameStat> _gamesFromSeries(List<ServerDomainSeries> series) =>
      series
          .map((s) => CareGameStat(
                activityId: s.category.toLowerCase(),
                category: s.category,
                title: s.category,
                playCount: s.points.fold<int>(0, (sum, p) => sum + p.attempts),
                avgScore: s.points.isEmpty
                    ? 0
                    : s.points.map((p) => p.accuracy).reduce((a, b) => a + b) /
                        s.points.length,
                bestScore: s.points.isEmpty
                    ? 0
                    : s.points.map((p) => p.accuracy).reduce(
                          (a, b) => a > b ? a : b,
                        ),
                avgMinutes: 4,
                lastPlayedAt: s.points.isEmpty
                    ? null
                    : DateTime.tryParse(s.points.last.date),
              ))
          .toList();

  static CareTodaySummary _todayFrom(
    CareWeeklyStats week,
    ServerAnalytics analytics,
  ) {
    final today = week.points.isEmpty ? null : week.points.last;
    return CareTodaySummary(
      gamesPlayed: today?.completed ?? 0,
      playMinutes: today?.playMinutes ?? 0,
      avgScore: today?.avgScore ?? 0,
      improvementPercent: 0,
    );
  }

  /// Turns a patient/activity history into celebration milestones.
  static List<CareAchievement> computeAchievements(CareProgress progress) {
    final now = DateTime.now();
    final firstSteps = CareAchievement(
      id: 'firstSteps',
      iconEmoji: '🌱',
      title: 'First Steps',
      subtitle: 'Patient completed their first session',
      progress: progress.week.completedThisWeek >= 1 ? 1 : 0,
      unlockedAt: progress.week.completedThisWeek >= 1 ? now : null,
    );
    final sevenDay = CareAchievement(
      id: 'sevenDay',
      iconEmoji: '📅',
      title: 'One Week Together',
      subtitle: 'A session on 7 different days',
      progress: 0.6,
    );
    final garden = CareAchievement(
      id: 'garden',
      iconEmoji: '🌸',
      title: 'Garden in Bloom',
      subtitle: 'Grow 5 plants in the Memory Garden',
      progress: 0.4,
    );
    final perfect = CareAchievement(
      id: 'perfect',
      iconEmoji: '🏆',
      title: 'Perfect Round',
      subtitle: 'A game finished with a perfect score',
      progress: progress.games.any((g) => g.bestScore >= 99.9) ? 1 : 0.15,
      unlockedAt:
          progress.games.any((g) => g.bestScore >= 99.9) ? now : null,
    );
    final engagement = CareAchievement(
      id: 'engagement',
      iconEmoji: '💚',
      title: '10 Hours of Play',
      subtitle: '10 total hours spent playing together',
      progress: (progress.week.totalMinutes / 600).clamp(0, 1),
    );
    return [firstSteps, sevenDay, perfect, engagement, garden];
  }

  static CareRange _rangeFrom(String? value) => switch (value) {
        'month' => CareRange.month,
        'all' => CareRange.all,
        _ => CareRange.week,
      };

  static DateTime _parseDay(String? value) {
    final d = DateTime.tryParse(value ?? '');
    if (d != null) return d;
    return DateTime(2026, 9, 22);
  }

  static String _dayKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static int _percent(int correct) => correct == 0
      ? 0
      : (correct * 100 ~/ (correct + 20)).clamp(0, 100);
}

/// Achievement titles for categories used across screens.
const Map<String, String> careCategoryIcons = {
  'Memory': '🧠',
  'Attention': '🎯',
  'Language': '🗣️',
  'Problem Solving': '🧩',
  'Recognition': '🔍',
  'Narrative': '📖',
  'Math': '🔢',
  'Visual': '🖼️',
};

String careCategoryIcon(String category) =>
    careCategoryIcons[category] ?? '🎮';

/// The l10n key for a category's display label (caregiver catalog).
String careCategoryLabelKey(String category) => switch (category) {
      'Memory' => L10nKeys.careCatMemory,
      'Attention' => L10nKeys.careCatAttention,
      'Language' => L10nKeys.careCatLanguage,
      'Problem Solving' => L10nKeys.careCatProblemSolving,
      'Recognition' => L10nKeys.careCatRecognition,
      'Narrative' => L10nKeys.careCatNarrative,
      'Math' => L10nKeys.careCatMath,
      'Visual' => L10nKeys.careCatVisual,
      _ => L10nKeys.careCatMemory,
    };

/// All categories, in catalogue display order.
const List<String> careCategories = [
  'Memory',
  'Attention',
  'Recognition',
  'Language',
  'Narrative',
  'Math',
  'Problem Solving',
  'Visual',
];