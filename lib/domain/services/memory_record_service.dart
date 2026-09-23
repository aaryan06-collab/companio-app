import 'package:uuid/uuid.dart';

import '../../data/local/app_database.dart';
import '../../data/models/enums.dart';
import '../../data/repositories/memory_repository.dart';
import 'garden_service.dart';

/// Caregiver-family content: photos, voice, stories and places become
/// memories and grow into the patient's garden.
class MemoryRecordService {
  MemoryRecordService(this._gardenService, this._memoryRepo);

  final GardenService _gardenService;
  final MemoryRepository _memoryRepo;

  Future<void> Function(Memory memory)? onMemoryAdded;

  Future<Memory> addMemory({
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
    GardenSection section = GardenSection.family,
  }) async {
    final memory = await _memoryRepo.addMemory(
      id: 'memory.${const Uuid().v4()}',
      patientId: patientId,
      kind: kind,
      title: title,
      caption: caption,
      relation: relation,
      mediaPath: mediaPath,
      mediaUrl: mediaUrl,
      category: category,
      placeName: placeName,
      createdBy: createdBy,
    );

    await _gardenService.remember(
      patientId: patientId,
      memoryId: memory.id,
      section: section,
    );

    await onMemoryAdded?.call(memory);
    return memory;
  }

  Future<void> deleteMemory(String id) => _memoryRepo.deleteMemory(id);

  Future<List<Memory>> patientMemories(String patientId) =>
      _memoryRepo.memoriesFor(patientId);
}
