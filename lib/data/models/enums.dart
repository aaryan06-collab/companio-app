/// Shared enum types used across the Companio data layer.
library;

enum UserRole { patient, caregiver }

enum EscalationPriority { primary, secondary, tertiary }

enum ActivityType {
  matching,
  sequence,
  shopping,
  kitchen,
  recognition,
  association,
  recall,
  attention,
  pairs,
  sequenceRecall,
  findChanged;

  static ActivityType fromString(String value) =>
      ActivityType.values.firstWhere(
        (e) => e.name == value,
        orElse: () => ActivityType.recognition,
      );
}

enum Difficulty { gentle, comfortable, challenging }

enum DailyStatus { assigned, completed }

enum SyncStatus { pending, syncing, synced, failed }

enum SyncOperation { create, update, delete }

enum PlantStage {
  seed,
  sprout,
  growing,
  blooming,
  mature;

  static PlantStage fromString(String value) => PlantStage.values.firstWhere(
    (e) => e.name == value,
    orElse: () => PlantStage.seed,
  );
}

enum SosStatus {
  active,
  acknowledged,
  resolved,
  cancelled;

  static SosStatus fromString(String value) => SosStatus.values.firstWhere(
    (e) => e.name == value,
    orElse: () => SosStatus.active,
  );
}

enum ContactAttemptStatus {
  attempted,
  responded,
  failed;

  static ContactAttemptStatus fromString(String value) =>
      ContactAttemptStatus.values.firstWhere(
        (e) => e.name == value,
        orElse: () => ContactAttemptStatus.attempted,
      );
}

enum AttemptMethod { call, sms }

enum MemoryKind {
  photo,
  voice,
  text,
  sound,
  place;

  static MemoryKind fromString(String value) => MemoryKind.values.firstWhere(
    (e) => e.name == value,
    orElse: () => MemoryKind.text,
  );
}

enum MemoryCategory {
  family,
  childhood,
  places,
  festivals,
  important;

  static MemoryCategory fromString(String value) => MemoryCategory.values
      .firstWhere((e) => e.name == value, orElse: () => MemoryCategory.family);
}

enum GardenElementKind {
  seed,
  plant,
  flower,
  tree,
  statue,
  milestone;

  static GardenElementKind fromString(String value) => GardenElementKind.values
      .firstWhere((e) => e.name == value, orElse: () => GardenElementKind.seed);
}

enum GardenSection {
  garden,
  family,
  childhood,
  places,
  festivals;

  static GardenSection fromString(String value) => GardenSection.values
      .firstWhere((e) => e.name == value, orElse: () => GardenSection.garden);
}

/// Categories of a caregiver's daily observation note.
enum NoteKind {
  general,
  mood,
  activities,
  health;

  static NoteKind fromString(String value) => NoteKind.values.firstWhere(
    (e) => e.name == value,
    orElse: () => NoteKind.general,
  );
}

/// Where a caregiver-added memory can surface in the patient experience.
enum MemoryPlacement {
  garden,
  mystery,
  rescue,
  pictureMatch,
  familiarObjects,
  familyMemories;

  static MemoryPlacement fromString(String value) => MemoryPlacement.values
      .firstWhere((e) => e.name == value, orElse: () => MemoryPlacement.garden);

  /// The garden section used when this placement grows in the Memory Garden.
  GardenSection get gardenSection => switch (this) {
    MemoryPlacement.garden => GardenSection.garden,
    MemoryPlacement.familyMemories => GardenSection.family,
    MemoryPlacement.pictureMatch => GardenSection.childhood,
    MemoryPlacement.familiarObjects => GardenSection.places,
    MemoryPlacement.rescue ||
    MemoryPlacement.mystery => GardenSection.festivals,
  };
}
