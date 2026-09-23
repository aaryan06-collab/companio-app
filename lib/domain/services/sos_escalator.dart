import '../../data/local/app_database.dart';
import '../../data/models/enums.dart';
import '../../data/repositories/contact_repository.dart';
import '../../data/repositories/sos_repository.dart';

/// View-model for the SOS screen.
class SosViewState {
  const SosViewState({
    required this.incident,
    required this.attempts,
    this.currentContact,
    this.hasContacts = true,
  });

  final SosIncident? incident;
  final List<SosContactAttempt> attempts;
  final EmergencyContact? currentContact;
  final bool hasContacts;

  bool get isActive =>
      incident != null &&
      (incident!.status == SosStatus.active ||
          incident!.status == SosStatus.acknowledged);

  bool get isAcknowledged => incident?.status == SosStatus.acknowledged;

  String get statusKey => isAcknowledged
      ? 'sosAcknowledged'
      : (incident == null ? 'sosExplain' : 'sosActiveBody');
}

/// Drives the SOS escalation flow.
///
/// Flow (configurable via preferences):
///   patient activates → contact primary → timeout → contact next →
///   ... → no one responds → keep retrying with clear status feedback.
///
/// The service decides the sequence and records outcomes. Actual phone/SMS
/// delivery is performed by the UI layer (url_launcher), which reports the
/// result back so the app never claims delivery it did not achieve.
class SosEscalator {
  SosEscalator(this._sosRepo, this._contactRepo);

  final SosRepository _sosRepo;
  final ContactRepository _contactRepo;

  Future<SosViewState> launch(String patientId) async {
    final contacts = await _contactRepo.escalationOrder(patientId);
    return startExisting(patientId, contacts: contacts);
  }

  Future<SosViewState> resume(String patientId) async {
    final contacts = await _contactRepo.escalationOrder(patientId);
    return startExisting(patientId, contacts: contacts, createIfNeeded: false);
  }

  Future<SosViewState> startExisting(
    String patientId, {
    required List<EmergencyContact> contacts,
    bool createIfNeeded = true,
  }) async {
    if (contacts.isEmpty) {
      return const SosViewState(
        incident: null,
        attempts: [],
        hasContacts: false,
      );
    }

    var incident = await _sosRepo.activeIncident(patientId);
    if (incident == null) {
      if (!createIfNeeded) {
        return SosViewState(
          incident: incident,
          attempts: const [],
          currentContact: contacts.first,
          hasContacts: true,
        );
      }
      incident = await _sosRepo.startIncident(
        id: 'sos.$patientId.${DateTime.now().millisecondsSinceEpoch}',
        patientId: patientId,
      );
    }

    final attempts = await _sosRepo.attemptsFor(incident.id);
    final current = stepContact(incident, contacts);
    return SosViewState(
      incident: incident,
      attempts: attempts,
      currentContact: current,
      hasContacts: true,
    );
  }

  /// Which contact the incident is currently waiting on.
  EmergencyContact? stepContact(
    SosIncident incident,
    List<EmergencyContact> contacts,
  ) {
    final step = incident.escalationStep;
    if (step >= contacts.length) return contacts.isEmpty ? null : contacts.last;
    return contacts[step];
  }

  /// Records that an attempt to reach [contactId] was made.
  Future<SosViewState> reportAttempt({
    required String patientId,
    required String contactId,
    required AttemptMethod method,
    required bool delivered,
    String? notes,
  }) async {
    final incident = await _sosRepo.activeIncident(patientId);
    final contacts = await _contactRepo.escalationOrder(patientId);
    if (incident == null || contacts.isEmpty) {
      await launch(patientId);
      return startExisting(
        patientId,
        contacts: await _contactRepo.escalationOrder(patientId),
      );
    }

    await _sosRepo.recordAttempt(
      id: 'attempt.${incident.id}.$contactId.${DateTime.now().millisecondsSinceEpoch}',
      incidentId: incident.id,
      contactId: contactId,
      attemptOrder: incident.escalationStep,
      method: method,
      status: delivered
          ? ContactAttemptStatus.attempted
          : ContactAttemptStatus.failed,
    );

    if (!delivered) {
      // Poor connectivity — never fake it; retry the same contact next tick.
      await _sosRepo.updateIncident(
        incident.id,
        lastAttemptAt: DateTime.now(),
        notes: notes ?? 'not delivered, will retry',
        currentContactId: contactId,
      );
    }
    final updated = await _sosRepo.incidentById(incident.id);
    if (updated == null) {
      return const SosViewState(
        incident: null,
        attempts: [],
        hasContacts: true,
      );
    }
    return SosViewState(
      incident: updated,
      attempts: await _sosRepo.attemptsFor(updated.id),
      currentContact: stepContact(updated, contacts),
      hasContacts: true,
    );
  }

  /// Escalates to the next contact (called after the configured timeout).
  Future<SosViewState> escalate(String patientId) async {
    final incident = await _sosRepo.activeIncident(patientId);
    final contacts = await _contactRepo.escalationOrder(patientId);
    if (incident == null) return startExisting(patientId, contacts: contacts);

    final nextStep = incident.escalationStep + 1;
    final hasNext = nextStep < contacts.length;
    final updated = await _sosRepo.updateIncident(
      incident.id,
      escalationStep: hasNext ? nextStep : incident.escalationStep,
      currentContactId: hasNext ? contacts[nextStep].id : null,
      lastAttemptAt: DateTime.now(),
    );
    return SosViewState(
      incident: updated,
      attempts: await _sosRepo.attemptsFor(updated.id),
      currentContact: stepContact(updated, contacts),
      hasContacts: true,
    );
  }

  /// A caregiver/family member acknowledges the alert.
  Future<SosViewState> acknowledge(
    String patientId, {
    String? contactId,
  }) async {
    final incident = await _sosRepo.activeIncident(patientId);
    final contacts = await _contactRepo.escalationOrder(patientId);
    if (incident == null) return startExisting(patientId, contacts: contacts);

    final updated = await _sosRepo.updateIncident(
      incident.id,
      status: SosStatus.acknowledged,
      acknowledgedAt: DateTime.now(),
      currentContactId: contactId ?? incident.currentContactId,
    );
    return SosViewState(
      incident: updated,
      attempts: await _sosRepo.attemptsFor(updated.id),
      currentContact: stepContact(updated, contacts),
      hasContacts: true,
    );
  }

  Future<SosViewState> resolve(String patientId) async {
    final incident = await _sosRepo.activeIncident(patientId);
    final contacts = await _contactRepo.escalationOrder(patientId);
    if (incident == null) return startExisting(patientId, contacts: contacts);
    final updated = await _sosRepo.updateIncident(
      incident.id,
      status: SosStatus.resolved,
      resolvedAt: DateTime.now(),
    );
    return SosViewState(
      incident: updated,
      attempts: const [],
      currentContact: null,
      hasContacts: true,
    );
  }

  Future<SosViewState> cancel(String patientId) async {
    final incident = await _sosRepo.activeIncident(patientId);
    final contacts = await _contactRepo.escalationOrder(patientId);
    if (incident != null) {
      await _sosRepo.updateIncident(
        incident.id,
        status: SosStatus.cancelled,
        resolvedAt: DateTime.now(),
      );
    }
    return SosViewState(
      incident: null,
      attempts: const [],
      hasContacts: contacts.isNotEmpty,
    );
  }
}
