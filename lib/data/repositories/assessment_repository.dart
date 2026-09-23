import 'package:drift/drift.dart';

import '../local/app_database.dart';

/// Stores cognitive screening check-ups (purely local, like the adaptive
/// profile). The latest record drives the patient's shown status.
class AssessmentRepository {
  AssessmentRepository(this._db);

  final AppDatabase _db;

  Future<CognitiveAssessment?> latest(String patientId) async {
    final row =
        await (_db.select(_db.cognitiveAssessments)
              ..where((t) => t.patientId.equals(patientId))
              ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
              ..limit(1))
            .getSingleOrNull();
    return row;
  }

  Future<void> save(CognitiveAssessment assessment) async {
    await _db
        .into(_db.cognitiveAssessments)
        .insert(
          CognitiveAssessmentsCompanion.insert(
            id: assessment.id,
            patientId: assessment.patientId,
            score: assessment.score,
            maxScore: assessment.maxScore,
            answersJson: assessment.answersJson,
            statusKey: assessment.statusKey,
            createdAt: assessment.createdAt,
          ),
        );
  }
}
