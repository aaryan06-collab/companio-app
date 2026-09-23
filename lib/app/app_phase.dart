import '../data/local/app_database.dart';

/// Which top-level experience the app currently shows.
enum AppPhase { loading, choosingRole, onboardPatient, patient, caregiver }

/// A signed-in session. Single-device product: only the latest user is
/// active. For a patient the profile + preferences complete the session.
class AppSession {
  const AppSession({
    required this.user,
    this.patient,
    this.prefs,
    this.links = const [],
  });

  final User user;
  final PatientProfile? patient;
  final UserPreference? prefs;
  final List<CaregiverLink> links;

  bool get isCaregiver => user.role == 'caregiver';

  String get languageCode => prefs?.language ?? 'hi';
}
