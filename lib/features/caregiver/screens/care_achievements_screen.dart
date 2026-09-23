import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/l10n_keys.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/caregiver_theme.dart';
import '../model/care_models.dart';
import '../providers/care_providers.dart';
import '../widgets/care_ui.dart';

/// Milestones celebrating the subject's progress in the garden.
class CareAchievementsScreen extends ConsumerWidget {
  const CareAchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final achievements = ref.watch(careAchievementsProvider);
    final unlocked = achievements.where((a) => a.unlocked).toList();
    final inProgress = achievements.where((a) => !a.unlocked).toList();

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
            l10n.t(L10nKeys.careAchieveTitle),
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: 4),
          Text(
            l10n.t(L10nKeys.careAchieveSubtitle),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: CareColors.textSoft,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (unlocked.isNotEmpty) ...[
            Text(
              l10n.t(L10nKeys.careAchieveUnlocked),
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.md),
            for (final a in unlocked) ...[
              _AchievementCard(achievement: a),
              const SizedBox(height: AppSpacing.md),
            ],
          ],
          if (inProgress.isNotEmpty) ...[
            if (unlocked.isNotEmpty) const SizedBox(height: AppSpacing.md),
            Text(
              l10n.t(L10nKeys.careAchieveInProgress),
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.md),
            for (final a in inProgress) ...[
              _AchievementCard(achievement: a, muted: true),
              const SizedBox(height: AppSpacing.md),
            ],
          ],
          if (achievements.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 48),
              child: Center(child: CircularProgressIndicator()),
            ),
          CareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.t(L10nKeys.careAchieveHowTitle),
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.t(L10nKeys.careAchieveHowBody),
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
}

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({required this.achievement, this.muted = false});

  final CareAchievement achievement;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final titleKey = switch (achievement.id) {
      'firstSteps' => L10nKeys.careAchieveFirstSteps,
      'sevenDay' => L10nKeys.careAchieveSevenDay,
      'garden' => L10nKeys.careAchieveGarden,
      'perfect' => L10nKeys.careAchievePerfect,
      'engagement' => L10nKeys.careAchieveEngagement,
      _ => '',
    };
    final bodyKey = switch (achievement.id) {
      'firstSteps' => L10nKeys.careAchieveFirstStepsBody,
      'sevenDay' => L10nKeys.careAchieveSevenDayBody,
      'garden' => L10nKeys.careAchieveGardenBody,
      'perfect' => L10nKeys.careAchievePerfectBody,
      'engagement' => L10nKeys.careAchieveEngagementBody,
      _ => '',
    };
    final title =
        titleKey.isEmpty ? achievement.title : l10n.t(titleKey);
    final subtitle =
        bodyKey.isEmpty ? achievement.subtitle : l10n.t(bodyKey);

    return CareCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: muted ? CareColors.secondarySoft : CareColors.goldSoft,
              shape: BoxShape.circle,
            ),
            child: muted || !achievement.unlocked
                ? const Icon(
                    Icons.lock_outline_rounded,
                    color: CareColors.textFaint,
                  )
                : Text(
                    achievement.iconEmoji,
                    style: const TextStyle(fontSize: 28),
                  ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontFamily: CareTheme.serif,
                    color: muted ? CareColors.textSoft : CareColors.text,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: CareColors.textSoft,
                    ),
                  ),
                ],
                if (!muted && !achievement.unlocked) ...[
                  const SizedBox(height: 8),
                  CareProgressBar(progress: achievement.progress),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
