import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/l10n_keys.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/caregiver_theme.dart';
import '../providers/care_providers.dart';
import '../widgets/care_ui.dart';

/// Caregiver preferences: display scale, high contrast and notifications.
class CareSettingsScreen extends ConsumerWidget {
  const CareSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final settings = ref.watch(careSettingsProvider);

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
            l10n.t(L10nKeys.careSettingsTitle),
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          CareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle(l10n.t(L10nKeys.careSettingsDisplay), theme),
                CareSegmentRow(
                  title: l10n.t(L10nKeys.careSettingsFontSize),
                  subtitle: _fontDescription(settings.fontStep, l10n),
                  segments: [
                    l10n.t(L10nKeys.careSettingsFontSmall),
                    l10n.t(L10nKeys.careSettingsFontNormal),
                    l10n.t(L10nKeys.careSettingsFontLarge),
                  ],
                  index: settings.fontStep - 1,
                  onChanged: (i) => ref
                      .read(careSettingsProvider.notifier)
                      .set(settings.copyWith(fontStep: i + 1)),
                ),
                CareSwitchRow(
                  icon: Icons.contrast_rounded,
                  title: l10n.t(L10nKeys.careSettingsHighContrast),
                  subtitle: l10n.t(L10nKeys.careSettingsHighContrastBody),
                  value: settings.highContrast,
                  onChanged: (v) => ref
                      .read(careSettingsProvider.notifier)
                      .set(settings.copyWith(highContrast: v)),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          CareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle(
                  l10n.t(L10nKeys.careSettingsNotifications),
                  theme,
                ),
                CareSwitchRow(
                  icon: Icons.notifications_active_outlined,
                  title: l10n.t(L10nKeys.careSettingsReminders),
                  subtitle: l10n.t(L10nKeys.careSettingsRemindersBody),
                  value: settings.reminders,
                  onChanged: (v) => ref
                      .read(careSettingsProvider.notifier)
                      .set(settings.copyWith(reminders: v)),
                ),
                CareSwitchRow(
                  icon: Icons.receipt_long_outlined,
                  title: l10n.t(L10nKeys.careSettingsWeekly),
                  subtitle: l10n.t(L10nKeys.careSettingsWeeklyBody),
                  value: settings.weeklyReports,
                  onChanged: (v) => ref
                      .read(careSettingsProvider.notifier)
                      .set(settings.copyWith(weeklyReports: v)),
                ),
                CareSwitchRow(
                  icon: Icons.emergency_outlined,
                  title: l10n.t(L10nKeys.careSettingsSosAlerts),
                  subtitle: l10n.t(L10nKeys.careSettingsSosAlertsBody),
                  value: settings.sosAlerts,
                  iconColor: CareColors.rose,
                  onChanged: (v) => ref
                      .read(careSettingsProvider.notifier)
                      .set(settings.copyWith(sosAlerts: v)),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          CareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle(l10n.t(L10nKeys.careSettingsAbout), theme),
                Text(
                  l10n.t(L10nKeys.careSettingsAboutBody),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: CareColors.textSoft,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _fontDescription(int step, AppLocalizations l10n) => switch (step) {
    2 => '1.2× · ${l10n.t(L10nKeys.careSettingsFontLarge)}',
    3 => '1.4× · ${l10n.t(L10nKeys.careSettingsFontLarge)}',
    _ => '1.0× · ${l10n.t(L10nKeys.careSettingsFontNormal)}',
  };

  Widget _sectionTitle(String text, ThemeData theme) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
    child: Text(
      text,
      style: theme.textTheme.headlineSmall?.copyWith(color: CareColors.primary),
    ),
  );
}
