import '../local/app_database.dart';

/// Settings repository.
///
/// Reads/writes a lightweight pref structure. The caregiver settings are
/// stored in a single `CaregiverSettings` row; patients continue to use
/// `UserPreferences` as before.
class CareSettingsRepository {
  CareSettingsRepository(this._db);

  final AppDatabase _db;

  static const _singletonId = 'caregiver';

  Future<CaregiverSetting> load() async {
    final row = await (_db.select(
      _db.caregiverSettings,
    )..where((t) => t.id.equals(_singletonId))).getSingleOrNull();
    return row ??
        const CaregiverSetting(
          id: _singletonId,
          fontStep: 1,
          highContrast: false,
          reminders: true,
          weeklyReports: true,
          sosAlerts: true,
        );
  }

  Future<void> save(CaregiverSetting settings) async {
    final row = settings.toCompanion(false);
    await _db.into(_db.caregiverSettings).insertOnConflictUpdate(row);
  }

  Stream<CaregiverSetting> watch() async* {
    yield await load();
    final query = _db.select(_db.caregiverSettings)
      ..where((t) => t.id.equals(_singletonId));
    yield* query.watchSingleOrNull().map(
      (row) =>
          row ??
          const CaregiverSetting(
            id: _singletonId,
            fontStep: 1,
            highContrast: false,
            reminders: true,
            weeklyReports: true,
            sosAlerts: true,
          ),
    );
  }
}
