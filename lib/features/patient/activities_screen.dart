import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/local/app_database.dart';
import '../../data/models/enums.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_cards.dart';
import '../../shared/widgets/splash_screen.dart';
import 'activity_runner_screen.dart';
import 'patient_level_select_screen.dart';

/// Games hub (patient): a calm "Choose a game" board with four big cards plus
/// the fuller gentle-activity library for variety.
class ActivitiesScreen extends ConsumerWidget {
  const ActivitiesScreen({super.key});

  static const List<_CuratedGame> _curated = [
    _CuratedGame(
      type: ActivityType.pairs,
      emoji: '🃏',
      titleKey: 'gamePictureMatch',
      descKey: 'gamePictureMatchDesc',
    ),
    _CuratedGame(
      type: ActivityType.sequenceRecall,
      emoji: '🧠',
      titleKey: 'gameRememberOrder',
      descKey: 'gameRememberOrderDesc',
    ),
    _CuratedGame(
      type: ActivityType.recall,
      emoji: '💭',
      titleKey: 'gameWordRecall',
      descKey: 'gameWordRecallDesc',
    ),
    _CuratedGame(
      type: ActivityType.matching,
      emoji: '🧩',
      titleKey: 'gameShapeMatch',
      descKey: 'gameShapeMatchDesc',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final activities = ref.watch(activitiesProvider);
    final today = ref.watch(todayActivityProvider).value;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: activities.when(
          loading: () => const SplashMini(),
          error: (e, _) => EmptyState(
            emoji: '🍃',
            title: l10n.t('errorGeneric'),
            body: l10n.t('errorGenericBody'),
          ),
          data: (list) {
            final byType = {
              for (final a in list) ActivityType.fromString(a.type): a,
            };
            final library = list.where((a) => !_isCurated(a.type)).toList();
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                Text(
                  l10n.t('chooseGameTitle'),
                  style: Theme.of(context).textTheme.headlineLarge
                      ?.copyWith(color: AppColors.deepGreen),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.t('chooseGameSubtitle'),
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(color: AppColors.inkSoft),
                ),
                if (today != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  _TodayCard(
                    onStart: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => PatientLevelSelectScreen(
                            activity: today.activity,
                          ),
                        ),
                      );
                      ref.invalidate(todayActivityProvider);
                      ref.invalidate(homeDataProvider);
                    },
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.md,
                  childAspectRatio: 0.92,
                  children: [
                    for (final game in ActivitiesScreen._curated)
                      if (byType.containsKey(game.type))
                        _GameCard(
                          game: game,
                          onTap: () async {
                            final activity = byType[game.type]!;
                            await Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => PatientLevelSelectScreen(
                                  activity: activity,
                                ),
                              ),
                            );
                            ref.invalidate(todayActivityProvider);
                            ref.invalidate(homeDataProvider);
                          },
                        ),
                  ],
                ),
                if (library.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    l10n.t('gamesMoreTitle'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  for (final activity in library)
                    _ActivityRow(
                      activity: activity,
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) =>
                                ActivityRunnerScreen(activity: activity),
                          ),
                        );
                        ref.invalidate(todayActivityProvider);
                        ref.invalidate(activitiesProvider);
                        ref.invalidate(homeDataProvider);
                      },
                    ),
                ],
                const SizedBox(height: AppSpacing.xl),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CuratedGame {
  const _CuratedGame({
    required this.type,
    required this.emoji,
    required this.titleKey,
    required this.descKey,
  });

  final ActivityType type;
  final String emoji;
  final String titleKey;
  final String descKey;
}

bool _isCurated(String type) {
  for (final game in ActivitiesScreen._curated) {
    if (game.type.name == type) return true;
  }
  return false;
}

class _GameCard extends StatelessWidget {
  const _GameCard({required this.game, required this.onTap});

  final _CuratedGame game;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      onTap: onTap,
      color: AppColors.sageMist,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: AppColors.creamCard,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(game.emoji, style: const TextStyle(fontSize: 30)),
          ),
          const Spacer(),
          Text(
            l10n.t(game.titleKey),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.t(game.descKey),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: AppColors.inkSoft),
          ),
        ],
      ),
    );
  }
}

class _TodayCard extends ConsumerWidget {
  const _TodayCard({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final today = ref.watch(todayActivityProvider).value;
    if (today == null) return const SizedBox.shrink();
    final content = ref
        .read(depsProvider)
        .activityRepository
        .contentOf(today.activity);
    return SectionCard(
      color: AppColors.warmYellowSoft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '✨ ${l10n.t('activitiesToday')}',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(color: AppColors.terracotta),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${content.promptEmoji} ${l10n.t(today.activity.titleKey)}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppPrimaryButton(
            label: l10n.t('activitiesStart'),
            icon: Icons.play_arrow_rounded,
            onPressed: onStart,
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends ConsumerWidget {
  const _ActivityRow({required this.activity, required this.onTap});

  final Activity activity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final content = ref
        .read(depsProvider)
        .activityRepository
        .contentOf(activity);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: SectionCard(
        onTap: onTap,
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.sageMist,
              child: Text(
                content.promptEmoji.isEmpty
                    ? _typeEmoji(ActivityType.fromString(activity.type))
                    : content.promptEmoji,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.t(activity.titleKey),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${activity.durationSec ~/ 60} ${l10n.t('homeMinutes')} · '
                    '${_difficultyLabel(l10n, activity.baseDifficulty)}',
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: AppColors.inkSoft),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 34,
              color: AppColors.inkSoft,
            ),
          ],
        ),
      ),
    );
  }
}

String _difficultyLabel(AppLocalizations l10n, Difficulty d) => switch (d) {
  Difficulty.gentle => l10n.t('levelEasy'),
  Difficulty.comfortable => l10n.t('levelMedium'),
  Difficulty.challenging => l10n.t('levelHard'),
};

String _typeEmoji(ActivityType type) => switch (type) {
  ActivityType.matching => '🧩',
  ActivityType.sequence => '🔢',
  ActivityType.shopping => '🛒',
  ActivityType.kitchen => '🍲',
  ActivityType.recognition => '👀',
  ActivityType.association => '🧠',
  ActivityType.recall => '💭',
  ActivityType.attention => '🎯',
  ActivityType.pairs => '🃏',
  ActivityType.sequenceRecall => '⏳',
  ActivityType.findChanged => '🔍',
};
