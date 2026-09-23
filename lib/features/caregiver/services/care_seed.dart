import '../model/care_models.dart';

/// Offline preview data shown to a caregiver account with no linked patient
/// yet. Lets a first-run user explore the whole caregiver experience without
/// creating a patient. Clearly labelled as a preview and never synced.
abstract final class CareSeed {
  static final CarePatient patient = CarePatient(
    id: 'demo-preview',
    name: 'Savitri Devi',
    region: 'Jaipur, Rajasthan',
    dateOfBirth: DateTime(1948, 3, 14),
    avatarEmoji: '🌸',
  );

  static const List<double> _scores = [88, 91, 79, 84, 93, 86, 90];
  static const List<int> _minutes = [45, 30, 25, 40, 55, 20, 35];
  static const List<int> _completed = [3, 2, 2, 3, 4, 1, 3];

  static CareProgress forRange(CareRange range) {
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day)
        .subtract(Duration(days: 6));
    final points = List<CareDayPoint>.generate(7, (i) {
      final day = start.add(Duration(days: i));
      return CareDayPoint(
        day: day,
        playMinutes: _minutes[i],
        completed: _completed[i],
        avgScore: _scores[i],
        isToday: day == today,
      );
    });

    final totalMinutes = _minutes.fold(0, (a, b) => a + b);
    final completedThisWeek = _completed.fold(0, (a, b) => a + b);
    final avgScore =
        _scores.reduce((a, b) => a + b) / _scores.length;

    const perGamePlay = [9, 6, 4, 5, 3, 8, 4];
    const perGameAvg = [84.5, 91.0, 77.0, 88.5, 79.5, 86.0, 82.0];
    const perGameBest = [96.0, 100.0, 92.0, 95.0, 88.0, 94.0, 91.0];
    const titles = [
      'Memory Matching',
      'Chhotu Storms Home',
      'Number Nutshop',
      'Vegetable Picking',
      'Follow The Sequence',
      'Name The Month',
      'Village Picture Puzzle',
    ];
    const categories = [
      'Memory',
      'Narrative',
      'Math',
      'Recognition',
      'Attention',
      'Language',
      'Visual',
    ];

    const sessions = [
      ('matching', 0, 45, 92.0, true),
      ('chhotu_sequence', 1, 22, 88.0, true),
      ('shopping', 2, 40, 81.5, true),
      ('kitchen', 3, 18, 94.0, false),
    ];

    final multiplier = switch (range) {
      CareRange.week => 1,
      CareRange.month => 5,
      CareRange.all => 34,
    };

    final games = List<CareGameStat>.generate(7, (i) {
      final play = perGamePlay[i] * (i == 0 && range == CareRange.week
          ? 18 ~/ 9
          : multiplier);
      return CareGameStat(
        activityId: 'demo_$i',
        category: categories[i],
        title: titles[i],
        playCount: play,
        avgScore: perGameAvg[i],
        bestScore: perGameBest[i],
        avgMinutes: (perGameAvg[i] / 16).clamp(2.5, 8.0).toDouble(),
        lastPlayedAt: today.subtract(Duration(days: i)),
        mostActiveDayKey: _dayLabel(i),
        mostActiveMinutes: 30 - i * 3,
      );
    });

    final recentSessions = sessions
        .map((s) => CareSessionRecord(
              activityId: s.$1,
              category: categories[s.$2],
              activityTitle: titles[s.$2],
              startedAt: today.subtract(Duration(minutes: s.$3)),
              minutes: s.$4 ~/ 10,
              score: s.$4,
              completed: s.$5,
            ))
        .toList();

    return CareProgress(
      range: range,
      today: CareTodaySummary(
        gamesPlayed: 3,
        playMinutes: 45,
        avgScore: 88.5,
        improvementPercent: range == CareRange.week ? 12.4 : 18.2,
      ),
      week: CareWeeklyStats(
        points: points,
        totalMinutes: range == CareRange.week
            ? totalMinutes
            : totalMinutes * multiplier,
        completedThisWeek: completedThisWeek,
        weekGoal: 15,
        avgScore: avgScore,
        improvementPercent: 7.8,
        streakDays: 4,
      ),
      games: games,
      sessions: recentSessions,
      skills: const [
        CareSkillScore(category: 'Memory', accuracyPercent: 88),
        CareSkillScore(category: 'Attention', accuracyPercent: 81),
        CareSkillScore(category: 'Language', accuracyPercent: 74),
        CareSkillScore(category: 'Problem Solving', accuracyPercent: 69),
      ],
      totalAttempts: 164 * multiplier + 18,
    );
  }

  static String _dayLabel(int i) => const [
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
        'Sun',
      ][i];
}