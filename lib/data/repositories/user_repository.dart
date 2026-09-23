import 'package:drift/drift.dart';

import '../local/app_database.dart';
import '../models/enums.dart';

/// Users, patient profiles, caregiver links and preferences.
class UserRepository {
  UserRepository(this._db);

  final AppDatabase _db;

  // ── Users ─────────────────────────────────────────────────────────────
  Future<User> createUser({
    required String id,
    required String name,
    required UserRole role,
    String? username,
    String? passwordHash,
  }) async {
    final row = UsersCompanion.insert(
      id: id,
      name: name,
      role: role.name,
      username: Value(username),
      passwordHash: Value(passwordHash),
      createdAt: DateTime.now(),
    );
    await _db.into(_db.users).insert(row, mode: InsertMode.insertOrReplace);
    return (_db.select(_db.users)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<User?> findByUsername(String username) async {
    final needle = username.toLowerCase();
    for (final u in await allUsers()) {
      if (u.username != null && u.username!.toLowerCase() == needle) {
        return u;
      }
    }
    return null;
  }

  Future<String?> passwordHashFor(String id) async {
    final rows = await (_db.select(
      _db.users,
    )..where((t) => t.id.equals(id))).get();
    return rows.isEmpty ? null : rows.first.passwordHash;
  }

  Future<User> setCredentials(
    String id, {
    required String username,
    required String passwordHash,
  }) async {
    await (_db.update(_db.users)..where((t) => t.id.equals(id))).write(
      UsersCompanion(
        username: Value(username),
        passwordHash: Value(passwordHash),
      ),
    );
    return (_db.select(_db.users)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<User?> userById(String id) async {
    final rows = await (_db.select(
      _db.users,
    )..where((t) => t.id.equals(id))).get();
    return rows.isEmpty ? null : rows.first;
  }

  /// The most recently created user that has no credentials yet (created by
  /// a pre-auth flow or an earlier app version).
  Future<User?> latestUnsignedUser() async {
    final rows =
        await (_db.select(_db.users)
              ..where((t) => t.username.isNull())
              ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
            .get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<List<User>> allUsers() => _db.select(_db.users).get();

  /// The active "main" user — for this single-device product we treat the
  /// most recently created patient (or caregiver) as active.
  Future<User?> latestUser() async {
    final rows = await (_db.select(
      _db.users,
    )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
    return rows.isEmpty ? null : rows.first;
  }

  bool isCaregiver(User user) => user.role == UserRole.caregiver.name;

  // ── Patient profiles ──────────────────────────────────────────────────
  Future<PatientProfile> upsertPatientProfile({
    required String id,
    required String userId,
    required String displayName,
    String? region,
    String language = 'hi',
    String voiceLanguage = 'hi-IN',
    String avatarEmoji = '🌸',
  }) async {
    final row = PatientProfilesCompanion.insert(
      id: id,
      userId: userId,
      displayName: displayName,
      region: Value(region),
      language: Value(language),
      voiceLanguage: Value(voiceLanguage),
      avatarEmoji: Value(avatarEmoji),
      createdAt: DateTime.now(),
    );
    await _db
        .into(_db.patientProfiles)
        .insert(row, mode: InsertMode.insertOrReplace);
    return (_db.select(
      _db.patientProfiles,
    )..where((t) => t.id.equals(id))).getSingle();
  }

  Future<PatientProfile?> patientProfile(String id) async {
    final rows = await (_db.select(
      _db.patientProfiles,
    )..where((t) => t.id.equals(id))).get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<PatientProfile?> patientForUser(String userId) async {
    final rows = await (_db.select(
      _db.patientProfiles,
    )..where((t) => t.userId.equals(userId))).get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<void> updatePatientProfile(
    String id, {
    String? displayName,
    String? region,
    String? language,
    String? voiceLanguage,
    String? avatarEmoji,
  }) async {
    await (_db.update(
      _db.patientProfiles,
    )..where((t) => t.id.equals(id))).write(
      PatientProfilesCompanion(
        displayName: displayName == null
            ? const Value.absent()
            : Value(displayName),
        region: region == null ? const Value.absent() : Value(region),
        language: language == null ? const Value.absent() : Value(language),
        voiceLanguage: voiceLanguage == null
            ? const Value.absent()
            : Value(voiceLanguage),
        avatarEmoji: avatarEmoji == null
            ? const Value.absent()
            : Value(avatarEmoji),
      ),
    );
  }

  // ── Caregiver links ───────────────────────────────────────────────────
  Future<CaregiverLink> linkCaregiver({
    required String id,
    required String caregiverId,
    required String patientId,
    String? relationship,
  }) async {
    final row = CaregiverLinksCompanion.insert(
      id: id,
      caregiverId: caregiverId,
      patientId: patientId,
      relationship: Value(relationship),
      createdAt: DateTime.now(),
    );
    await _db
        .into(_db.caregiverLinks)
        .insert(row, mode: InsertMode.insertOrReplace);
    return (_db.select(
      _db.caregiverLinks,
    )..where((t) => t.id.equals(id))).getSingle();
  }

  Future<List<CaregiverLink>> linksForPatient(String patientId) async =>
      (_db.select(
        _db.caregiverLinks,
      )..where((t) => t.patientId.equals(patientId))).get();

  Future<List<CaregiverLink>> linksForCaregiver(String caregiverId) async =>
      (_db.select(
        _db.caregiverLinks,
      )..where((t) => t.caregiverId.equals(caregiverId))).get();

  // ── Preferences ───────────────────────────────────────────────────────
  Future<UserPreference> upsertPreferences({
    required String patientId,
    String language = 'hi',
    String voiceLanguage = 'hi-IN',
    bool speechPrompts = true,
    bool reducedMotion = false,
    bool largeText = true,
    bool soundEffects = true,
    bool demoMode = false,
    int escalationMinutes = 3,
    DateTime? onboardedAt,
  }) async {
    final row = UserPreferencesCompanion.insert(
      patientId: patientId,
      language: Value(language),
      voiceLanguage: Value(voiceLanguage),
      speechPrompts: Value(speechPrompts),
      reducedMotion: Value(reducedMotion),
      largeText: Value(largeText),
      soundEffects: Value(soundEffects),
      demoMode: Value(demoMode),
      escalationMinutes: Value(escalationMinutes),
      onboardedAt: Value(onboardedAt ?? DateTime.now()),
    );
    await _db
        .into(_db.userPreferences)
        .insert(row, mode: InsertMode.insertOrReplace);
    return (_db.select(
      _db.userPreferences,
    )..where((t) => t.patientId.equals(patientId))).getSingle();
  }

  Future<UserPreference?> preferences(String patientId) async {
    final rows = await (_db.select(
      _db.userPreferences,
    )..where((t) => t.patientId.equals(patientId))).get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<void> updatePreferences(
    String patientId, {
    String? language,
    String? voiceLanguage,
    bool? speechPrompts,
    bool? reducedMotion,
    bool? largeText,
    bool? soundEffects,
    bool? demoMode,
    int? escalationMinutes,
  }) async {
    await (_db.update(
      _db.userPreferences,
    )..where((t) => t.patientId.equals(patientId))).write(
      UserPreferencesCompanion(
        language: language == null ? const Value.absent() : Value(language),
        voiceLanguage: voiceLanguage == null
            ? const Value.absent()
            : Value(voiceLanguage),
        speechPrompts: speechPrompts == null
            ? const Value.absent()
            : Value(speechPrompts),
        reducedMotion: reducedMotion == null
            ? const Value.absent()
            : Value(reducedMotion),
        largeText: largeText == null ? const Value.absent() : Value(largeText),
        soundEffects: soundEffects == null
            ? const Value.absent()
            : Value(soundEffects),
        demoMode: demoMode == null ? const Value.absent() : Value(demoMode),
        escalationMinutes: escalationMinutes == null
            ? const Value.absent()
            : Value(escalationMinutes),
      ),
    );
  }

  /// Whether an onboarding has been completed for any user.
  Future<bool> hasOnboardedUser() async {
    final prefs = await _db.select(_db.userPreferences).get();
    return prefs.isNotEmpty;
  }
}
