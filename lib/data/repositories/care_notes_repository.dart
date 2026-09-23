import 'package:drift/drift.dart';

import '../local/app_database.dart';
import '../models/enums.dart';

/// Persists caregiver daily observation notes.
class CareNotesRepository {
  CareNotesRepository(this._db);

  final AppDatabase _db;

  Stream<List<DailyNote>> watchAll({String? patientId}) {
    final query = _db.select(_db.dailyNotes)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    if (patientId != null) {
      query.where((t) => t.patientId.equals(patientId));
    }
    return query.watch();
  }

  Future<List<DailyNote>> notesFor(String patientId) async {
    final query = _db.select(_db.dailyNotes)
      ..where((t) => t.patientId.equals(patientId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    return query.get();
  }

  Future<DailyNote> add({
    required String patientId,
    required NoteKind kind,
    required String body,
  }) {
    final id = 'note_${DateTime.now().microsecondsSinceEpoch}';
    final row = DailyNotesCompanion.insert(
      id: id,
      patientId: patientId,
      kind: Value(kind),
      body: body,
      createdAt: DateTime.now(),
    );
    return _db.transaction(() async {
      await _db.into(_db.dailyNotes).insert(row);
      final query = _db.select(_db.dailyNotes)..where((t) => t.id.equals(id));
      return query.getSingle();
    });
  }

  Future<void> updateContent(String id, {required String body}) async {
    await (_db.update(_db.dailyNotes)..where((t) => t.id.equals(id))).write(
      DailyNotesCompanion(body: Value(body)),
    );
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.dailyNotes)..where((t) => t.id.equals(id))).go();
  }
}
