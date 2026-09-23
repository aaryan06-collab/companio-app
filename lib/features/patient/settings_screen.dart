import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/localization/languages.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/local/app_database.dart';
import '../../data/models/enums.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_cards.dart';
import '../../shared/widgets/language_picker.dart';
import '../sos/sos_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(serverSessionProvider.notifier).refresh());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(patientProfileProvider);
    final pending = ref.watch(pendingSyncCountProvider).value ?? 0;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text(
              l10n.t('profileTitle'),
              style: Theme.of(context).textTheme.headlineLarge
                  ?.copyWith(color: AppColors.deepGreen),
            ),
            const SizedBox(height: AppSpacing.md),
            OfflineBanner(pending: pending),
            const SizedBox(height: AppSpacing.md),
            const _ComfortSection(),
            const SizedBox(height: AppSpacing.md),
            SectionCard(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.sageMist,
                    child: Text('🌸'),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile?.displayName ?? '',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        if (profile?.region != null)
                          Text(
                            '📍 ${profile!.region}',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.inkSoft),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const _AccountSection(),
            const SizedBox(height: AppSpacing.md),
            const _ServerSection(),
            const SizedBox(height: AppSpacing.md),
            _LanguageSection(profile?.language ?? 'hi'),
            const SizedBox(height: AppSpacing.md),
            const _ContactSection(),
            const SizedBox(height: AppSpacing.md),
            const _ReminderSection(),
            const SizedBox(height: AppSpacing.md),
            const _SosSection(),
            const SizedBox(height: AppSpacing.md),
            _SyncInfo(pending: pending),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

/// Comfort & reading: sound, text size (S/M/L) and high contrast — the
/// elderly-friendly accessibility controls from the design brief.
class _ComfortSection extends ConsumerStatefulWidget {
  const _ComfortSection();

  @override
  ConsumerState<_ComfortSection> createState() => _ComfortSectionState();
}

class _ComfortSectionState extends ConsumerState<_ComfortSection> {
  bool? _soundOverride;

  bool _soundOn(UserPreference? prefs) =>
      _soundOverride ?? prefs?.speechPrompts ?? true;

  Future<void> _setSound(bool value) async {
    setState(() => _soundOverride = value);
    final patientId = ref.read(patientIdProvider);
    final session = ref.read(sessionProvider).value;
    final prefs = session?.prefs;
    if (patientId == null) return;
    try {
      final deps = ref.read(depsProvider);
      await deps.userRepository.updatePreferences(
        patientId,
        language: prefs?.language ?? 'hi',
        voiceLanguage: prefs?.voiceLanguage ?? 'hi-IN',
        speechPrompts: value,
      );
      await deps.voiceService.init(
        language: prefs?.voiceLanguage ?? 'hi-IN',
        enabled: value,
      );
    } catch (_) {
      // Offline-first: a failing persist must not break the toggle.
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scale = ref.watch(patientTextScaleProvider);
    final highContrast = ref.watch(highContrastProvider);
    final prefs = ref.watch(sessionProvider).value?.prefs;
    final theme = Theme.of(context);

    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.t('settingsComfortTitle'),
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),

          // Sound toggle (voice prompts).
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Text('🔉', style: TextStyle(fontSize: 26)),
            title: Text(
              l10n.t('profileSoundEffects'),
              style: theme.textTheme.titleMedium,
            ),
            trailing: Switch(value: _soundOn(prefs), onChanged: _setSound),
          ),

          const SizedBox(height: AppSpacing.sm),

          // Text size S/M/L.
          Text(l10n.t('settingsTextSize'), style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              _ScaleButton(
                label: l10n.t('settingsTextSizeSmall'),
                hint: 'S',
                selected: scale == PatientTextScale.small,
                onTap: () => ref
                    .read(patientTextScaleProvider.notifier)
                    .set(PatientTextScale.small),
              ),
              const SizedBox(width: AppSpacing.sm),
              _ScaleButton(
                label: l10n.t('settingsTextSizeMedium'),
                hint: 'M',
                selected: scale == PatientTextScale.medium,
                onTap: () => ref
                    .read(patientTextScaleProvider.notifier)
                    .set(PatientTextScale.medium),
              ),
              const SizedBox(width: AppSpacing.sm),
              _ScaleButton(
                label: l10n.t('settingsTextSizeLarge'),
                hint: 'L',
                selected: scale == PatientTextScale.large,
                onTap: () => ref
                    .read(patientTextScaleProvider.notifier)
                    .set(PatientTextScale.large),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // High contrast.
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Text('◐', style: TextStyle(fontSize: 26)),
            title: Text(
              l10n.t('settingsHighContrast'),
              style: theme.textTheme.titleMedium,
            ),
            subtitle: Text(
              l10n.t('settingsHighContrastBody'),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.inkSoft,
              ),
            ),
            trailing: Switch(
              value: highContrast,
              onChanged: (v) => ref.read(highContrastProvider.notifier).set(v),
            ),
          ),

          const SizedBox(height: AppSpacing.sm),
          const Divider(color: AppColors.line),
          const SizedBox(height: AppSpacing.sm),

          // How to play reassurance.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('🌱', style: TextStyle(fontSize: 24)),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  l10n.t('settingsHowToPlayBody'),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.inkSoft,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScaleButton extends StatelessWidget {
  const _ScaleButton({
    required this.label,
    required this.hint,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String hint;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: selected ? AppColors.sageMist : AppColors.creamCard,
            borderRadius: BorderRadius.circular(AppRadii.md),
            border: Border.all(
              color: selected ? AppColors.deepGreen : AppColors.line,
              width: selected ? 2.5 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                hint,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: selected ? AppColors.deepGreen : AppColors.inkSoft,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppColors.inkSoft,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountSection extends ConsumerWidget {
  const _AccountSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final caregiverName = ref.watch(serverSessionProvider)?.linkedCaregiverName;
    final linked = caregiverName != null && caregiverName.trim().isNotEmpty;
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.t('caregiverTitle'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Icon(Icons.people_alt_outlined, color: AppColors.inkSoft),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  linked ? caregiverName : l10n.t('caregiverNotLinked'),
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(color: linked ? null : AppColors.inkSoft),
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.logout_rounded),
                label: Text(l10n.t('authSignOut')),
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: Text(l10n.t('authSignOut')),
                      content: Text(l10n.t('authSignOutConfirm')),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.of(dialogContext).pop(false),
                          child: Text(l10n.t('cancel')),
                        ),
                        FilledButton(
                          onPressed: () =>
                              Navigator.of(dialogContext).pop(true),
                          child: Text(l10n.t('authSignOut')),
                        ),
                      ],
                    ),
                  );
                  if (confirmed == true) {
                    await ref.read(sessionProvider.notifier).lock();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ServerSection extends ConsumerWidget {
  const _ServerSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (!ref.read(depsProvider).serverClient.enabled) {
      return const SizedBox.shrink();
    }
    final session = ref.watch(serverSessionProvider);
    final pairing = session?.pairingCode;
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🫶', style: TextStyle(fontSize: 24)),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  l10n.t('serverPairingTitle'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (pairing != null) ...[
            SelectableText(
              pairing,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.deepGreen,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.t('serverPairingBody'),
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: AppColors.inkSoft),
            ),
          ] else ...[
            Row(
              children: [
                Icon(
                  session != null
                      ? Icons.cloud_done_rounded
                      : Icons.cloud_off_rounded,
                  color: session != null
                      ? AppColors.success
                      : AppColors.inkSoft,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    session != null
                        ? l10n.t('serverLinked')
                        : l10n.t('serverUnlinked'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _LanguageSection extends ConsumerStatefulWidget {
  const _LanguageSection(this.current);

  final String current;

  @override
  ConsumerState<_LanguageSection> createState() => _LanguageSectionState();
}

class _LanguageSectionState extends ConsumerState<_LanguageSection> {
  late String _selected = widget.current;

  @override
  void didUpdateWidget(covariant _LanguageSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.current != oldWidget.current) _selected = widget.current;
  }

  bool _saving = false;

  Future<void> _select(String code) async {
    if (_saving) return;
    _saving = true;
    try {
      setState(() => _selected = code);
      final ref = this.ref;
      // Instant, non-flickering locale switch (drives the whole tree).
      ref.read(appLanguageProvider.notifier).set(code);
      final session = ref.read(sessionProvider).value;
      final patientId = session?.patient?.id;
      if (patientId == null) return;
      final deps = ref.read(depsProvider);
      final voice = voiceLocaleFor(code);
      // Preserve the user's speech preference instead of forcing it on.
      final speechPrompts = session?.prefs?.speechPrompts ?? true;
      // Re-seed the catalog in the new language before anything reads it,
      // then persist and restore TTS — no session refresh (avoids the splash
      // flash and the drop back to the Home tab).
      await deps.activityRepository.seedCatalog(code);
      await deps.userRepository.updatePreferences(
        patientId,
        language: code,
        voiceLanguage: voice,
        speechPrompts: speechPrompts,
      );
      await deps.voiceService.init(language: voice, enabled: speechPrompts);
      ref.invalidate(activitiesProvider);
      ref.invalidate(todayActivityProvider);
      ref.invalidate(homeDataProvider);
    } catch (_) {
      // Offline-first: a failing seed/persistence must not break switching.
    } finally {
      _saving = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.t('profileLanguage'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          LanguagePicker(selected: _selected, onChanged: _select),
        ],
      ),
    );
  }
}

class _ContactSection extends ConsumerWidget {
  const _ContactSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final contacts = ref.watch(contactsProvider);
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.t('profileContacts'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              IconButton(
                onPressed: () => _addContact(context, ref),
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
          if (contacts.value?.isEmpty ?? true)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Text(
                l10n.t('sosNoContactsBody'),
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: AppColors.inkSoft),
              ),
            ),
          for (final contact in contacts.value ?? <EmergencyContact>[])
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: AppColors.sageMist,
                child: Text(contact.name.isNotEmpty ? contact.name[0] : '👤'),
              ),
              title: Text(
                contact.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                '${contact.phone}${contact.relation != null ? ' · ${contact.relation}' : ''}',
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: AppColors.inkSoft),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline_rounded),
                onPressed: () async {
                  await ref
                      .read(depsProvider)
                      .contactRepository
                      .deleteContact(contact.id);
                  ref.invalidate(contactsProvider);
                  ref.invalidate(homeDataProvider);
                },
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _addContact(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final name = TextEditingController();
    final phone = TextEditingController();
    final relation = TextEditingController();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.creamCard,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.lg,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.t('careContactName'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: name,
              decoration: InputDecoration(
                hintText: l10n.t('careContactName'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadii.sm),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: l10n.t('careContactPhone'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadii.sm),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: relation,
              decoration: InputDecoration(
                hintText: l10n.t('careContactRelation'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadii.sm),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppPrimaryButton(
              label: l10n.t('save'),
              onPressed: () async {
                if (name.text.trim().isEmpty || phone.text.trim().isEmpty) {
                  return;
                }
                final patientId = ref.read(patientIdProvider);
                if (patientId == null) return;
                await ref
                    .read(depsProvider)
                    .contactRepository
                    .addContact(
                      id: 'contact.${DateTime.now().microsecondsSinceEpoch}',
                      patientId: patientId,
                      name: name.text.trim(),
                      phone: phone.text.trim(),
                      relation: relation.text.trim().isEmpty
                          ? null
                          : relation.text.trim(),
                      priority: EscalationPriority.tertiary,
                    );
                ref.invalidate(contactsProvider);
                ref.invalidate(homeDataProvider);
                if (sheetContext.mounted) {
                  Navigator.of(sheetContext).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
    name.dispose();
    phone.dispose();
    relation.dispose();
  }
}

class _ReminderSection extends ConsumerWidget {
  const _ReminderSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final reminders = ref.watch(remindersProvider);
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.t('profileReminders'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              IconButton(
                onPressed: () => _addReminder(context, ref),
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
          if (reminders.hasError)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Row(
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: AppColors.terracotta,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      l10n.t('errorGenericBody'),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => ref.invalidate(remindersProvider),
                    child: Text(l10n.t('retry')),
                  ),
                ],
              ),
            )
          else if (reminders.value?.isEmpty ?? true)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Text(
                l10n.t('remindersEmpty'),
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: AppColors.inkSoft),
              ),
            ),
          for (final reminder in reminders.value ?? const <Reminder>[])
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text(
                _reminderIcon(reminder.kind),
                style: const TextStyle(fontSize: 26),
              ),
              title: Text(
                reminder.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                _time(reminder.hour, reminder.minute),
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: AppColors.inkSoft),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(
                    value: reminder.enabled,
                    onChanged: (v) async {
                      await ref
                          .read(depsProvider)
                          .reminderRepository
                          .setEnabled(reminder.id, v);
                      ref.invalidate(remindersProvider);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    onPressed: () async {
                      await ref
                          .read(depsProvider)
                          .reminderRepository
                          .deleteReminder(reminder.id);
                      ref.invalidate(remindersProvider);
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _addReminder(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final title = TextEditingController(text: l10n.t('remindersMedicine'));
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 0),
    );
    if (time == null) return;
    if (!context.mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.creamCard,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.lg,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.t('remindersNew'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: title,
              decoration: InputDecoration(
                hintText: l10n.t('remindersTitleLabel'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadii.sm),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '🕘 ${_time(time.hour, time.minute)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            AppPrimaryButton(
              label: l10n.t('save'),
              onPressed: () async {
                final patientId = ref.read(patientIdProvider);
                if (patientId == null) return;
                await ref
                    .read(depsProvider)
                    .reminderRepository
                    .addReminder(
                      id: 'reminder.${DateTime.now().microsecondsSinceEpoch}',
                      patientId: patientId,
                      title: title.text.trim().isEmpty
                          ? l10n.t('remindersMedicine')
                          : title.text.trim(),
                      hour: time.hour,
                      minute: time.minute,
                    );
                ref.invalidate(remindersProvider);
                if (sheetContext.mounted) {
                  Navigator.of(sheetContext).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
    title.dispose();
  }

  String _time(int hour, int minute) {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String _reminderIcon(String kind) => switch (kind) {
    'medicine' => '💊',
    'appointment' => '📅',
    _ => '⏰',
  };
}

class _SosSection extends ConsumerWidget {
  const _SosSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => SosScreen(
            onAddContact: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.support_agent_rounded,
            color: AppColors.rose,
            size: 34,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              l10n.t('sosExplain'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.inkSoft),
        ],
      ),
    );
  }
}

class _SyncInfo extends StatelessWidget {
  const _SyncInfo({required this.pending});

  final int pending;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      child: Row(
        children: [
          Icon(
            pending > 0
                ? Icons.cloud_upload_outlined
                : Icons.cloud_done_rounded,
            color: pending > 0 ? AppColors.terracotta : AppColors.success,
            size: 30,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              pending > 0
                  ? l10n.t('syncSavingOfflineBody', {'count': '$pending'})
                  : l10n.t('syncSynced'),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
