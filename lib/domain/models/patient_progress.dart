import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Patient-facing progress summary for the Garden (progress) view.
///
/// NOTE: The figures below are DEMO data, kept intentionally separate from
/// the real activity/session tables so the UI can later be wired to real
/// analytics without changing the presentation layer.
class PatientProgress {
  const PatientProgress({
    required this.gamesPlayedTotal,
    required this.bestStreakDays,
    required this.gamesThisWeek,
    required this.avgSessionMinutes,
  });

  final int gamesPlayedTotal;
  final int bestStreakDays;
  final int gamesThisWeek;
  final int avgSessionMinutes;
}

/// Demo values shown until real analytics replace this provider.
const PatientProgress demoPatientProgress = PatientProgress(
  gamesPlayedTotal: 12,
  bestStreakDays: 5,
  gamesThisWeek: 3,
  avgSessionMinutes: 3,
);

/// Single source for the patient progress screen (mock today).
final patientProgressProvider = Provider<PatientProgress>(
  (ref) => demoPatientProgress,
);
