import '../core/utilities/device_id.dart';
import '../data/local/app_database.dart';
import '../data/models/enums.dart';
import '../data/remote/local_user_api.dart';
import '../data/remote/remote_api.dart';
import '../data/remote/server_client.dart';
import '../data/remote/server_session.dart';
import '../data/repositories/activity_repository.dart';
import '../data/repositories/assessment_repository.dart';
import '../data/repositories/care_notes_repository.dart';
import '../data/repositories/care_settings_repository.dart';
import '../data/repositories/contact_repository.dart';
import '../data/repositories/garden_repository.dart';
import '../data/repositories/memory_repository.dart';
import '../data/repositories/reminder_repository.dart';
import '../data/repositories/sos_repository.dart';
import '../data/repositories/user_repository.dart';
import '../data/sync/connectivity_monitor.dart';
import '../data/sync/sync_repository.dart';
import '../data/sync/sync_service.dart';
import '../domain/services/adaptive_engine.dart';
import '../domain/services/daily_experience_service.dart';
import '../domain/services/garden_service.dart';
import '../domain/services/memory_record_service.dart';
import '../domain/services/mystery_memory_service.dart';
import '../domain/services/reminder_scheduler.dart';
import '../domain/services/sos_escalator.dart';
import '../domain/services/voice_service.dart';

/// Root access point for all collaborators.
///
/// Constructed once in `main`, the module wires the database, repositories,
/// services and the sync engine. Tests can construct a lighter module with
/// an in-memory database.
class AppDependencies {
  AppDependencies({
    AppDatabase? database,
    String? deviceId,
    Future<bool> Function()? reachability,
  }) : _providedDatabase = database,
       _deviceId = deviceId,
       _reachability = reachability;

  /// The production singleton used by the app shell.
  static final AppDependencies instance = AppDependencies();

  // Created during init(); fields below are lazy-computed once.
  AppDatabase? _database;
  final AppDatabase? _providedDatabase;
  final String? _deviceId;
  final Future<bool> Function()? _reachability;

  bool _initialized = false;
  bool _reachabilityInitialized = false;
  Future<bool> Function()? _reachabilityFn;
  ConnectivityMonitor? _monitor;
  String? _deviceIdCache;

  // repositories
  late UserRepository userRepository;
  late MemoryRepository memoryRepository;
  late GardenRepository gardenRepository;
  late ActivityRepository activityRepository;
  late AssessmentRepository assessmentRepository;
  late ContactRepository contactRepository;
  late SosRepository sosRepository;
  late ReminderRepository reminderRepository;
  late SyncRepository syncRepository;
  late CareNotesRepository careNotesRepository;
  late CareSettingsRepository careSettingsRepository;

  // server integration
  late ServerSessionStore serverSessions;
  late ServerClient serverClient;
  RemoteApi? remoteApi;

  // services
  late AdaptiveService adaptiveService;
  late GardenService gardenService;
  late MysteryMemoryService mysteryMemoryService;
  late SosEscalator sosEscalator;
  late VoiceService voiceService;
  late DailyExperienceService dailyExperienceService;
  late ReminderScheduler reminderScheduler;
  late MemoryRecordService memoryRecordService;
  late SyncService syncService;

  AppDatabase get database => _database!;

  bool get initialized => _initialized;

  bool get ownReachability => _reachabilityInitialized;

  /// Stable per-installation device identifier (cached after first load).
  Future<String> loadDeviceId() async =>
      _deviceIdCache ??= _deviceId ?? await DeviceId.load();

  Future<Future<bool> Function()?> _reachabilitySource() async {
    if (_reachabilityInitialized) return _reachabilityFn;
    _reachabilityInitialized = true;
    if (_reachability != null) {
      _reachabilityFn = _reachability;
      return _reachability;
    }
    final monitor = ConnectivityMonitor();
    await monitor.check();
    _reachabilityFn = monitor.check;
    return _reachabilityFn;
  }

  /// Builds the graph. Idempotent.
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    _database ??= _providedDatabase ?? await AppDatabase.open();
    final database = _database!;

    final deviceId = await loadDeviceId();

    userRepository = UserRepository(database);
    memoryRepository = MemoryRepository(database);
    gardenRepository = GardenRepository(database);
    activityRepository = ActivityRepository(database);
    assessmentRepository = AssessmentRepository(database);
    contactRepository = ContactRepository(database);
    sosRepository = SosRepository(database);
    reminderRepository = ReminderRepository(database);
    syncRepository = SyncRepository(database);

    careNotesRepository = CareNotesRepository(database);
    careSettingsRepository = CareSettingsRepository(database);

    adaptiveService = AdaptiveService(database);
    gardenService = GardenService(gardenRepository, memoryRepository);
    mysteryMemoryService = MysteryMemoryService(
      database,
      activityRepository,
      memoryRepository,
    );
    sosEscalator = SosEscalator(sosRepository, contactRepository);
    voiceService = VoiceService();

    final applier = RemoteApplier(
      memoryRepo: memoryRepository,
      contactRepo: contactRepository,
      reminderRepo: reminderRepository,
      syncRepo: syncRepository,
      sosRepo: sosRepository,
    );

    final reachability = await _reachabilitySource();
    final monitor = _monitor ??= ConnectivityMonitor();

    serverSessions = ServerSessionStore();
    serverClient = ServerClient();
    if (serverClient.enabled && remoteApi == null) {
      remoteApi = RemoteApi(
        server: serverClient,
        sessions: serverSessions,
        deviceId: deviceId,
      );
    }

    final api =
        remoteApi ??
        LocalUserApi(deviceId: deviceId, reachability: reachability);

    syncService = SyncService(
      api: api,
      queue: syncRepository,
      applier: applier,
      monitor: monitor,
      mediaUploader: _uploadMemoryPhoto,
      onMemoryUploaded: (id, url) => memoryRepository.updateMediaUrl(id, url),
    );

    dailyExperienceService = DailyExperienceService(
      activityRepo: activityRepository,
      gardenRepo: gardenRepository,
      gardenService: gardenService,
      mysteryService: mysteryMemoryService,
      syncRepo: syncRepository,
    );

    reminderScheduler = ReminderScheduler(reminderRepository);
    memoryRecordService = MemoryRecordService(gardenService, memoryRepository);
    memoryRecordService.onMemoryAdded = (memory) async {
      await syncService.enqueueAndCommit(
        entityType: 'memory',
        entityId: memory.id,
        operation: SyncOperation.create,
        payload: {
          'patientId': memory.patientId,
          'kind': memory.kind,
          'title': memory.title,
          'caption': memory.caption,
          'relation': memory.relation,
          'mediaPath': memory.mediaPath,
          'mediaUrl': memory.mediaUrl,
          'category': memory.category,
          'placeName': memory.placeName,
          'createdBy': memory.createdBy,
        },
      );
    };
  }

  /// Seeds the activity catalog for [language] if the table is empty.
  Future<void> seedCatalogIfNeeded(String language) async {
    final count = await (_database!.select(_database!.activities)).get();
    if (count.isEmpty) {
      await activityRepository.seedCatalog(language);
    }
  }

  /// Uploads a picked photo memory to the server and returns its absolute
  /// media URL. Null when offline or when no server session exists, which
  /// keeps the photo queued for the next sync retry.
  Future<String?> _uploadMemoryPhoto(String localPath) async {
    final session = await serverSessions.load();
    if (session == null) return null;
    final deviceId = await loadDeviceId();
    final path = await serverClient.uploadMemoryPhoto(
      localPath: localPath,
      token: session.token,
      deviceId: deviceId,
    );
    if (path == null || path.isEmpty) return null;
    return serverClient.resolveMediaUrl(path);
  }
}
