import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/providers.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/l10n_keys.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/caregiver_theme.dart';
import '../../../data/remote/server_client.dart';
import '../model/care_models.dart';
import '../providers/care_providers.dart';
import '../widgets/care_ui.dart';

/// Caregiver Emergency & SOS hub — live alerts, family quick contact and
/// the escalation ladder (patient's end escalates 2 → 3 automatically).
class CareEmergencyScreen extends ConsumerWidget {
  const CareEmergencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final remote = ref.watch(careRemoteProvider);
    final async = ref.watch(careContactsProvider);
    final contacts = async.value ?? const <CareContact>[];

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
            l10n.t(L10nKeys.careEmergencyTitle),
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: 4),
          Text(
            l10n.t(L10nKeys.careEmergencySubtitle),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: CareColors.textSoft,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          if (remote.newestAlert != null)
            _LiveAlertCard(alert: remote.newestAlert!),

          _SectionCard(
            icon: Icons.group_outlined,
            title: l10n.t(L10nKeys.careCallFamily),
            body: _contactGrid(contacts, l10n, theme, context),
          ),

          const SizedBox(height: AppSpacing.lg),

          _SectionCard(
            icon: Icons.local_hospital_outlined,
            title: l10n.t(L10nKeys.careCallServices),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: CareColors.rose,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => _call('112'),
                  icon: const Icon(Icons.phone_in_talk_rounded),
                  label: Text(
                    l10n.t(L10nKeys.careCallServicesBody),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          _SectionCard(
            icon: Icons.vertical_align_top_rounded,
            title: l10n.t(L10nKeys.careEscalationLadder),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Column(
                children: [
                  _ladderStep(
                    context,
                    1,
                    l10n.t(L10nKeys.careStepCallPrimary),
                    '🌱',
                  ),
                  _ladderStep(
                    context,
                    2,
                    l10n.t(L10nKeys.careStepSmsPrimary),
                    '🌿',
                  ),
                  _ladderStep(
                    context,
                    3,
                    l10n.t(L10nKeys.careStepCallFamily),
                    '🌸',
                  ),
                ],
              ),
            ),
          ),

          if (remote.alerts.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            _SectionCard(
              icon: Icons.history_rounded,
              title: l10n.t(L10nKeys.careHistory),
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final a in remote.alerts)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.sm,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: a.status == 'resolved'
                                    ? CareColors.successSoft
                                    : CareColors.roseSoft,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(a.status == 'resolved' ? '✅' : '🆘'),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    a.patientName,
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  Text(
                                    a.startedAt,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: CareColors.textFaint,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CareTag(
                              label: a.status,
                              color: a.status == 'resolved'
                                  ? CareColors.successSoft
                                  : CareColors.roseSoft,
                              foreground: a.status == 'resolved'
                                  ? CareColors.success
                                  : CareColors.rose,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _contactGrid(
    List<CareContact> contacts,
    AppLocalizations l10n,
    ThemeData theme,
    BuildContext context,
  ) {
    if (contacts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Text(
              l10n.t(L10nKeys.careNoContactsTitle),
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              l10n.t(L10nKeys.careNoContactsBody),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: CareColors.textSoft,
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      children: [
        for (final c in contacts)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: CareColors.secondarySoft,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    c.name.characters.first,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: CareColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c.name, style: theme.textTheme.titleMedium),
                      if (c.phone != null && c.phone!.isNotEmpty)
                        Text(
                          c.phone!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: CareColors.textSoft,
                          ),
                        ),
                    ],
                  ),
                ),
                if (c.phone != null && c.phone!.isNotEmpty) ...[
                  IconButton.filledTonal(
                    tooltip: l10n.t(L10nKeys.careCallShort),
                    onPressed: () => _call(c.phone!),
                    icon: const Icon(
                      Icons.call_rounded,
                      color: CareColors.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton.filledTonal(
                    tooltip: l10n.t(L10nKeys.careSmsShort),
                    onPressed: () => _sms(c.phone!),
                    icon: const Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: CareColors.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }

  Widget _ladderStep(
    BuildContext context,
    int number,
    String label,
    String emoji,
  ) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
    child: Row(
      children: [
        CareNumberBadge(text: '$number', color: CareColors.leaf),
        const SizedBox(width: AppSpacing.md),
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.titleMedium),
        ),
      ],
    ),
  );

  Future<void> _call(String number) async {
    final uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _sms(String number) async {
    final uri = Uri(scheme: 'sms', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _LiveAlertCard extends ConsumerWidget {
  const _LiveAlertCard({required this.alert});

  final ServerAlert alert;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final live = alert.status != 'resolved';
    final minutes = _minutesSince(alert.startedAt);

    return CareCard(
      color: CareColors.roseSoft,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: CareColors.rose,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.emergency_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      live
                          ? l10n.t(L10nKeys.careEmergencyLive)
                          : l10n.t(L10nKeys.careAcknowledged),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontFamily: CareTheme.serif,
                      ),
                    ),
                    Text(
                      l10n.t(L10nKeys.careEmergencyLiveBody, {
                        'name': alert.patientName,
                        'time': l10n.t(L10nKeys.careMinAgo, {'n': '$minutes'}),
                      }),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: CareColors.textSoft,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (live) ...[
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: CareColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () =>
                    ref.read(careRemoteProvider.notifier).acknowledge(alert),
                icon: const Icon(Icons.verified_user_outlined),
                label: Text(
                  '${l10n.t(L10nKeys.careAcknowledge)} · ${alert.patientName}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Whole minutes since an ISO-8601 timestamp (for the live alert banner).
int _minutesSince(String iso) {
  final parsed = DateTime.tryParse(iso);
  if (parsed == null) return 0;
  return DateTime.now().difference(parsed).inMinutes.clamp(0, 1 << 31);
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: CareColors.primary, size: 22),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(title, style: theme.textTheme.headlineSmall),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          body,
        ],
      ),
    );
  }
}
