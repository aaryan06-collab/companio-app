import 'dart:convert';

import 'package:drift/drift.dart';

import '../../data/local/app_database.dart';
import '../../data/models/enums.dart';

// Per-category performance stats used to personalize difficulty.
class CategoryStat {
  const CategoryStat({this.attempts = 0, this.correct = 0, this.hints = 0});

  final int attempts;
  final int correct;
  final int hints;

  double get accuracy => attempts == 0 ? 1 : correct / attempts;

  CategoryStat copyWith({int? attempts, int? correct, int? hints}) =>
      CategoryStat(
        attempts: attempts ?? this.attempts,
        correct: correct ?? this.correct,
        hints: hints ?? this.hints,
      );

  Map<String, Object?> toJson() => {
    'attempts': attempts,
    'correct': correct,
    'hints': hints,
  };

  static CategoryStat fromJson(Map<String, Object?> json) => CategoryStat(
    attempts: (json['attempts'] as num?)?.toInt() ?? 0,
    correct: (json['correct'] as num?)?.toInt() ?? 0,
    hints: (json['hints'] as num?)?.toInt() ?? 0,
  );
}

// Pure adaptive rules — unit-testable without any I/O.
abstract final class AdaptiveRules {
  /// Adjusts difficulty after an attempt using gentle, encouraging signals.
  /// Returns [current] unchanged if performance falls in the "comfort zone"
  /// (accuracy in [0.45, 0.85) with few hints), keeping the patient's
  /// current level rather than toggling up or down.
  static Difficulty nextDifficulty({
    required Difficulty current,
    required int hintCount,
    required int correctCount,
    required int totalCount,
  }) {
    if (totalCount <= 0) return current;

    final accuracy = correctCount / totalCount;
    final fewHints = hintCount <= 1;
    final manyHints = hintCount >= 3;

    // "Comfort zone": keep current difficulty if accuracy is moderate
    // (>= 0.45 and < 0.85) and few hints were used.
    if (accuracy >= 0.45 && accuracy < 0.85 && fewHints) {
      return current;
    }

    // Raise difficulty only for strong performance: >= 0.85 accuracy
    // with not too many hints ( < 3 ).
    if (accuracy >= 0.85 && !manyHints) {
      return _raise(current);
    }

    // Lower difficulty only if clearly struggling: accuracy < 0.45
    // or using 3+ hints.
    if (accuracy < 0.45 || manyHints) {
      return _lower(current);
    }

    // Fall through: moderate performance with many hints — keep current.
    return current;
  }

  /// Overall difficulty blended toward the latest observation.
  static Difficulty blend(Difficulty current, Difficulty observed) {
    final delta =
        Difficulty.values.indexOf(observed) -
        Difficulty.values.indexOf(current);
    if (delta == 0) return current;
    if (delta > 0) return _raise(current);
    return _lower(current);
  }

  /// Effective difficulty for one activity: keep it within a step of the
  /// patient's overall level while honoring the activity's own baseline.
  static Difficulty effective({
    required Difficulty baseline,
    required Difficulty overall,
  }) {
    final base = _index(baseline) + (_index(overall) - 1);
    return Difficulty.values[base.clamp(0, Difficulty.values.length - 1)];
  }

  static int _index(Difficulty d) => Difficulty.values.indexOf(d);

  static Difficulty _raise(Difficulty d) => switch (d) {
    Difficulty.gentle => Difficulty.comfortable,
    Difficulty.comfortable => Difficulty.challenging,
    Difficulty.challenging => Difficulty.challenging,
  };

  static Difficulty _lower(Difficulty d) => switch (d) {
    Difficulty.gentle => Difficulty.gentle,
    Difficulty.comfortable => Difficulty.gentle,
    Difficulty.challenging => Difficulty.comfortable,
  };
}

// Persists and personalizes adaptive difficulty per patient.
class AdaptiveService {
  AdaptiveService(this._db);

  final AppDatabase _db;

  Future<Difficulty> overallDifficulty(String patientId) async {
    final rows = await (_db.select(
      _db.adaptiveProfiles,
    )..where((t) => t.patientId.equals(patientId))).get();
    if (rows.isEmpty) return Difficulty.gentle;
    return rows.first.overallDifficulty;
  }

  Future<Map<String, CategoryStat>> categoryStats(String patientId) async {
    final rows = await (_db.select(
      _db.adaptiveProfiles,
    )..where((t) => t.patientId.equals(patientId))).get();
    if (rows.isEmpty) return {};
    final map = safeDecodeStats(rows.first.categoryStatsJson);
    return map;
  }

  /// Records an activity outcome and persists updated overall difficulty.
  Future<Difficulty> recordOutcome({
    required String patientId,
    required String category,
    required int correctCount,
    required int totalCount,
    required int hintCount,
  }) async {
    final current = await overallDifficulty(patientId);
    final outcome = AdaptiveRules.nextDifficulty(
      current: current,
      hintCount: hintCount,
      correctCount: correctCount,
      totalCount: totalCount,
    );
    final blended = AdaptiveRules.blend(current, outcome);

    final stats = await categoryStats(patientId);
    final existing = stats[category] ?? const CategoryStat();
    stats[category] = existing.copyWith(
      attempts: existing.attempts + 1,
      correct: existing.correct + correctCount,
      hints: existing.hints + hintCount,
    );

    await (_db.into(_db.adaptiveProfiles)).insert(
      AdaptiveProfilesCompanion.insert(
        patientId: patientId,
        overallDifficulty: blended,
        categoryStatsJson: Value(
          jsonEncode(stats.map((k, v) => MapEntry(k, v.toJson()))),
        ),
        updatedAt: DateTime.now(),
      ),
    );
    return blended;
  }

  static Map<String, CategoryStat> safeDecodeStats(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return {};
      return decoded.map((k, v) {
        final m = (v as Map).cast<String, dynamic>().map(
          (k2, v2) => MapEntry(k2, v2 as Object?),
        );
        return MapEntry(k, CategoryStat.fromJson(m));
      });
    } catch (_) {
      return {};
    }
  }
}
