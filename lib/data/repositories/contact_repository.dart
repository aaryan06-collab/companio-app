import 'package:drift/drift.dart';

import '../local/app_database.dart';
import '../models/enums.dart';

/// Emergency/family contacts used by the SOS flow.
class ContactRepository {
  ContactRepository(this._db);

  final AppDatabase _db;

  Future<EmergencyContact> addContact({
    required String id,
    required String patientId,
    required String name,
    required String phone,
    String? relation,
    EscalationPriority priority = EscalationPriority.primary,
    bool canCall = true,
    bool canSms = true,
  }) async {
    final row = EmergencyContactsCompanion.insert(
      id: id,
      patientId: patientId,
      name: name,
      phone: phone,
      relation: Value(relation),
      priority: priority,
      canCall: Value(canCall),
      canSms: Value(canSms),
      createdAt: DateTime.now(),
    );
    await _db
        .into(_db.emergencyContacts)
        .insert(row, mode: InsertMode.insertOrReplace);
    return (_db.select(
      _db.emergencyContacts,
    )..where((t) => t.id.equals(id))).getSingle();
  }

  Future<List<EmergencyContact>> contactsFor(String patientId) async {
    final query = _db.select(_db.emergencyContacts)
      ..where((t) => t.patientId.equals(patientId))
      ..orderBy([
        (t) => OrderingTerm.asc(t.priority),
        (t) => OrderingTerm.asc(t.createdAt),
      ]);
    return query.get();
  }

  Future<List<EmergencyContact>> escalationOrder(String patientId) async {
    final all = await contactsFor(patientId);
    const order = [
      EscalationPriority.primary,
      EscalationPriority.secondary,
      EscalationPriority.tertiary,
    ];
    all.sort((a, b) {
      final ai = order.indexOf(a.priority);
      final bi = order.indexOf(b.priority);
      return ai.compareTo(bi);
    });
    return all;
  }

  Future<EmergencyContact?> contactById(String id) async {
    final rows = await (_db.select(
      _db.emergencyContacts,
    )..where((t) => t.id.equals(id))).get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<void> updateContact(
    String id, {
    String? name,
    String? phone,
    String? relation,
    EscalationPriority? priority,
  }) async {
    await (_db.update(
      _db.emergencyContacts,
    )..where((t) => t.id.equals(id))).write(
      EmergencyContactsCompanion(
        name: name == null ? const Value.absent() : Value(name),
        phone: phone == null ? const Value.absent() : Value(phone),
        relation: relation == null ? const Value.absent() : Value(relation),
        priority: priority == null ? const Value.absent() : Value(priority),
      ),
    );
  }

  Future<void> deleteContact(String id) =>
      (_db.delete(_db.emergencyContacts)..where((t) => t.id.equals(id))).go();

  Future<bool> hasAnyContact(String patientId) async =>
      (await contactsFor(patientId)).isNotEmpty;
}
