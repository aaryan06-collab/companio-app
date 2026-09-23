import 'dart:convert';

import 'package:drift/drift.dart';

import '../local/app_database.dart';
import '../models/enums.dart';

/// Personal memories + location memories.
class MemoryRepository {
  MemoryRepository(this._db);

  final AppDatabase _db;

  Future<Memory> addMemory({
    required String id,
    required String patientId,
    required MemoryKind kind,
    required String title,
    String? caption,
    String? relation,
    String? mediaPath,
    String? mediaUrl,
    MemoryCategory category = MemoryCategory.family,
    String? placeName,
    String? createdBy,
    List<MemoryPlacement> placements = const [],
  }) async {
    final now = DateTime.now();
    final row = MemoriesCompanion.insert(
      id: id,
      patientId: patientId,
      kind: kind.name,
      title: title,
      caption: Value(caption),
      relation: Value(relation),
      mediaPath: Value(mediaPath),
      mediaUrl: Value(mediaUrl),
      category: Value(category.name),
      placeName: Value(placeName),
      createdBy: Value(createdBy),
      placementsJson: Value(
        jsonEncode(placements.map((p) => p.name).toList(growable: false)),
      ),
      createdAt: now,
      updatedAt: now,
    );
    await _db.into(_db.memories).insert(row, mode: InsertMode.insertOrReplace);
    return (_db.select(
      _db.memories,
    )..where((t) => t.id.equals(id))).getSingle();
  }

  Future<List<Memory>> memoriesFor(
    String patientId, {
    MemoryCategory? category,
  }) async {
    final query = _db.select(_db.memories)
      ..where((t) => t.patientId.equals(patientId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    if (category != null) query.where((t) => t.category.equals(category.name));
    return query.get();
  }

  Future<List<Memory>> allMemories() => _db.select(_db.memories).get();

  Future<Memory?> memoryById(String id) async {
    final rows = await (_db.select(
      _db.memories,
    )..where((t) => t.id.equals(id))).get();
    return rows.isEmpty ? null : rows.first;
  }

  /// Records the server media URL onto an existing memory once its photo has
  /// been uploaded (so re-syncs and the patient device carry it).
  Future<void> updateMediaUrl(String id, String url) async {
    await (_db.update(
      _db.memories,
    )..where((t) => t.id.equals(id))).write(
      MemoriesCompanion(
        mediaUrl: Value(url),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteMemory(String id) =>
      (_db.delete(_db.memories)..where((t) => t.id.equals(id))).go();

  /// A gentle pick for the Mystery Memory / family memory on the home page.
  Future<Memory?> pickFamilyMemory(
    String patientId, {
    String? excludeId,
  }) async {
    final query = _db.select(_db.memories)
      ..where((t) => t.patientId.equals(patientId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    final rows = await query.get();
    if (rows.isEmpty) return null;
    if (excludeId != null) {
      final others = rows.where((r) => r.id != excludeId).toList();
      if (others.isNotEmpty) return others.first;
    }
    return rows.length > 1 ? rows[rows.length ~/ 2] : rows.first;
  }

  // ── Location memories ─────────────────────────────────────────────────
  Future<LocationMemory> addLocationMemory({
    required String id,
    required String patientId,
    required String name,
    String? region,
    String? state,
    String? notes,
    String? memoryId,
  }) async {
    final row = LocationMemoriesCompanion.insert(
      id: id,
      patientId: patientId,
      name: name,
      region: Value(region),
      state: Value(state),
      notes: Value(notes),
      memoryId: Value(memoryId),
      createdAt: DateTime.now(),
    );
    await _db
        .into(_db.locationMemories)
        .insert(row, mode: InsertMode.insertOrReplace);
    return (_db.select(
      _db.locationMemories,
    )..where((t) => t.id.equals(id))).getSingle();
  }

  Future<List<LocationMemory>> locationsFor(String patientId) async {
    final query = _db.select(_db.locationMemories)
      ..where((t) => t.patientId.equals(patientId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    return query.get();
  }

  Future<List<LocationMemory>> allLocationMemories() =>
      _db.select(_db.locationMemories).get();
}
