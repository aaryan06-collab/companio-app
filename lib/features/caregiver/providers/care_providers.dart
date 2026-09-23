import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../data/local/app_database.dart';
import '../../../data/models/enums.dart';
import '../model/care_models.dart';
import '../services/care_progress_service.dart';
import '../services/care_seed.dart';

/// Selected time range on the Progress screen.
class CareRangeNotifier extends Notifier<CareRange> {
  @override
  CareRange build() => CareRange.week;

  void select(CareRange value) => state = value;
}

final careRangeProvider = NotifierProvider<CareRangeNotifier, CareRange>(
  CareRangeNotifier.new,
);

/// Whether the current caregiver view is showing the offline preview
/// (no linked patient yet).
final carePreviewProvider = Provider<bool>((ref) {
  final remote = ref.watch(careRemoteProvider);
  return !remote.linked;
});

/// The patient the caregiver is currently attending to — either the linked
/// server patient or the clearly-labelled preview persona.
final careSubjectProvider = FutureProvider<CareSubject>((ref) async {
  final remote = ref.watch(careRemoteProvider);
  if (remote.linked) {
    final session = ref.read(serverSessionProvider);
    final local = await ref.read(carePatientProvider.future);
    final id = session?.linkedPatientId ?? remote.analytics?.patientId ?? '';
    final remoteName = remote.analytics?.patientName;
    final displayName = remoteName != null && remoteName.isNotEmpty
        ? remoteName
        : (local?.displayName ?? 'Your patient');
    return CareSubject(
      patient: CarePatient(
        id: id,
        name: displayName,
        region: local?.region,
        dateOfBirth: local?.dateOfBirth,
        avatarEmoji: local?.avatarEmoji ?? '🌸',
      ),
    );
  }
  return CareSubject.preview();
});

/// Aggregates progress for the selected range. Real linked patients use the
/// server detail endpoint (falling back to the classic analytics), while the
/// preview persona shows seeded demo values.
final careProgressProvider = FutureProvider.family<CareProgress, CareRange>(
    (ref, range) async {
  final deps = ref.read(depsProvider);
  final remote = ref.watch(careRemoteProvider);
  final session = ref.read(serverSessionProvider);

  if (!remote.linked) return CareSeed.forRange(range);

  final patientId = session?.linkedPatientId;
  if (patientId == null || session == null) {
    return const CareProgress.empty();
  }
  try {
    final detail = await deps.serverClient.analyticsDetail(
      patientId,
      range: range.apiValue,
      token: session.token,
    );
    if (detail != null) return CareProgressMapper.fromDetailJson(detail);
  } catch (_) {}

  final analytics = remote.analytics;
  if (analytics != null && analytics.patientId.isNotEmpty) {
    return CareProgressMapper.fromServerAnalytics(analytics);
  }
  return const CareProgress.empty();
});

/// Milestones surfaced on the Achievements screen (always celebratory).
final careAchievementsProvider = Provider<List<CareAchievement>>((ref) {
  final range = ref.watch(careRangeProvider);
  final progress = ref.watch(careProgressProvider(range));
  final value = progress.value;
  if (value == null) return const <CareAchievement>[];
  return CareProgressMapper.computeAchievements(value);
});

/// Caregiver display + notification settings, persisted locally.
class CareSettingsNotifier extends Notifier<CareSettingsModel> {
  @override
  CareSettingsModel build() {
    final deps = ref.read(depsProvider);
    Future.microtask(() async {
      final s = await deps.careSettingsRepository.load();
      if (ref.mounted) {
        state = CareSettingsModel(
          fontStep: s.fontStep,
          highContrast: s.highContrast,
          reminders: s.reminders,
          weeklyReports: s.weeklyReports,
          sosAlerts: s.sosAlerts,
        );
      }
    });
    return const CareSettingsModel();
  }

  Future<void> set(CareSettingsModel next) async {
    state = next;
    final deps = ref.read(depsProvider);
    await deps.careSettingsRepository.save(
      CaregiverSetting(
        id: 'caregiver',
        fontStep: next.fontStep,
        highContrast: next.highContrast,
        reminders: next.reminders,
        weeklyReports: next.weeklyReports,
        sosAlerts: next.sosAlerts,
      ),
    );
  }
}

final careSettingsProvider =
    NotifierProvider<CareSettingsNotifier, CareSettingsModel>(
  CareSettingsNotifier.new,
);

/// Daily observation notes for the current subject. Lives only on the
/// caregiver's device (never synced).
class CareNotesNotifier extends AsyncNotifier<List<CareDailyNote>> {
  @override
  Future<List<CareDailyNote>> build() async {
    final subject = await ref.watch(careSubjectProvider.future);
    final deps = ref.read(depsProvider);
    final rows = await deps.careNotesRepository.notesFor(subject.id);
    return rows
        .map((r) => CareDailyNote(
              id: r.id,
              patientId: r.patientId,
              kind: r.kind,
              body: r.body,
              createdAt: r.createdAt,
            ))
        .toList();
  }

  Future<void> add({required NoteKind kind, required String body}) async {
    final subject = await ref.read(careSubjectProvider.future);
    final deps = ref.read(depsProvider);
    await deps.careNotesRepository.add(
      patientId: subject.id,
      kind: kind,
      body: body,
    );
    ref.invalidateSelf();
  }

  Future<void> remove(String id) async {
    await ref.read(depsProvider).careNotesRepository.delete(id);
    ref.invalidateSelf();
  }
}

final careNotesProvider =
    AsyncNotifierProvider<CareNotesNotifier, List<CareDailyNote>>(
  CareNotesNotifier.new,
);

/// Memories for the current subject (patient's Memory Garden + caregiver
/// contributions). Reads the same offline-first `MemoryRepository`.
final careMemoriesProvider = FutureProvider<List<Memory>>((ref) async {
  final subject = await ref.watch(careSubjectProvider.future);
  final deps = ref.read(depsProvider);
  return deps.memoryRepository.memoriesFor(subject.id);
});

/// Emergency contacts for the current subject.
final careContactsProvider = FutureProvider<List<CareContact>>((ref) async {
  final subject = await ref.watch(careSubjectProvider.future);
  final deps = ref.read(depsProvider);
  final rows = await deps.contactRepository.contactsFor(subject.id);
  return rows.indexed.map((e) => CareContact(
        id: e.$2.id,
        name: e.$2.name,
        phone: e.$2.phone,
        relation: e.$2.relation,
        orderIndex: e.$1,
      )).toList();
});

/// The patient subject resolved by the caregiver shell.
class CareSubject {
  const CareSubject({required this.patient, this.preview = false});

  CareSubject.preview()
      : patient = CareSeed.patient,
        preview = true;

  final CarePatient patient;
  final bool preview;

  String get id => patient.id;
  String get name => patient.name;
}