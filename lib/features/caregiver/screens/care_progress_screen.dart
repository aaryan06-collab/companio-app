import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/l10n_keys.dart';
import '../../../core/navigation/care_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/caregiver_theme.dart';
import '../../../data/content/activity_catalog.dart';
import '../model/care_models.dart';
import '../providers/care_providers.dart';
import '../services/care_progress_service.dart';
import '../widgets/care_chart.dart';
import '../widgets/care_ui.dart';

/// Caregiver Progress — engagement, trends and skill strengths with a
/// Week / Month / All range switcher.
class CareProgressScreen extends ConsumerWidget {
  const CareProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final range = ref.watch(careRangeProvider);
    final progress = ref.watch(careProgressProvider(range)).value;
    final subject = ref.watch(careSubjectProvider).value;

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
            l10n.t(L10nKeys.careProgressTitle),
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          CareRangeSelector(
            value: range,
            onChanged: (r) => ref.read(careRangeProvider.notifier).select(r),
            weekLabel: l10n.t(L10nKeys.careTodayTitle),
            monthLabel: l10n.t('careMonth'),
            allLabel: l10n.t('careAllTime'),
          ),
          if (progress == null)
            const Padding(
              padding: EdgeInsets.only(top: 80),
              child: Center(child: CircularProgressIndicator()),
            )
          else ...[
            if (progress.totalAttempts == 0)
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: CareEmptyState(
                  emoji: '🌱',
                  title: l10n.t(L10nKeys.careNoDataTitle),
                  body: l10n.t(L10nKeys.careNoDataBody, {
                    'name': subject?.name ?? l10n.t('patient'),
                  }),
                  actionLabel: l10n.t(L10nKeys.careGoToGames),
                  onAction: () => openCareSection(context, CareRoutes.games),
                ),
              )
            else ...[
              const SizedBox(height: AppSpacing.lg),
              _TodayCard(progress: progress),
              const SizedBox(height: AppSpacing.lg),
              _WeekCard(progress: progress),
              const SizedBox(height: AppSpacing.lg),
              _SkillsCard(progress: progress),
              const SizedBox(height: AppSpacing.lg),
              _SessionsCard(progress: progress),
              const SizedBox(height: AppSpacing.lg),
              _GamesCard(progress: progress),
            ],
          ],
        ],
      ),
    );
  }
}

class _TodayCard extends StatelessWidget {
  const _TodayCard({required this.progress});

  final CareProgress progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final today = progress.today;
    return CareCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              l10n.t(L10nKeys.careTodayTitle),
              style: theme.textTheme.headlineSmall,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              0,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final cols = constraints.maxWidth >= 520 ? 4 : 2;
                return GridView.count(
                  crossAxisCount: cols,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.6,
                  children: [
                    CareStat(
                      inline: true,
                      value: '${today.gamesPlayed}',
                      label: l10n.t(L10nKeys.careStatsGames),
                    ),
                    CareStat(
                      inline: true,
                      value: '${today.playMinutes}',
                      label: l10n.t(L10nKeys.careStatsMinutes),
                    ),
                    CareStat(
                      inline: true,
                      value: '${today.avgScore.round()}',
                      label: l10n.t(L10nKeys.careStatsAvgScore),
                    ),
                    CareStat(
                      inline: true,
                      value: '+${today.improvementPercent.round()}',
                      label: l10n.t(L10nKeys.careStatsStreak),
                      accent: CareColors.accent,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekCard extends StatelessWidget {
  const _WeekCard({required this.progress});

  final CareProgress progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final week = progress.week;
    final goalPct = week.weekGoal == 0
        ? 0.0
        : (week.completedThisWeek / week.weekGoal).clamp(0.0, 1.0);

    return CareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.t(L10nKeys.careThisWeek),
            style: theme.textTheme.headlineSmall,
          ),
          Text(
            l10n.t(L10nKeys.careImprovementLabel, {
              'percent': '${week.improvementPercent.round()}',
            }),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: CareColors.success,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          CareWeekBarChart(
            points: week.points,
            height: 168,
            caption: l10n.t(L10nKeys.careWeekMinutes, {
              'count': '${week.totalMinutes}',
            }),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: CareStat(
                  value: '${week.completedThisWeek}',
                  label: l10n.t(L10nKeys.careWeekCompletedCount, {
                    'count': '',
                  }).trim(),
                ),
              ),
              Expanded(
                child: CareStat(
                  value: '+${week.streakDays}',
                  label: l10n.t(L10nKeys.careStreakCount, {'count': ''}).trim(),
                  accent: CareColors.accent,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.t(L10nKeys.careWeekGoal, {
                        'done': '${week.completedThisWeek}',
                        'total': '${week.weekGoal}',
                      }),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: CareColors.textSoft,
                      ),
                    ),
                    const SizedBox(height: 6),
                    CareProgressBar(progress: goalPct),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkillsCard extends StatelessWidget {
  const _SkillsCard({required this.progress});

  final CareProgress progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    if (progress.skills.isEmpty) return const SizedBox.shrink();
    return CareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.t(L10nKeys.careSkillStrengths),
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.lg),
          for (final skill in progress.skills)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: CareColors.leafSoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      careCategoryIcon(skill.category),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          skill.category,
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: skill.accuracyPercent.clamp(0, 100) / 100,
                            minHeight: 8,
                            color: CareColors.primary,
                            backgroundColor: CareColors.secondarySoft,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    l10n.t(L10nKeys.carePct, {
                      'pct': '${skill.accuracyPercent}',
                    }),
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: CareColors.primary,
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

class _SessionsCard extends StatelessWidget {
  const _SessionsCard({required this.progress});

  final CareProgress progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final sessions = progress.sessions;
    return CareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.t(L10nKeys.careRecentSessions),
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          if (sessions.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text(
                  l10n.t(L10nKeys.careSessionsEmptyTitle),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: CareColors.textSoft,
                  ),
                ),
              ),
            )
          else
            for (var i = 0; i < sessions.length && i < 5; i++) ...[
              _SessionRow(session: sessions[i]),
              if (i != sessions.length - 1 && i != 4) const Divider(),
            ],
        ],
      ),
    );
  }
}

class _SessionRow extends StatelessWidget {
  const _SessionRow({required this.session});

  final CareSessionRecord session;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final ts = session.startedAt;
    final dateLabel = '${ts.day} ${_monthAbbr(ts.month)}';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm + 2),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: CareColors.secondarySoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              careCategoryIcon(session.category),
              style: const TextStyle(fontSize: 22),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(session.activityTitle, style: theme.textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(
                  l10n.t(L10nKeys.careSessionMeta, {
                    'date': dateLabel,
                    'minutes': '${session.minutes}',
                  }),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: CareColors.textSoft,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${session.score.round()}',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: CareColors.primary,
                ),
              ),
              Text(
                l10n.t(L10nKeys.careScoreLabel),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: CareColors.textFaint,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _monthAbbr(int m) => const [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ][m];
}

class _GamesCard extends StatelessWidget {
  const _GamesCard({required this.progress});

  final CareProgress progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final games = progress.games;

    return CareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.t(L10nKeys.careGamePerformance),
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              TextButton(
                onPressed: () => openCareSection(context, CareRoutes.games),
                child: Text(l10n.t(L10nKeys.careSeeAll)),
              ),
            ],
          ),
          if (games.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text(
                  l10n.t(L10nKeys.careGamesEmptyTitle),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: CareColors.textSoft,
                  ),
                ),
              ),
            )
          else
            for (var i = 0; i < games.length && i < 4; i++) ...[
              _GameRow(game: games[i]),
              if (i != games.length - 1 && i != 3) const Divider(),
            ],
        ],
      ),
    );
  }
}

class _GameRow extends ConsumerWidget {
  const _GameRow({required this.game});

  final CareGameStat game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final def = ActivityCatalog.byId(game.activityId);
    final title = game.title.isNotEmpty
        ? game.title
        : (def == null ? '' : l10n.t(def.titleKey));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm + 2),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>
                CareRouteScope(child: _GameDetail(gameId: game.activityId)),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: CareColors.leafSoft,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                careCategoryIcon(game.category),
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(
                    l10n.t(L10nKeys.carePlayedCount, {
                      'count': '${game.playCount}',
                    }),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: CareColors.textSoft,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${game.avgScore.round()}%',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: CareColors.primary,
                  ),
                ),
                Text(
                  l10n.t(L10nKeys.careAvgScoreShort),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: CareColors.textFaint,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right_rounded,
              color: CareColors.textFaint,
            ),
          ],
        ),
      ),
    );
  }
}

class _GameDetail extends ConsumerWidget {
  const _GameDetail({required this.gameId});

  final String gameId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final range = ref.watch(careRangeProvider);
    final progress = ref.watch(careProgressProvider(range)).value;
    final game = progress?.games
        .where((g) => g.activityId == gameId)
        .firstOrNull;
    final activities = ref.watch(activitiesProvider).value ?? const [];
    final title = (game != null && game.title.isNotEmpty)
        ? game.title
        : (activities.where((a) => a.id == gameId).firstOrNull == null
              ? ''
              : l10n.t(
                  activities.where((a) => a.id == gameId).firstOrNull!.titleKey,
                ));

    return CarePage(
      title: l10n.t(L10nKeys.careGameTitle),
      onBack: () => Navigator.of(context).pop(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (game == null)
            CareEmptyState(
              emoji: '🎮',
              title: l10n.t(L10nKeys.careNoDataTitle),
              body: l10n.t(L10nKeys.careGameNoSessions),
            )
          else ...[
            Row(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: CareColors.leafSoft,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Text(
                    careCategoryIcon(game.category),
                    style: const TextStyle(fontSize: 38),
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      CareTag(label: game.category),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            CareCard(
              padding: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: CareStat(
                        value: '${game.playCount}',
                        label: l10n.t(L10nKeys.careGamePlayCountTitle),
                      ),
                    ),
                    Expanded(
                      child: CareStat(
                        value: '${game.avgScore.round()}%',
                        label: l10n.t(L10nKeys.careGameAvgTitle),
                      ),
                    ),
                    Expanded(
                      child: CareStat(
                        value: '${game.bestScore.round()}%',
                        label: l10n.t(L10nKeys.careGameBestTitle),
                        accent: CareColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            CareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.t(L10nKeys.careGameRecentRounds),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  if (progress?.sessions
                          .where((s) => s.activityId == gameId)
                          .isEmpty ??
                      true)
                    Text(
                      l10n.t(L10nKeys.careGameNoSessions),
                      style: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(color: CareColors.textSoft),
                    )
                  else
                    for (final s in progress!.sessions.where(
                      (s) => s.activityId == gameId,
                    ))
                      _SessionRow(session: s),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
