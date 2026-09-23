import 'package:drift/drift.dart';

import '../local/app_database.dart';
import '../models/enums.dart';

/// The memory garden: one garden per patient plus growing elements.
class GardenRepository {
  GardenRepository(this._db);

  final AppDatabase _db;

  Future<Garden> ensureGarden(String patientId) async {
    final existing = await gardenFor(patientId);
    if (existing != null) return existing;
    return createGarden(patientId);
  }

  Future<Garden> createGarden(String patientId) async {
    final id = 'garden.$patientId';
    final row = GardensCompanion.insert(id: id, patientId: patientId);
    await _db.into(_db.gardens).insert(row, mode: InsertMode.insertOrReplace);
    return (_db.select(_db.gardens)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<Garden?> gardenFor(String patientId) async {
    final rows = await (_db.select(
      _db.gardens,
    )..where((t) => t.patientId.equals(patientId))).get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<void> addPoints(String patientId, int points) async {
    final garden = await ensureGarden(patientId);
    final total = garden.points + points;
    await (_db.update(
      _db.gardens,
    )..where((t) => t.patientId.equals(patientId))).write(
      GardensCompanion(
        points: Value(total),
        lastGrownAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> bumpActivitiesCompleted(String patientId) async {
    final garden = await ensureGarden(patientId);
    await (_db.update(
      _db.gardens,
    )..where((t) => t.patientId.equals(patientId))).write(
      GardensCompanion(
        activitiesCompleted: Value(garden.activitiesCompleted + 1),
        lastGrownAt: Value(DateTime.now()),
      ),
    );
  }

  Future<GardenElement> plantSeed({
    required String gardenId,
    GardenSection section = GardenSection.garden,
    String? memoryId,
    String? label,
    String emoji = '🌱',
  }) async {
    final existing = await (_db.select(
      _db.gardenElements,
    )..where((t) => t.gardenId.equals(gardenId))).get();
    final id =
        'element.$gardenId.${existing.length + 1}.${DateTime.now().millisecondsSinceEpoch}';
    final row = GardenElementsCompanion.insert(
      id: id,
      gardenId: gardenId,
      kind: GardenElementKind.seed.name,
      section: Value(section.name),
      stage: PlantStage.seed,
      memoryId: Value(memoryId),
      label: Value(label),
      emoji: Value(emoji),
      plantedAt: DateTime.now(),
    );
    await _db.into(_db.gardenElements).insert(row);
    return (_db.select(
      _db.gardenElements,
    )..where((t) => t.id.equals(id))).getSingle();
  }

  Future<List<GardenElement>> elementsFor(
    String gardenId, {
    GardenSection? section,
  }) async {
    final query = _db.select(_db.gardenElements)
      ..where((t) => t.gardenId.equals(gardenId))
      ..orderBy([(t) => OrderingTerm.asc(t.plantedAt)]);
    if (section != null) {
      query.where((t) => t.section.equals(section.name));
    }
    return query.get();
  }

  Future<GardenElement?> elementById(String id) async {
    final rows = await (_db.select(
      _db.gardenElements,
    )..where((t) => t.id.equals(id))).get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<GardenElement> growElement({
    required String id,
    required PlantStage stage,
    required int gardenPointsGained,
    String? memoryId,
    String? label,
  }) async {
    final element = await elementById(id);
    if (element == null) {
      throw StateError('Garden element $id not found');
    }
    await (_db.update(_db.gardenElements)..where((t) => t.id.equals(id))).write(
      GardenElementsCompanion(
        stage: Value(stage),
        kind: Value(stageToKind(stage).name),
        memoryId: memoryId == null ? const Value.absent() : Value(memoryId),
        label: label == null ? const Value.absent() : Value(label),
        lastGrowthAt: Value(DateTime.now()),
      ),
    );
    // Garden gains points in the same transaction as growth.
    await addPoints(element.gardenId, gardenPointsGained);
    return (_db.select(
      _db.gardenElements,
    )..where((t) => t.id.equals(id))).getSingle();
  }

  static GardenElementKind stageToKind(PlantStage stage) => switch (stage) {
    PlantStage.seed => GardenElementKind.seed,
    PlantStage.sprout => GardenElementKind.plant,
    PlantStage.growing => GardenElementKind.plant,
    PlantStage.blooming => GardenElementKind.flower,
    PlantStage.mature => GardenElementKind.tree,
  };
}
