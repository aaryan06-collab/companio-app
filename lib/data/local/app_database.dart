import 'package:drift/drift.dart';

import 'executors/database_executor_io.dart'
    if (dart.library.js_interop) 'executors/database_executor_web.dart'
    as exec;

import '../../core/utilities/local_dates.dart';
import '../models/enums.dart';

part 'app_database.g.dart';

/// Users (both patient and caregiver accounts live here).
class Users extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get role => text()();
  TextColumn get username => text().nullable().unique()();
  TextColumn get passwordHash => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Patient-specific profile details that personalize the experience.
class PatientProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get displayName => text()();
  TextColumn get region => text().nullable()();
  TextColumn get language => text().withDefault(const Constant('hi'))();
  TextColumn get voiceLanguage => text().withDefault(const Constant('hi-IN'))();
  TextColumn get avatarEmoji => text().withDefault(const Constant('🌸'))();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Caregiver daily observation notes about their patient.
class DailyNotes extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  TextColumn get kind =>
      textEnum<NoteKind>().withDefault(const Constant('general'))();
  TextColumn get body => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Caregiver-side application settings (display + notifications).
class CaregiverSettings extends Table {
  TextColumn get id => text()(); // 'caregiver' singleton row
  IntColumn get fontStep => integer().withDefault(const Constant(1))();
  BoolColumn get highContrast => boolean().withDefault(const Constant(false))();
  BoolColumn get reminders => boolean().withDefault(const Constant(true))();
  BoolColumn get weeklyReports => boolean().withDefault(const Constant(true))();
  BoolColumn get sosAlerts => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Links caregiver accounts to patient accounts.
class CaregiverLinks extends Table {
  TextColumn get id => text()();
  TextColumn get caregiverId => text()();
  TextColumn get patientId => text()();
  TextColumn get relationship => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Emergency contacts used by the SOS flow (family/caregivers, never
/// implied to be official emergency services).
class EmergencyContacts extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  TextColumn get name => text()();
  TextColumn get phone => text()();
  TextColumn get relation => text().nullable()();
  TextColumn get priority => textEnum<EscalationPriority>()();
  BoolColumn get canCall => boolean().withDefault(const Constant(true))();
  BoolColumn get canSms => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Data-driven activity catalog entries.
class Activities extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  TextColumn get titleKey => text()();
  TextColumn get subtitleKey => text().nullable()();
  TextColumn get category => text()();
  TextColumn get baseDifficulty => textEnum<Difficulty>()();
  IntColumn get durationSec => integer().withDefault(const Constant(180))();
  TextColumn get contentJson => text()();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();
  TextColumn get region => text().nullable()();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// One gentle activity assigned per day.
class DailyActivities extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  TextColumn get activityId => text()();
  TextColumn get forDate => text()();
  TextColumn get status => textEnum<DailyStatus>()();
  DateTimeColumn get assignedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Every attempt at an activity, fully local.
class ActivityAttempts extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  TextColumn get activityId => text()();
  TextColumn get dailyActivityId => text().nullable()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get finishedAt => dateTime().nullable()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  IntColumn get correctCount => integer().withDefault(const Constant(0))();
  IntColumn get totalCount => integer().withDefault(const Constant(0))();
  IntColumn get hintCount => integer().withDefault(const Constant(0))();
  TextColumn get difficulty => textEnum<Difficulty>()();
  TextColumn get resultJson => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Personal memories added by family/caregivers or by the patient.
class Memories extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  TextColumn get kind => text()();
  TextColumn get title => text()();
  TextColumn get caption => text().nullable()();
  TextColumn get relation => text().nullable()();
  TextColumn get mediaPath => text().nullable()();
  TextColumn get mediaUrl => text().nullable()();
  TextColumn get category => text().withDefault(const Constant('family'))();
  TextColumn get placeName => text().nullable()();
  TextColumn get createdBy => text().nullable()();
  TextColumn get placementsJson => text().withDefault(const Constant('[]'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// The patient's memory garden (one per patient).
class Gardens extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  TextColumn get name => text().withDefault(const Constant('Memory Garden'))();
  IntColumn get points => integer().withDefault(const Constant(0))();
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get activitiesCompleted =>
      integer().withDefault(const Constant(0))();
  DateTimeColumn get lastGrownAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Elements in the garden (seeds growing into plants, flowers, trees).
class GardenElements extends Table {
  TextColumn get id => text()();
  TextColumn get gardenId => text()();
  TextColumn get kind => text()();
  TextColumn get section => text().withDefault(const Constant('garden'))();
  TextColumn get stage => textEnum<PlantStage>()();
  TextColumn get memoryId => text().nullable()();
  TextColumn get label => text().nullable()();
  TextColumn get emoji => text().withDefault(const Constant('🌱'))();
  DateTimeColumn get plantedAt => dateTime()();
  DateTimeColumn get lastGrowthAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Offline reminders (medicine, appointments, routines).
class Reminders extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  TextColumn get title => text()();
  TextColumn get detail => text().nullable()();
  IntColumn get hour => integer()();
  IntColumn get minute => integer()();
  TextColumn get kind => text().withDefault(const Constant('routine'))();
  TextColumn get daysJson => text().withDefault(const Constant('[]'))();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// In-app notification log (also bridged to OS notifications).
class Notifications extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text().nullable()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get type => text().withDefault(const Constant('info'))();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// SOS incidents and their lifecycle.
class SosIncidents extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  DateTimeColumn get startedAt => dateTime()();
  TextColumn get status => textEnum<SosStatus>()();
  IntColumn get escalationStep => integer().withDefault(const Constant(0))();
  TextColumn get currentContactId => text().nullable()();
  TextColumn get currentMethod => text().withDefault(const Constant('call'))();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  DateTimeColumn get acknowledgedAt => dateTime().nullable()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Per-incident contact attempt records.
class SosContactAttempts extends Table {
  TextColumn get id => text()();
  TextColumn get incidentId => text()();
  TextColumn get contactId => text()();
  IntColumn get attemptOrder => integer()();
  TextColumn get method => text()();
  TextColumn get status => textEnum<ContactAttemptStatus>()();
  DateTimeColumn get attemptedAt => dateTime()();
  DateTimeColumn get respondedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// The idempotent synchronization queue — heart of offline-first sync.
class SyncQueueItems extends Table {
  TextColumn get id => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get operation => text()();
  TextColumn get payloadJson => text()();
  TextColumn get status => textEnum<SyncStatus>()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get idempotencyKey => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  TextColumn get lastError => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Per-patient preferences.
class UserPreferences extends Table {
  TextColumn get patientId => text()();
  TextColumn get language => text().withDefault(const Constant('hi'))();
  TextColumn get voiceLanguage => text().withDefault(const Constant('hi-IN'))();
  BoolColumn get speechPrompts => boolean().withDefault(const Constant(true))();
  BoolColumn get reducedMotion =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get largeText => boolean().withDefault(const Constant(true))();
  BoolColumn get soundEffects => boolean().withDefault(const Constant(true))();
  BoolColumn get demoMode => boolean().withDefault(const Constant(false))();
  IntColumn get escalationMinutes => integer().withDefault(const Constant(3))();
  DateTimeColumn get onboardedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {patientId};
}

/// Adaptive difficulty tracking per patient per category.
class AdaptiveProfiles extends Table {
  TextColumn get patientId => text()();
  TextColumn get overallDifficulty => textEnum<Difficulty>()();
  TextColumn get categoryStatsJson =>
      text().withDefault(const Constant('{}'))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {patientId};
}

/// Places meaningful to the patient ("My Region").
class LocationMemories extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  TextColumn get name => text()();
  TextColumn get region => text().nullable()();
  TextColumn get state => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get memoryId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Daily mystery-memory unlock state.
class DailyUnlocks extends Table {
  TextColumn get patientId => text()();
  TextColumn get forDate => text()();
  IntColumn get completions => integer().withDefault(const Constant(0))();
  TextColumn get memoryId => text().nullable()();
  BoolColumn get unlocked => boolean().withDefault(const Constant(false))();
  DateTimeColumn get unlockedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {patientId, forDate};
}

/// Cognitive screening check-ups filled after sign-up (by the family).
class CognitiveAssessments extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  IntColumn get score => integer()();
  IntColumn get maxScore => integer()();
  TextColumn get answersJson => text()();
  TextColumn get statusKey => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Users,
    PatientProfiles,
    CaregiverLinks,
    EmergencyContacts,
    Activities,
    DailyActivities,
    ActivityAttempts,
    Memories,
    Gardens,
    GardenElements,
    Reminders,
    Notifications,
    SosIncidents,
    SosContactAttempts,
    SyncQueueItems,
    UserPreferences,
    AdaptiveProfiles,
    LocationMemories,
    DailyUnlocks,
    CognitiveAssessments,
    DailyNotes,
    CaregiverSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  /// Opens the platform-appropriate persistent database
  /// (sqlite3 on native, WebAssembly + IndexedDB on web).
  static Future<AppDatabase> open() async =>
      AppDatabase(await exec.openDatabaseExecutor());

  static Future<AppDatabase> connectForTesting() async =>
      AppDatabase(await exec.openTestExecutor());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      try {
        await customStatement('PRAGMA foreign_keys = ON');
      } catch (_) {
        // WebDatabase (IndexedDB) doesn't expose PRAGMAs.
      }
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(users, users.username);
        await m.addColumn(users, users.passwordHash);
      }
      if (from < 3) {
        await m.createTable(cognitiveAssessments);
      }
      if (from < 4) {
        await m.addColumn(patientProfiles, patientProfiles.dateOfBirth);
        await m.createTable(dailyNotes);
        await m.createTable(caregiverSettings);
      }
    },
  );

  /// Wipes all data (used by debugging/reset only).
  Future<void> clearAll() => transaction(() async {
    await delete(dailyUnlocks).go();
    await delete(locationMemories).go();
    await delete(adaptiveProfiles).go();
    await delete(userPreferences).go();
    await delete(syncQueueItems).go();
    await delete(sosContactAttempts).go();
    await delete(sosIncidents).go();
    await delete(notifications).go();
    await delete(reminders).go();
    await delete(gardenElements).go();
    await delete(gardens).go();
    await delete(memories).go();
    await delete(activityAttempts).go();
    await delete(dailyActivities).go();
    await delete(activities).go();
    await delete(emergencyContacts).go();
    await delete(cognitiveAssessments).go();
    await delete(caregiverLinks).go();
    await delete(caregiverSettings).go();
    await delete(dailyNotes).go();
    await delete(patientProfiles).go();
    await delete(users).go();
  });
}

/// Convenience helper the app-layer uses to key local dates.
String localDateKey([DateTime? dt]) => LocalDates.key(dt ?? DateTime.now());
