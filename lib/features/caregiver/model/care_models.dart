import '../../../data/models/enums.dart';

/// Time ranges the caregiver Progress screen can bucket data into.
enum CareRange {
  week,
  month,
  all;

  String get apiValue => switch (this) {
    CareRange.week => 'week',
    CareRange.month => 'month',
    CareRange.all => 'all',
  };
}

/// A patient as seen from the caregiver side (local or remote).
class CarePatient {
  const CarePatient({
    required this.id,
    required this.name,
    this.region,
    this.dateOfBirth,
    this.avatarEmoji = '🌸',
  });

  factory CarePatient.fromName(String id, String name, {String? region}) =>
      CarePatient(id: id, name: name, region: region);

  final String id;
  final String name;
  final String? region;
  final DateTime? dateOfBirth;
  final String avatarEmoji;

  /// Approximate age in completed years; null when unknown.
  int? get age {
    final dob = dateOfBirth;
    if (dob == null) return null;
    final now = DateTime.now();
    var years = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      years -= 1;
    }
    return years >= 0 ? years : null;
  }
}

/// The two-by-two "Today at a glance" summary card.
class CareTodaySummary {
  const CareTodaySummary({
    this.gamesPlayed = 0,
    this.playMinutes = 0,
    this.avgScore = 0,
    this.improvementPercent = 0,
  });

  final int gamesPlayed;
  final int playMinutes;
  final double avgScore; // 0..100
  final double improvementPercent; // compared with previous period
}

/// One day's worth of engagement on the weekly bar chart.
class CareDayPoint {
  const CareDayPoint({
    required this.day,
    this.playMinutes = 0,
    this.completed = 0,
    this.avgScore = 0,
    this.isToday = false,
  });

  final DateTime day;
  final int playMinutes;
  final int completed;
  final double avgScore;
  final bool isToday;
}

class CareWeeklyStats {
  const CareWeeklyStats({
    this.points = const [],
    this.totalMinutes = 0,
    this.completedThisWeek = 0,
    this.weekGoal = 0,
    this.avgScore = 0,
    this.improvementPercent = 0,
    this.streakDays = 0,
  });

  final List<CareDayPoint> points;
  final int totalMinutes;
  final int completedThisWeek;
  final int weekGoal;
  final double avgScore;
  final double improvementPercent;
  final int streakDays;
}

/// Performance of a single game/activity across the selected range.
class CareGameStat {
  const CareGameStat({
    required this.activityId,
    required this.category,
    required this.title,
    this.playCount = 0,
    this.avgScore = 0,
    this.bestScore = 0,
    this.avgMinutes = 0,
    this.lastPlayedAt,
    this.mostActiveDayKey = '',
    this.mostActiveMinutes = 0,
  });

  final String activityId;
  final String category;
  final String title;
  final int playCount;
  final double avgScore;
  final double bestScore;
  final double avgMinutes;
  final DateTime? lastPlayedAt;
  final String mostActiveDayKey;
  final int mostActiveMinutes;
}

/// One completed game session in the recent-sessions timeline.
class CareSessionRecord {
  const CareSessionRecord({
    required this.activityId,
    required this.category,
    required this.activityTitle,
    required this.startedAt,
    this.minutes = 0,
    this.score = 0,
    this.completed = true,
  });

  final String activityId;
  final String category;
  final String activityTitle;
  final DateTime startedAt;
  final int minutes;
  final double score;
  final bool completed;
}

class CareSkillScore {
  const CareSkillScore({required this.category, required this.accuracyPercent});

  final String category;
  final int accuracyPercent;
}

/// Everything the Progress screen needs for a selected range.
class CareProgress {
  const CareProgress({
    this.range = CareRange.week,
    required this.today,
    required this.week,
    this.games = const [],
    this.sessions = const [],
    this.skills = const [],
    this.totalAttempts = 0,
  });

  /// No data yet (patient just linked, or offline with an empty local set).
  const CareProgress.empty([this.range = CareRange.week])
    : today = const CareTodaySummary(),
      week = const CareWeeklyStats(),
      games = const [],
      sessions = const [],
      skills = const [],
      totalAttempts = 0;

  final CareRange range;
  final CareTodaySummary today;
  final CareWeeklyStats week;
  final List<CareGameStat> games;
  final List<CareSessionRecord> sessions;
  final List<CareSkillScore> skills;
  final int totalAttempts;
}

/// A caregiver daily observation note.
class CareDailyNote {
  const CareDailyNote({
    required this.id,
    required this.patientId,
    this.kind = NoteKind.general,
    required this.body,
    required this.createdAt,
  });

  final String id;
  final String patientId;
  final NoteKind kind;
  final String body;
  final DateTime createdAt;
}

/// A caregiver-authored memory draft that unlocks in the patient experience.
class CareMemoryDraft {
  const CareMemoryDraft({
    this.id,
    this.title = '',
    this.caption = '',
    this.placeName,
    this.kind = MemoryKind.text,
    this.category = MemoryCategory.family,
    this.placements = const <MemoryPlacement>[MemoryPlacement.garden],
  });

  final String? id;
  final String title;
  final String caption;
  final String? placeName;
  final MemoryKind kind;
  final MemoryCategory category;
  final List<MemoryPlacement> placements;
}

/// Caregiver display + notification preferences.
class CareSettingsModel {
  const CareSettingsModel({
    this.fontStep = 1,
    this.highContrast = false,
    this.reminders = true,
    this.weeklyReports = true,
    this.sosAlerts = true,
  });

  /// 1 = normal, 2 = large, 3 = extra large (persisted as an int step).
  final int fontStep;
  final bool highContrast;
  final bool reminders;
  final bool weeklyReports;
  final bool sosAlerts;

  /// Multiplier applied to the caregiver text theme.
  double get textScaleFactor => switch (fontStep) {
    2 => 1.2,
    3 => 1.4,
    _ => 1.0,
  };

  CareSettingsModel copyWith({
    int? fontStep,
    bool? highContrast,
    bool? reminders,
    bool? weeklyReports,
    bool? sosAlerts,
  }) => CareSettingsModel(
    fontStep: fontStep ?? this.fontStep,
    highContrast: highContrast ?? this.highContrast,
    reminders: reminders ?? this.reminders,
    weeklyReports: weeklyReports ?? this.weeklyReports,
    sosAlerts: sosAlerts ?? this.sosAlerts,
  );
}

/// A gamified milestone the caregiver celebrates with the patient.
class CareAchievement {
  const CareAchievement({
    required this.id,
    required this.iconEmoji,
    required this.title,
    this.subtitle = '',
    this.progress = 0, // 0..1
    this.unlockedAt,
  });

  final String id;
  final String iconEmoji;
  final String title;
  final String subtitle;
  final double progress;
  final DateTime? unlockedAt;

  bool get unlocked => unlockedAt != null || progress >= 1;
}

/// A reminder displayed on the caregiver home ("due today" style).
class CareSuggestion {
  const CareSuggestion({
    required this.iconEmoji,
    required this.title,
    required this.subtitle,
    this.cta,
  });

  final String iconEmoji;
  final String title;
  final String subtitle;
  final String? cta;
}

/// Emergency contacts grouped by their escalation role.
class CareEscalationGroup {
  const CareEscalationGroup({required this.main, required this.family});

  final List<CareContact> main;
  final List<CareContact> family;
}

class CareContact {
  const CareContact({
    required this.id,
    required this.name,
    this.phone,
    this.relation,
    this.orderIndex = 0,
  });

  final String id;
  final String name;
  final String? phone;
  final String? relation;
  final int orderIndex;
}
