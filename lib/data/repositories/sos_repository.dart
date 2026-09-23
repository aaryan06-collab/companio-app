import 'package:drift/drift.dart';

import '../local/app_database.dart';
import '../models/enums.dart';

/// SOS incidents and per-contact attempt records.
class SosRepository {
  SosRepository(this._db);

  final AppDatabase _db;

  Future<SosIncident> startIncident({
    required String id,
    required String patientId,
  }) async {
    final row = SosIncidentsCompanion.insert(
      id: id,
      patientId: patientId,
      startedAt: DateTime.now(),
      status: SosStatus.active,
    );
    await _db.into(_db.sosIncidents).insert(row);
    return (_db.select(
      _db.sosIncidents,
    )..where((t) => t.id.equals(id))).getSingle();
  }

  Future<SosIncident?> activeIncident(String patientId) async {
    final rows =
        await (_db.select(_db.sosIncidents)
              ..where(
                (t) =>
                    t.patientId.equals(patientId) &
                    t.status.isIn([
                      SosStatus.active.name,
                      SosStatus.acknowledged.name,
                    ]),
              )
              ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
            .get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<SosIncident?> incidentById(String id) async {
    final rows = await (_db.select(
      _db.sosIncidents,
    )..where((t) => t.id.equals(id))).get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<List<SosIncident>> incidentsFor(
    String patientId, {
    int limit = 20,
  }) async {
    final query = _db.select(_db.sosIncidents)
      ..where((t) => t.patientId.equals(patientId))
      ..orderBy([(t) => OrderingTerm.desc(t.startedAt)])
      ..limit(limit);
    return query.get();
  }

  Future<SosIncident> updateIncident(
    String id, {
    SosStatus? status,
    int? escalationStep,
    String? currentContactId,
    AttemptMethod? currentMethod,
    DateTime? lastAttemptAt,
    DateTime? acknowledgedAt,
    DateTime? resolvedAt,
    String? notes,
  }) async {
    await (_db.update(_db.sosIncidents)..where((t) => t.id.equals(id))).write(
      SosIncidentsCompanion(
        status: status == null ? const Value.absent() : Value(status),
        escalationStep: escalationStep == null
            ? const Value.absent()
            : Value(escalationStep),
        currentContactId: currentContactId == null
            ? const Value.absent()
            : Value(currentContactId),
        currentMethod: currentMethod == null
            ? const Value.absent()
            : Value(currentMethod.name),
        lastAttemptAt: lastAttemptAt == null
            ? const Value.absent()
            : Value(lastAttemptAt),
        acknowledgedAt: acknowledgedAt == null
            ? const Value.absent()
            : Value(acknowledgedAt),
        resolvedAt: resolvedAt == null
            ? const Value.absent()
            : Value(resolvedAt),
        notes: notes == null ? const Value.absent() : Value(notes),
      ),
    );
    return (_db.select(
      _db.sosIncidents,
    )..where((t) => t.id.equals(id))).getSingle();
  }

  Future<SosContactAttempt> recordAttempt({
    required String id,
    required String incidentId,
    required String contactId,
    required int attemptOrder,
    AttemptMethod method = AttemptMethod.call,
    ContactAttemptStatus status = ContactAttemptStatus.attempted,
    DateTime? respondedAt,
  }) async {
    final row = SosContactAttemptsCompanion.insert(
      id: id,
      incidentId: incidentId,
      contactId: contactId,
      attemptOrder: attemptOrder,
      method: method.name,
      status: status,
      attemptedAt: DateTime.now(),
      respondedAt: Value(respondedAt),
    );
    await _db.into(_db.sosContactAttempts).insert(row);
    return (_db.select(
      _db.sosContactAttempts,
    )..where((t) => t.id.equals(id))).getSingle();
  }

  Future<List<SosContactAttempt>> attemptsFor(String incidentId) async {
    final query = _db.select(_db.sosContactAttempts)
      ..where((t) => t.incidentId.equals(incidentId))
      ..orderBy([(t) => OrderingTerm.asc(t.attemptOrder)]);
    return query.get();
  }
}
