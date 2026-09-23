import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../core/localization/languages.dart';
import '../core/utilities/caregiver_locale_store.dart';
import '../core/utilities/local_dates.dart';
import '../core/utilities/password_hasher.dart';
import '../data/local/app_database.dart';
import '../data/models/enums.dart';
import '../data/remote/server_client.dart';
import '../data/remote/server_session.dart';
import '../domain/services/daily_experience_service.dart';
import '../domain/services/mystery_memory_service.dart';
import '../domain/services/sos_escalator.dart';
import '../data/repositories/user_repository.dart';
import 'app_phase.dart';
import 'dependencies.dart';

/// Thrown when sign-up/login credentials can't be accepted.
class AuthFailure implements Exception {
  AuthFailure(this.messageKey);

  /// Localization key describing the failure (shown to the user).
  final String messageKey;

  @override
  String toString() => messageKey;
}

/// Root dependency container (set up in `main`).
final depsProvider = Provider<AppDependencies>(
  (ref) => AppDependencies.instance,
);

/// Single source of truth for the active session.
class SessionNotifier extends AsyncNotifier<AppSession?> {
  AppDependencies get _deps => ref.read(depsProvider);

  UserRepository get _users => _deps.userRepository;

  @override
  Future<AppSession?> build() async {
    await _deps.init();
    _deps.reminderScheduler.start();
    _deps.syncService.startAutoSync();
    _deps.syncService.onPullComplete = () async {
      ref.invalidate(remindersProvider);
      ref.invalidate(homeDataProvider);
      ref.invalidate(gardenProvider);
      ref.invalidate(pendingSyncCountProvider);
    };
    _deps.voiceService.init(language: 'hi-IN', enabled: false);
    final user = await _users.latestUser();
    if (user == null) return null;
    unawaited(_warmServerSession());
    if (user.role == UserRole.caregiver.name) {
      final saved = await CaregiverLocaleStore.load();
      if (saved != null) {
        ref.read(appLanguageProvider.notifier).set(saved);
      }
      return AppSession(
        user: user,
        links: await _users.linksForCaregiver(user.id),
      );
    }
    final patient = await _users.patientForUser(user.id);
    if (patient == null) return null;
    final prefs = await _users.preferences(patient.id);
    await _seedFor(patient);

    // The patient's saved preference is the source of truth.
    if (prefs != null) {
      ref.read(appLanguageProvider.notifier).set(prefs.language);
    }

    final session = AppSession(user: user, patient: patient, prefs: prefs);
    _startListening(session);
    return session;
  }

  Future<void> _seedFor(PatientProfile patient) async {
    await _deps.seedCatalogIfNeeded(patient.language);
    await _deps.activityRepository.ensureTodayAssigned(
      patient.id,
      patient.region,
    );
  }

  /// Restores the persisted server session on startup (best-effort).
  Future<void> _warmServerSession() async {
    try {
      await ref.read(serverSessionProvider.notifier).recover();
    } catch (_) {}
  }

  void _startListening(AppSession session) {
    final deps = _deps;
    if (session.prefs?.speechPrompts ?? false) {
      deps.voiceService.init(
        language: session.prefs?.voiceLanguage ?? 'hi-IN',
        enabled: true,
      );
    }
  }

  /// Sign-up (patient): creates the account + patient profile, preferences,
  /// garden and family contacts in a single offline flow.
  Future<AppSession> signUpPatient({
    required String username,
    required String password,
    required String name,
    required String region,
    required String language,
    required String voiceLanguage,
    List<(String, String, String)>? contacts,
  }) async {
    if (await _users.findByUsername(username) != null) {
      throw AuthFailure('authUsernameTaken');
    }
    final user = await _createAccount(
      role: UserRole.patient,
      username: username,
      password: password,
      name: name,
    );
    final profileId = 'patient.${user.id}';
    final patient = await _users.upsertPatientProfile(
      id: profileId,
      userId: user.id,
      displayName: name,
      region: region,
      language: language,
      voiceLanguage: voiceLanguage,
    );
    final prefs = await _users.upsertPreferences(
      patientId: patient.id,
      language: language,
      voiceLanguage: voiceLanguage,
      speechPrompts: true,
      largeText: true,
    );
    await _deps.gardenRepository.ensureGarden(patient.id);
    if (contacts != null) {
      var priority = EscalationPriority.primary;
      for (final (cName, phone, relation) in contacts) {
        if (cName.trim().isEmpty) continue;
        await _deps.contactRepository.addContact(
          id: 'contact.${const Uuid().v4()}',
          patientId: patient.id,
          name: cName.trim(),
          phone: phone.trim(),
          relation: relation.trim().isEmpty ? null : relation.trim(),
          priority: priority,
        );
        priority = switch (priority) {
          EscalationPriority.primary => EscalationPriority.secondary,
          EscalationPriority.secondary => EscalationPriority.tertiary,
          EscalationPriority.tertiary => EscalationPriority.tertiary,
        };
      }
    }
    await _seedFor(patient);
    ref.read(appLanguageProvider.notifier).set(language);
    await Future<void>.delayed(Duration.zero);
    _deps.voiceService.init(
      language: voiceLanguage,
      enabled: prefs.speechPrompts,
    );
    final session = AppSession(user: user, patient: patient, prefs: prefs);
    state = AsyncData(session);
    _startListening(session);
    unawaited(
      _registerWithServer(
        username: username,
        password: password,
        role: UserRole.patient.name,
        name: name,
      ),
    );
    return session;
  }

  /// Sign-up for a caregiver account (no patient profile of their own).
  Future<AppSession> signUpCaregiver({
    required String username,
    required String password,
    required String name,
    String? pairingCode,
  }) async {
    if (await _users.findByUsername(username) != null) {
      throw AuthFailure('authUsernameTaken');
    }
    final user = await _createAccount(
      role: UserRole.caregiver,
      username: username,
      password: password,
      name: name,
    );
    final session = AppSession(
      user: user,
      links: await _users.linksForCaregiver(user.id),
    );
    if (pairingCode != null && pairingCode.trim().isNotEmpty) {
      await _registerWithServer(
        username: username,
        password: password,
        role: UserRole.caregiver.name,
        name: name,
      );
      await ref.read(careRemoteProvider.notifier).linkPatient(pairingCode);
      state = AsyncData(session);
      return session; // link is best-effort; on failure the dashboard retry sheet still works
    }
    state = AsyncData(session);
    unawaited(
      _registerWithServer(
        username: username,
        password: password,
        role: UserRole.caregiver.name,
        name: name,
      ),
    );
    return session;
  }

  /// Unlocks the stored profile after checking credentials.
  Future<void> unlock({
    required String username,
    required String password,
  }) async {
    final user = await _users.findByUsername(username);
    if (user == null) {
      throw AuthFailure('authBadCredentials');
    }
    final stored = user.passwordHash;
    if (stored == null || !PasswordHasher.verify(password, stored)) {
      throw AuthFailure('authBadCredentials');
    }
    unawaited(
      _registerWithServer(
        username: username,
        password: password,
        role: user.role,
        name: user.name,
      ),
    );
    refresh();
  }

  /// Locks the device back to the login screen.
  Future<void> lock() async {
    _deps.reminderScheduler.stop();
    _deps.syncService.stop();
    await _deps.serverSessions.clear();
    ref.invalidate(serverSessionProvider);
    state = const AsyncData(null);
  }

  /// Best-effort: mirror the local account on the FastAPI server and register
  /// this device. Never blocks or fails the offline-first local flow.
  Future<void> _registerWithServer({
    required String username,
    required String password,
    required String role,
    required String name,
  }) async {
    final notifier = ref.read(serverSessionProvider.notifier);
    await notifier.registerAccount(
      username: username,
      password: password,
      role: role,
      name: name,
    );
    await notifier.registerDevice();
  }

  Future<User> _createAccount({
    required UserRole role,
    required String username,
    required String password,
    required String name,
  }) async {
    final legacy = await _users.latestUnsignedUser();
    if (legacy != null) {
      return _users.setCredentials(
        legacy.id,
        username: username.trim(),
        passwordHash: PasswordHasher.hash(password),
      );
    }
    return _users.createUser(
      id: role == UserRole.patient
          ? 'user.${const Uuid().v4()}'
          : 'caregiver.${const Uuid().v4()}',
      name: name,
      role: role,
      username: username.trim(),
      passwordHash: PasswordHasher.hash(password),
    );
  }

  void refresh() => ref.invalidateSelf();
}

final sessionProvider = AsyncNotifierProvider<SessionNotifier, AppSession?>(
  SessionNotifier.new,
);

/// Server (FastAPI) auth state — the JWT that lets this device read/write
/// the family's data on the server. Null when the backend is not configured
/// (COMPANIO_API_URL unset) or the account is not registered yet.
class ServerSessionNotifier extends Notifier<ServerSession?> {
  AppDependencies get _deps => ref.read(depsProvider);

  @override
  ServerSession? build() {
    final deps = _deps;
    Future.microtask(() async {
      final stored = await deps.serverSessions.load();
      if (ref.mounted && stored != null) state = stored;
    });
    return null;
  }

  /// Restores the persisted session and refreshes it from /auth/me, then
  /// re-registers this device (so caregiver links stay mapped).
  Future<ServerSession?> recover() async {
    final client = _deps.serverClient;
    if (!client.enabled) {
      state = null;
      return null;
    }
    final stored = await _deps.serverSessions.load();
    if (stored == null) {
      state = null;
      return null;
    }
    state = stored;
    try {
      final me = await client.me(stored.token);
      if (me != null) {
        final updated = me.toSession();
        await _deps.serverSessions.save(updated);
        state = updated;
        await registerDevice(patientId: updated.linkedPatientId);
      }
    } catch (_) {}
    return state;
  }

  /// Re-fetches the persisted session from /auth/me (without re-registering
  /// this device). Used to pick up late updates such as the linked caregiver
  /// name appearing shortly after a caregiver pairs with the patient.
  Future<ServerSession?> refresh() async {
    final client = _deps.serverClient;
    if (!client.enabled) return state;
    final stored = await _deps.serverSessions.load();
    if (stored == null) return state;
    try {
      final me = await client.me(stored.token);
      if (me != null) {
        final updated = me.toSession();
        await _deps.serverSessions.save(updated);
        state = updated;
      }
    } catch (_) {}
    return state;
  }

  /// Creates (or logs into) the server account matching the local one. Safe
  /// to call repeatedly: a 409 simply falls through to login.
  Future<ServerSession?> registerAccount({
    required String username,
    required String password,
    required String role,
    required String name,
  }) async {
    final client = _deps.serverClient;
    if (!client.enabled) {
      state = null;
      return null;
    }
    ServerAuthResult? auth;
    try {
      auth = await client.signup(
        username: username,
        password: password,
        name: name,
        role: role,
      );
    } on ServerException {
      // Username already exists server-side — it is our own account, or an
      // unrecoverable conflict; fall through to login.
    } on ServerUnreachableException {
      return null;
    }
    if (auth == null) {
      try {
        auth = await client.login(username: username, password: password);
      } on ServerException {
        return null;
      } on ServerUnreachableException {
        return null;
      }
    }
    if (auth == null) {
      state = null;
      return null;
    }
    final session = auth.toSession();
    await _deps.serverSessions.save(session);
    state = session;
    return session;
  }

  /// Tells the server this device belongs to the current account (and, for a
  /// caregiver, which patient it manages after linking).
  Future<ServerSession?> registerDevice({String? patientId}) async {
    final client = _deps.serverClient;
    final session = state;
    if (!client.enabled || session == null) return session;
    if (session.isPatient) patientId ??= session.accountId;
    try {
      final deviceId = await _deps.loadDeviceId();
      final result = await client.registerDevice(
        deviceId: deviceId,
        patientId: patientId,
        token: session.token,
      );
      if (result != null) {
        final updated = result.toSession();
        await _deps.serverSessions.save(updated);
        state = updated;
        return updated;
      }
    } catch (_) {}
    return state;
  }
}

final serverSessionProvider =
    NotifierProvider<ServerSessionNotifier, ServerSession?>(
      ServerSessionNotifier.new,
    );

/// Pairing code the patient shows so a caregiver can link to them.
final pairingCodeProvider = Provider<String?>(
  (ref) => ref.watch(serverSessionProvider)?.pairingCode,
);

/// Whether a credential-based account has been created on this device
/// (drives the Sign-up vs. Login gate).
final hasAccountProvider = FutureProvider<bool>((ref) async {
  final deps = ref.watch(depsProvider);
  await deps.init();
  for (final u in await deps.userRepository.allUsers()) {
    if (u.username != null && u.username!.trim().isNotEmpty) return true;
  }
  return false;
});

/// Resolved app language (from profile preference, 'hi' by default).
class AppLanguageNotifier extends Notifier<String> {
  @override
  String build() => 'hi';

  void set(String code) {
    final c = code.toLowerCase();
    final base = c.contains('-') ? c.substring(0, c.indexOf('-')) : c;
    final normalized = isSupportedLanguage(base) ? base : 'hi';
    if (state != normalized) state = normalized;
  }
}

final appLanguageProvider = NotifierProvider<AppLanguageNotifier, String>(
  AppLanguageNotifier.new,
);

/// Patient text-size preference (S/M/L). Scales the whole app typography for
/// comfortable reading.
enum PatientTextScale { small, medium, large }

extension PatientTextScaleX on PatientTextScale {
  double get factor => switch (this) {
    PatientTextScale.small => 0.9,
    PatientTextScale.medium => 1.0,
    PatientTextScale.large => 1.25,
  };
}

class PatientTextScaleNotifier extends Notifier<PatientTextScale> {
  @override
  PatientTextScale build() => PatientTextScale.medium;

  void set(PatientTextScale value) => state = value;
}

final patientTextScaleProvider =
    NotifierProvider<PatientTextScaleNotifier, PatientTextScale>(
      PatientTextScaleNotifier.new,
    );

/// High-contrast reading mode (near-black text, pure-white cards).
class HighContrastNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void set(bool value) => state = value;

  void toggle() => state = !state;
}

final highContrastProvider = NotifierProvider<HighContrastNotifier, bool>(
  HighContrastNotifier.new,
);

/// Patient id of the active session (null while loading / caregiver).
final patientIdProvider = Provider<String?>(
  (ref) => ref.watch(sessionProvider).value?.patient?.id,
);

/// Patient profile of the active session.
final patientProfileProvider = Provider<PatientProfile?>(
  (ref) => ref.watch(sessionProvider).value?.patient,
);

/// Home screen model.
class HomeData {
  const HomeData({
    required this.profile,
    this.garden,
    this.elements = const [],
    this.points = 0,
    this.todaysCompletions = 0,
    this.today,
    this.todayActivity,
    this.mystery,
    this.memoryOfDay,
    this.contacts = const [],
  });

  final PatientProfile profile;
  final Garden? garden;
  final List<GardenElement> elements;
  final int points;
  final int todaysCompletions;
  final DailyActivity? today;
  final Activity? todayActivity;
  final MysteryLockState? mystery;
  final Memory? memoryOfDay;
  final List<EmergencyContact> contacts;

  bool get hasContact => contacts.isNotEmpty;
  int get livePlants =>
      elements.where((e) => e.stage != PlantStage.mature).length;
  int get maturePlants =>
      elements.where((e) => e.stage == PlantStage.mature).length;
}

final homeDataProvider = FutureProvider<HomeData>((ref) async {
  final deps = ref.watch(depsProvider);
  final patient = ref.watch(patientProfileProvider);
  if (patient == null) {
    throw StateError('homeDataProvider requires an active patient');
  }
  final garden = await deps.gardenRepository.gardenFor(patient.id);
  final elements = garden == null
      ? <GardenElement>[]
      : await deps.gardenRepository.elementsFor(garden.id);
  final points = garden?.points ?? 0;
  final today = await deps.activityRepository.todayActivity(patient.id);
  final todayActivity = today == null
      ? null
      : await deps.activityRepository.activityById(today.activityId);
  final completions = await deps.activityRepository.completionsOn(
    patient.id,
    LocalDates.todayKey(),
  );
  final mystery = await deps.mysteryMemoryService.stateFor(patient.id);
  Memory? memoryOfDay;
  if (mystery.unlocked && mystery.memoryId != null) {
    memoryOfDay = await deps.memoryRepository.memoryById(mystery.memoryId!);
  }
  final contacts = await deps.contactRepository.contactsFor(patient.id);
  return HomeData(
    profile: patient,
    garden: garden,
    elements: elements,
    points: points,
    todaysCompletions: completions,
    today: today,
    todayActivity: todayActivity,
    mystery: mystery,
    memoryOfDay: memoryOfDay,
    contacts: contacts,
  );
});

class GardenView {
  const GardenView({required this.garden, required this.elements});

  final Garden garden;
  final List<GardenElement> elements;
}

final gardenProvider = FutureProvider<GardenView>((ref) async {
  final deps = ref.watch(depsProvider);
  final patientId = ref.watch(patientIdProvider);
  if (patientId == null) {
    throw StateError('gardenProvider requires an active patient');
  }
  final garden = await deps.gardenRepository.gardenFor(patientId);
  if (garden == null) {
    throw StateError('garden missing for patient $patientId');
  }
  final elements = await deps.gardenRepository.elementsFor(garden.id);
  return GardenView(garden: garden, elements: elements);
});

final activitiesProvider = FutureProvider<List<Activity>>((ref) async {
  final deps = ref.watch(depsProvider);
  return deps.activityRepository.allActivities();
});

class TodayActivity {
  const TodayActivity({required this.activity, required this.daily});

  final Activity activity;
  final DailyActivity daily;
}

final todayActivityProvider = FutureProvider<TodayActivity?>((ref) async {
  final deps = ref.watch(depsProvider);
  final patientId = ref.watch(patientIdProvider);
  if (patientId == null) return null;
  final daily = await deps.activityRepository.todayActivity(patientId);
  if (daily == null) return null;
  final activity = await deps.activityRepository.activityById(daily.activityId);
  if (activity == null) return null;
  return TodayActivity(activity: activity, daily: daily);
});

/// Latest cognitive screening check-up for a patient (null when never run).
final latestAssessmentProvider =
    FutureProvider.family<CognitiveAssessment?, String>(
      (ref, patientId) =>
          ref.watch(depsProvider).assessmentRepository.latest(patientId),
    );

/// True while the patient has not completed the screening yet — used as a
/// first-run gate right after sign-up.
final screeningPendingProvider = FutureProvider<bool>((ref) async {
  final patientId = ref.watch(patientIdProvider);
  if (patientId == null) return false;
  final latest = await ref.watch(latestAssessmentProvider(patientId).future);
  return latest == null;
});

final memoriesProvider = FutureProvider<List<Memory>>((ref) async {
  final deps = ref.watch(depsProvider);
  final patientId = ref.watch(patientIdProvider);
  if (patientId == null) return const [];
  return deps.memoryRepository.memoriesFor(patientId);
});

final contactsProvider = FutureProvider<List<EmergencyContact>>((ref) async {
  final deps = ref.watch(depsProvider);
  final patientId = ref.watch(patientIdProvider);
  if (patientId == null) return const [];
  return deps.contactRepository.contactsFor(patientId);
});

final remindersProvider = FutureProvider<List<Reminder>>((ref) async {
  final deps = ref.read(depsProvider);
  final patientId = ref.read(patientIdProvider);
  if (patientId == null) return const [];
  return deps.reminderRepository.remindersFor(patientId);
});

final pendingSyncCountProvider = FutureProvider<int>((ref) async {
  final deps = ref.watch(depsProvider);
  return deps.syncService.snapshot.pending;
});

/// The most recently created patient — the caregiver's main view subject.
final carePatientProvider = FutureProvider<PatientProfile?>((ref) async {
  final deps = ref.read(depsProvider);
  final users = await deps.userRepository.allUsers();
  PatientProfile? latest;
  for (final u in users) {
    if (u.role != UserRole.patient.name) continue;
    final p = await deps.userRepository.patientForUser(u.id);
    if (p == null) continue;
    if (latest == null || p.createdAt.isAfter(latest.createdAt)) {
      latest = p;
    }
  }
  return latest;
});

class CareData {
  const CareData({
    required this.patient,
    this.garden,
    this.elements = const [],
    this.completedThisWeek = 0,
    this.completedToday = 0,
    this.memories = 0,
    this.contacts = const [],
    this.activeSos,
    this.reminders = const [],
  });

  final PatientProfile patient;
  final Garden? garden;
  final List<GardenElement> elements;
  final int completedThisWeek;
  final int completedToday;
  final int memories;
  final List<EmergencyContact> contacts;
  final SosIncident? activeSos;
  final List<Reminder> reminders;
}

final careDataProvider = FutureProvider<CareData>((ref) async {
  final deps = ref.read(depsProvider);
  final patient = await ref.read(carePatientProvider.future);
  if (patient == null) {
    throw StateError('careDataProvider requires a patient');
  }
  final garden = await deps.gardenRepository.gardenFor(patient.id);
  final elements = garden == null
      ? <GardenElement>[]
      : await deps.gardenRepository.elementsFor(garden.id);
  var completedThisWeek = 0;
  for (var i = 0; i < 7; i++) {
    final day = DateTime.now().subtract(Duration(days: i));
    completedThisWeek += await deps.activityRepository.completionsOn(
      patient.id,
      '${day.year}-${_two(day.month)}-${_two(day.day)}',
    );
  }
  final completedToday = await deps.activityRepository.completionsOn(
    patient.id,
    LocalDates.todayKey(),
  );
  final memories = (await deps.memoryRepository.memoriesFor(patient.id)).length;
  final contacts = await deps.contactRepository.contactsFor(patient.id);
  final activeSos = await deps.sosRepository.activeIncident(patient.id);
  final reminders = await deps.reminderRepository.remindersFor(patient.id);
  return CareData(
    patient: patient,
    garden: garden,
    elements: elements,
    completedThisWeek: completedThisWeek,
    completedToday: completedToday,
    memories: memories,
    contacts: contacts,
    activeSos: activeSos,
    reminders: reminders,
  );
});

String _two(int v) => v.toString().padLeft(2, '0');

/// Live data pulled from the FastAPI server for the caregiver dashboard:
/// active SOS alerts + the linked patient's AI trend analytics.
class CareRemoteData {
  const CareRemoteData({
    this.alerts = const [],
    this.analytics,
    this.loading = true,
    this.linked = false,
  });

  final List<ServerAlert> alerts;
  final ServerAnalytics? analytics;
  final bool loading;

  /// Whether the caregiver account is linked to (and managing) a patient.
  final bool linked;

  bool get hasAlerts => alerts.isNotEmpty;

  ServerAlert? get newestAlert => alerts.isEmpty ? null : alerts.first;
}

/// Polls the server for the caregiver's live view (every 15s while enabled).
class CareRemoteNotifier extends Notifier<CareRemoteData> {
  Timer? _timer;

  AppDependencies get _deps => ref.read(depsProvider);

  @override
  CareRemoteData build() {
    final deps = _deps;
    final session = ref.watch(serverSessionProvider);
    if (!deps.serverClient.enabled) return const CareRemoteData(linked: false);

    _timer ??= Timer.periodic(const Duration(seconds: 15), (_) {
      _refreshQuietly();
    });
    Future.microtask(() => _refreshQuietly());
    ref.onDispose(() => _timer?.cancel());

    return CareRemoteData(
      linked: session?.isCaregiver == true && session?.hasPatient == true,
    );
  }

  Future<void> _refreshQuietly() async {
    try {
      await refresh();
    } catch (_) {}
  }

  Future<void> refresh() async {
    final session = ref.read(serverSessionProvider);
    if (!_deps.serverClient.enabled || session == null) {
      state = const CareRemoteData(linked: false);
      return;
    }
    if (session.isPatient) {
      state = const CareRemoteData(linked: false);
      return;
    }
    final alerts = await _deps.serverClient.alerts(session.token);
    ServerAnalytics? analytics;
    final linked = session.hasPatient;
    if (linked) {
      analytics = await _deps.serverClient.analyticsFor(
        session.linkedPatientId!,
        token: session.token,
      );
    }
    state = CareRemoteData(
      alerts: alerts,
      analytics: analytics,
      loading: false,
      linked: linked,
    );
  }

  /// Acknowledges an alert on the server (and locally on this device).
  Future<void> acknowledge(ServerAlert alert) async {
    final session = ref.read(serverSessionProvider);
    if (session == null) return;
    await _deps.serverClient.ackSos(alert.id, token: session.token);
    await _deps.sosEscalator.acknowledge(alert.patientId);
    await refresh();
  }

  /// Links this caregiver to a patient using their 6-character pairing code.
  Future<bool> linkPatient(String pairingCode) async {
    final client = _deps.serverClient;
    final session = ref.read(serverSessionProvider);
    if (!client.enabled || session == null) return false;
    try {
      final result = await client.link(
        pairingCode: pairingCode.trim(),
        token: session.token,
      );
      if (result == null) return false;
      final updated = result.toSession();
      await _deps.serverSessions.save(updated);
      ref.read(serverSessionProvider.notifier).state = updated;
      await ref
          .read(serverSessionProvider.notifier)
          .registerDevice(patientId: updated.linkedPatientId);
      await refresh();
      return true;
    } catch (_) {
      return false;
    }
  }
}

final careRemoteProvider = NotifierProvider<CareRemoteNotifier, CareRemoteData>(
  CareRemoteNotifier.new,
);

/// SOS escalation view-state controller.
class SosController extends Notifier<SosViewState> {
  @override
  SosViewState build() {
    final patientId = ref.read(patientIdProvider);
    if (patientId != null) {
      Future.microtask(() async {
        final next = await ref
            .read(depsProvider)
            .sosEscalator
            .resume(patientId);
        if (ref.mounted) state = next;
      });
    }
    return const SosViewState(incident: null, attempts: []);
  }

  SosEscalator get _escalator => ref.read(depsProvider).sosEscalator;

  String? get _patientId => ref.read(patientIdProvider);

  /// Mirrors the incident state to the server so the caregiver dashboard
  /// shows the alert live and can acknowledge it from anywhere.
  Future<void> _pushSos({
    required String incidentId,
    required DateTime startedAt,
    required SosStatus status,
  }) async {
    await ref
        .read(depsProvider)
        .syncService
        .enqueueAndCommit(
          entityType: 'sos',
          entityId: incidentId,
          operation: status == SosStatus.active
              ? SyncOperation.create
              : SyncOperation.update,
          payload: {
            'incidentId': incidentId,
            'status': status.name,
            'startedAt': startedAt.toIso8601String(),
          },
        );
  }

  Future<SosViewState> launch() async {
    final patientId = _patientId;
    if (patientId == null) return state;
    final next = await _escalator.launch(patientId);
    state = next;
    final incident = next.incident;
    if (incident != null && incident.status != SosStatus.acknowledged) {
      await _pushSos(
        incidentId: incident.id,
        startedAt: incident.startedAt,
        status: incident.status,
      );
    }
    return next;
  }

  Future<SosViewState> reportAttempt({
    required String contactId,
    required AttemptMethod method,
    required bool delivered,
  }) async {
    final patientId = _patientId;
    if (patientId == null) return state;
    final next = await _escalator.reportAttempt(
      patientId: patientId,
      contactId: contactId,
      method: method,
      delivered: delivered,
    );
    state = next;
    return next;
  }

  Future<SosViewState> escalate() async {
    final patientId = _patientId;
    if (patientId == null) return state;
    final next = await _escalator.escalate(patientId);
    state = next;
    return next;
  }

  Future<SosViewState> acknowledge() async {
    final patientId = _patientId;
    if (patientId == null) return state;
    final next = await _escalator.acknowledge(patientId);
    state = next;
    return next;
  }

  Future<SosViewState> cancel() async {
    final patientId = _patientId;
    if (patientId == null) return state;
    final active = await ref
        .read(depsProvider)
        .sosRepository
        .activeIncident(patientId);
    final next = await _escalator.cancel(patientId);
    state = next;
    if (active != null) {
      await _pushSos(
        incidentId: active.id,
        startedAt: active.startedAt,
        status: SosStatus.cancelled,
      );
    }
    return next;
  }

  Future<SosViewState> resolve() async {
    final patientId = _patientId;
    if (patientId == null) return state;
    final next = await _escalator.resolve(patientId);
    state = next;
    final incident = next.incident;
    if (incident != null) {
      await _pushSos(
        incidentId: incident.id,
        startedAt: incident.startedAt,
        status: incident.status,
      );
    }
    return next;
  }
}

final sosControllerProvider = NotifierProvider<SosController, SosViewState>(
  SosController.new,
);

/// Complete an activity through the full experience pipeline.
Future<ActivityCompletionResult> completeActivityFlow(
  WidgetRef ref, {
  required String activityId,
  required int correctCount,
  required int totalCount,
  required int hintCount,
  Difficulty difficulty = Difficulty.gentle,
  bool completed = true,
  Map<String, Object?>? result,
  GardenSection section = GardenSection.garden,
}) async {
  final deps = ref.read(depsProvider);
  final patientId = ref.read(patientIdProvider);
  if (patientId == null) {
    throw StateError('completeActivityFlow requires an active patient');
  }
  final outcome = await deps.dailyExperienceService.completeActivity(
    patientId: patientId,
    activityId: activityId,
    correctCount: correctCount,
    totalCount: totalCount,
    hintCount: hintCount,
    difficulty: difficulty,
    completed: completed,
    result: result,
    section: section,
  );
  await deps.adaptiveService.recordOutcome(
    patientId: patientId,
    category: activityId.split('.').last,
    correctCount: correctCount,
    totalCount: totalCount,
    hintCount: hintCount,
  );
  ref.invalidate(homeDataProvider);
  ref.invalidate(gardenProvider);
  ref.invalidate(todayActivityProvider);
  ref.invalidate(memoriesProvider);
  ref.invalidate(pendingSyncCountProvider);
  return outcome;
}
