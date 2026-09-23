import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/local/app_database.dart';
import '../../data/models/enums.dart';
import '../../shared/widgets/app_cards.dart';
import 'activity_runner_screen.dart';

/// Gentle level picker for a game: Easy / Medium / Hard, always with the
/// reassurance that there is no time limit and no failing.
class PatientLevelSelectScreen extends ConsumerWidget {
  const PatientLevelSelectScreen({super.key, required this.activity});

  final Activity activity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final content = ref
        .read(depsProvider)
        .activityRepository
        .contentOf(activity);
    final emoji = content.promptEmoji.isEmpty ? '🌿' : content.promptEmoji;

    Future<void> play(Difficulty difficulty) async {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) =>
              ActivityRunnerScreen(activity: activity, difficulty: difficulty),
        ),
      );
      if (!context.mounted) return;
      ref.invalidate(todayActivityProvider);
      ref.invalidate(homeDataProvider);
    }

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(title: Text(l10n.t('levelSelectTitle'))),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            const SizedBox(height: AppSpacing.sm),
            Center(child: Text(emoji, style: const TextStyle(fontSize: 72))),
            const SizedBox(height: AppSpacing.sm),
            Center(
              child: Text(
                l10n.t(activity.titleKey),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Center(
              child: Text(
                l10n.t('levelSelectSubtitle'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(color: AppColors.inkSoft),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _LevelCard(
              emoji: '🌱',
              title: l10n.t('levelEasy'),
              description: l10n.t('levelEasyDesc'),
              accent: AppColors.lightSage,
              onTap: () => play(Difficulty.gentle),
            ),
            const SizedBox(height: AppSpacing.md),
            _LevelCard(
              emoji: '🌿',
              title: l10n.t('levelMedium'),
              description: l10n.t('levelMediumDesc'),
              accent: AppColors.mutedBeige,
              onTap: () => play(Difficulty.comfortable),
            ),
            const SizedBox(height: AppSpacing.md),
            _LevelCard(
              emoji: '🍃',
              title: l10n.t('levelHard'),
              description: l10n.t('levelHardDesc'),
              accent: AppColors.terracottaSoft,
              onTap: () => play(Difficulty.challenging),
            ),
            const SizedBox(height: AppSpacing.lg),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🕊️', style: TextStyle(fontSize: 22)),
                  const SizedBox(width: AppSpacing.xs),
                  Flexible(
                    child: Text(
                      l10n.t('levelTakeYourTime'),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: AppColors.warmBrown),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({
    required this.emoji,
    required this.title,
    required this.description,
    required this.accent,
    required this.onTap,
  });

  final String emoji;
  final String title;
  final String description;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      onTap: onTap,
      color: accent,
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.creamCard,
            child: Text(emoji, style: const TextStyle(fontSize: 30)),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: AppColors.inkSoft),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            size: 40,
            color: AppColors.inkSoft,
          ),
        ],
      ),
    );
  }
}
