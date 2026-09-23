import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/l10n_keys.dart';
import '../../../core/navigation/care_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/caregiver_theme.dart';
import '../../../core/utilities/caregiver_locale_store.dart';
import '../../../shared/widgets/language_picker.dart';
import '../providers/care_providers.dart';
import '../widgets/care_ui.dart';

/// Caregiver profile — the linked patient, pairing, SOS and device settings.
class CareProfileScreen extends ConsumerStatefulWidget {
  const CareProfileScreen({super.key});

  @override
  ConsumerState<CareProfileScreen> createState() => _CareProfileScreenState();
}

class _CareProfileScreenState extends ConsumerState<CareProfileScreen> {
  final _code = TextEditingController();
  bool _linking = false;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final subject = ref.watch(careSubjectProvider).value;
    final preview = ref.watch(carePreviewProvider);
    final remote = ref.watch(careRemoteProvider);
    final contacts = ref.watch(careContactsProvider).value ?? const [];

    return CareBackground(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          Text(
            l10n.t(L10nKeys.careProfileTitle),
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          if (subject != null)
            CareCard(
              child: Row(
                children: [
                  CareAvatar(
                    emoji: subject.patient.avatarEmoji,
                    size: 64,
                    showPreviewTag: preview,
                    badge: l10n.t(L10nKeys.carePreviewBadge),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject.patient.name,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontFamily: CareTheme.serif,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (subject.patient.age != null)
                          Text(
                            l10n.t(L10nKeys.careProfileAge, {
                              'age': '${subject.patient.age}',
                            }),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: CareColors.textSoft,
                            ),
                          ),
                        if (subject.patient.region != null &&
                            subject.patient.region!.isNotEmpty)
                          Text(
                            subject.patient.region!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: CareColors.textSoft,
                            ),
                          ),
                        const SizedBox(height: 4),
                        Text(
                          preview
                              ? l10n.t(L10nKeys.careProfileNotLinked)
                              : l10n.t(L10nKeys.careProfileLinked),
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: preview
                                ? CareColors.accent
                                : CareColors.success,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          _LanguageCard(),
          const SizedBox(height: AppSpacing.lg),
          if (preview) ...[
            CareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.t(L10nKeys.careProfilePairingTitle),
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.t(L10nKeys.careProfilePairingHint),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: CareColors.textSoft,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    controller: _code,
                    textCapitalization: TextCapitalization.characters,
                    maxLength: 6,
                    onSubmitted: (_) => _link(),
                    decoration: InputDecoration(
                      hintText: l10n.t(L10nKeys.careProfilePairingPlaceholder),
                      prefixIcon: const Icon(
                        Icons.qr_code_2_rounded,
                        color: CareColors.textFaint,
                      ),
                      filled: true,
                      fillColor: CareColors.card,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(color: CareColors.line),
                      ),
                      counterText: '',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _linking ? null : _link,
                      icon: _linking
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.link_rounded),
                      label: Text(l10n.t(L10nKeys.careProfileLinkButton)),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            CareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.t(L10nKeys.careProfileSosTitle),
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.t(L10nKeys.careProfileContactsCount, {
                      'count': '${contacts.length}',
                    }),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: CareColors.textSoft,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          openCareSection(context, CareRoutes.emergency),
                      icon: const Icon(
                        Icons.emergency_rounded,
                        color: CareColors.rose,
                      ),
                      label: Text(l10n.t(L10nKeys.careEmergencyTitle)),
                    ),
                  ),
                ],
              ),
            ),
            if (remote.analytics?.patientName != null) ...[
              const SizedBox(height: AppSpacing.lg),
              _infoRow(
                Icons.cloud_sync_outlined,
                l10n.t(L10nKeys.careProfileSyncNote),
                theme,
              ),
            ],
          ],
          const SizedBox(height: AppSpacing.lg),
          CareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.t(L10nKeys.careProfileSettings),
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                _navRow(
                  Icons.tune_rounded,
                  l10n.t(L10nKeys.careSettingsTitle),
                  CareRoutes.settings,
                ),
                _navRow(
                  Icons.people_outline_rounded,
                  l10n.t(L10nKeys.careContacts),
                  CareRoutes.profile,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Center(
            child: OutlinedButton.icon(
              onPressed: _confirmLock,
              icon: const Icon(Icons.lock_outline_rounded),
              label: Text(l10n.t(L10nKeys.careProfileLogout)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, ThemeData theme) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Icon(icon, size: 18, color: CareColors.textFaint),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: CareColors.textSoft,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _navRow(IconData icon, String label, String route) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: CareColors.secondarySoft,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(icon, color: CareColors.primary, size: 24),
    ),
    title: Text(label, style: Theme.of(context).textTheme.titleMedium),
    trailing: const Icon(
      Icons.chevron_right_rounded,
      color: CareColors.textFaint,
    ),
    onTap: () => openCareSection(context, route),
  );

  Future<void> _link() async {
    final code = _code.text.trim();
    if (code.isEmpty || _linking) return;
    setState(() => _linking = true);
    final l10n = AppLocalizations.of(context);
    final ok = await ref.read(careRemoteProvider.notifier).linkPatient(code);
    final session = ref.read(serverSessionProvider);
    final linked = ok && (session?.hasPatient ?? false);
    setState(() => _linking = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          linked
              ? l10n.t(L10nKeys.careProfilePairingSuccess)
              : l10n.t(L10nKeys.careProfilePairingError),
        ),
      ),
    );
    if (linked) {
      ref.invalidate(careSubjectProvider);
      ref.invalidate(careProgressProvider);
      _code.clear();
    }
  }

  Future<void> _confirmLock() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.t(L10nKeys.careProfileLogout)),
        content: Text(l10n.t(L10nKeys.careProfileLogoutConfirm)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.t(L10nKeys.careCancel)),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.t(L10nKeys.careProfileLogout)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(sessionProvider.notifier).lock();
    }
  }
}

/// Caregiver display language switcher (persisted on this device).
class _LanguageCard extends StatelessWidget {
  const _LanguageCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return CareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.translate_rounded,
                color: CareColors.primary,
                size: 20,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                l10n.t(L10nKeys.profileLanguage),
                style: theme.textTheme.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Consumer(
            builder: (context, ref, _) {
              final language = ref.watch(appLanguageProvider);
              return LanguagePicker(
                selected: language,
                onChanged: (code) async {
                  ref.read(appLanguageProvider.notifier).set(code);
                  await CaregiverLocaleStore.save(code);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
