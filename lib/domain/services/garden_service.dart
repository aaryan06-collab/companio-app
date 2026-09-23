import '../../data/local/app_database.dart';
import '../../data/models/enums.dart';
import '../../data/repositories/garden_repository.dart';
import '../../data/repositories/memory_repository.dart';

/// Outcome of a garden growth step, described for UI copy + celebration.
class GrowthResult {
  const GrowthResult({
    this.newElementId,
    this.grownElement,
    this.pointsEarned = 0,
    this.milestoneReached = false,
    this.memoryAttachedId,
  });

  final String? newElementId;
  final GardenElement? grownElement;
  final int pointsEarned;
  final bool milestoneReached;
  final String? memoryAttachedId;
}

/// Drives the Memory Garden: every completed activity gently grows a plant.
///
/// Pure growth rules (kept here so they are testable without a database):
///   seed → sprout → growing → blooming → mature
/// A new seed is planted when everything is mature, and every bloom can
/// carry a personal memory.
class GardenGrowthRules {
  static const List<PlantStage> sequence = [
    PlantStage.seed,
    PlantStage.sprout,
    PlantStage.growing,
    PlantStage.blooming,
    PlantStage.mature,
  ];

  static const Map<PlantStage, int> points = {
    PlantStage.seed: 10,
    PlantStage.sprout: 15,
    PlantStage.growing: 15,
    PlantStage.blooming: 20,
    PlantStage.mature: 25,
  };

  static const int milestoneEvery = 5;
  static const int maxPlants = 8;

  static int indexOf(PlantStage stage) => sequence.indexOf(stage);

  static PlantStage? next(PlantStage stage) {
    final i = indexOf(stage);
    if (i < 0 || i >= sequence.length - 1) return null;
    return sequence[i + 1];
  }

  static PlantStage initialForCount(int completedCount) {
    if (completedCount >= 4) return PlantStage.growing;
    if (completedCount >= 2) return PlantStage.sprout;
    return PlantStage.seed;
  }
}

/// Service that applies growth against persistent garden state.
class GardenService {
  GardenService(this._gardenRepo, this._memoryRepo);

  final GardenRepository _gardenRepo;
  final MemoryRepository _memoryRepo;

  /// Grows the garden after a completed activity. Returns what happened so
  /// the UI can celebrate it appropriately.
  Future<GrowthResult> onActivityCompleted(
    String patientId, {
    required int completionNumber,
    GardenSection section = GardenSection.garden,
  }) async {
    final garden = await _gardenRepo.ensureGarden(patientId);
    final elements = await _gardenRepo.elementsFor(garden.id);

    var milestoneReached =
        completionNumber % GardenGrowthRules.milestoneEvery == 0;

    // Pick the youngest element to grow (lowest stage index). If everything
    // is mature or the garden is empty, plant a new seed instead.
    GardenElement? youngest = elements.isEmpty ? null : elements.first;
    for (final e in elements) {
      if (GardenGrowthRules.indexOf(e.stage) <
          GardenGrowthRules.indexOf(youngest!.stage)) {
        youngest = e;
      }
    }

    if (youngest == null || youngest.stage == PlantStage.mature) {
      if ((youngest?.stage) == PlantStage.mature &&
          elements.length >= GardenGrowthRules.maxPlants) {
        // Garden is full and mature — just add points.
        await _gardenRepo.addPoints(
          patientId,
          GardenGrowthRules.points[PlantStage.mature]!,
        );
        await _gardenRepo.bumpActivitiesCompleted(patientId);
        return GrowthResult(
          pointsEarned: GardenGrowthRules.points[PlantStage.mature]!,
          milestoneReached: milestoneReached,
        );
      }
      final seed = await _gardenRepo.plantSeed(
        gardenId: garden.id,
        section: section,
        emoji: _emojiForSeed(completionNumber),
      );
      await _gardenRepo.bumpActivitiesCompleted(patientId);
      await _gardenRepo.growElement(
        id: seed.id,
        stage: GardenGrowthRules.initialForCount(completionNumber),
        gardenPointsGained: 0,
      );
      final grown = await _gardenRepo.elementById(seed.id);
      return GrowthResult(
        newElementId: seed.id,
        grownElement: grown,
        pointsEarned: GardenGrowthRules
            .points[GardenGrowthRules.initialForCount(completionNumber)]!,
        milestoneReached: milestoneReached,
      );
    }

    final nextStage = GardenGrowthRules.next(youngest.stage)!;
    var memoryId = youngest.memoryId;
    var attached = false;
    if (nextStage == PlantStage.blooming && memoryId == null) {
      final unattached = await _unattachedMemory(patientId);
      if (unattached != null) {
        memoryId = unattached.id;
        attached = true;
      }
    }
    final grown = await _gardenRepo.growElement(
      id: youngest.id,
      stage: nextStage,
      gardenPointsGained: 0,
      memoryId: memoryId,
    );
    await _gardenRepo.bumpActivitiesCompleted(patientId);
    return GrowthResult(
      grownElement: grown,
      pointsEarned: GardenGrowthRules.points[nextStage]!,
      milestoneReached: milestoneReached,
      memoryAttachedId: attached ? memoryId : null,
    );
  }

  Future<Memory?> _unattachedMemory(String patientId) async {
    final memories = await _memoryRepo.memoriesFor(patientId);
    for (final m in memories) {
      final inGarden = await _memoryInGarden(patientId, m.id);
      if (!inGarden) return m;
    }
    return null;
  }

  Future<bool> _memoryInGarden(String patientId, String memoryId) async {
    final garden = await _gardenRepo.gardenFor(patientId);
    if (garden == null) return false;
    final elements = await _gardenRepo.elementsFor(garden.id);
    return elements.any((e) => e.memoryId == memoryId);
  }

  /// When a personal memory is added, grow a plant for it in the given
  /// garden section so the garden reflects the patient's world.
  Future<GardenElement> remember({
    required String patientId,
    required String memoryId,
    GardenSection section = GardenSection.family,
  }) async {
    final garden = await _gardenRepo.ensureGarden(patientId);
    final existing = await _gardenRepo.elementsFor(garden.id, section: section);
    GardenElement? host;
    for (final e in existing) {
      if (e.memoryId == null) {
        host = e;
        break;
      }
    }
    if (host == null) {
      final seed = await _gardenRepo.plantSeed(
        gardenId: garden.id,
        section: section,
        memoryId: memoryId,
        emoji: _emojiForSeed(DateTime.now().millisecond),
      );
      final grown = await _gardenRepo.growElement(
        id: seed.id,
        stage: PlantStage.blooming,
        gardenPointsGained: 10,
        memoryId: memoryId,
      );
      return grown;
    }
    await _gardenRepo.growElement(
      id: host.id,
      stage: PlantStage.blooming,
      gardenPointsGained: 10,
      memoryId: memoryId,
    );
    final grown = await _gardenRepo.elementById(host.id);
    if (grown == null) throw StateError('Garden element ${host.id} missing');
    return grown;
  }

  String _emojiForSeed(int completionNumber) {
    const emojis = ['🌱', '🍀', '🌿', '🌾', '🪴', '🌻'];
    return emojis[completionNumber % emojis.length];
  }
}

/// Stable public mapping from stage to the UI label + emoji.
abstract final class GardenPresentation {
  static (String emoji, PlantStage stage) emojiFor({
    required GardenElementKind kind,
    required PlantStage stage,
    int seedIndex = 0,
  }) {
    if (stage == PlantStage.mature) return ('🌳', PlantStage.mature);
    return switch (kind) {
      GardenElementKind.seed => ('🌱', PlantStage.seed),
      GardenElementKind.plant => ('🌿', PlantStage.growing),
      GardenElementKind.flower => ('🌸', PlantStage.blooming),
      GardenElementKind.tree => ('🌳', PlantStage.mature),
      GardenElementKind.statue => ('🌼', PlantStage.mature),
      GardenElementKind.milestone => ('🏵️', PlantStage.mature),
    };
  }

  static String l10nKeyForStage(PlantStage stage) => switch (stage) {
    PlantStage.seed => 'gardenSeed',
    PlantStage.sprout => 'gardenPlant',
    PlantStage.growing => 'growing',
    PlantStage.blooming => 'blooming',
    PlantStage.mature => 'mature',
  };
}
