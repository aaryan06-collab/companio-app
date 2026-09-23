import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/l10n_keys.dart';
import '../../../core/navigation/care_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/caregiver_theme.dart';
import '../model/care_models.dart';
import '../providers/care_providers.dart';
import '../services/care_progress_service.dart';
import '../widgets/care_ui.dart';

/// Caregiver Games — the catalogue of play sessions with per-game stats.
class CareGamesScreen extends ConsumerStatefulWidget {
  const CareGamesScreen({super.key});

  @override
  ConsumerState<CareGamesScreen> createState() => _CareGamesScreenState();
}

class _CareGamesScreenState extends ConsumerState<CareGamesScreen> {
  String? _category;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final range = ref.watch(careRangeProvider);
    final progress = ref.watch(careProgressProvider(range)).value;
    final activities = ref.watch(activitiesProvider).value ?? const [];

    final filtered = activities
        .where((a) => _category == null || a.category == _category)
        .toList();

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
            l10n.t(L10nKeys.careGamesTitle),
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: 4),
          Text(
            l10n.t(L10nKeys.careGamesSubtitle),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: CareColors.textSoft,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 42,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _categoryChip(l10n.t(L10nKeys.careAllCategory), null),
                for (final c in careCategories)
                  _categoryChip(l10n.t(careCategoryLabelKey(c)), c),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (filtered.isEmpty)
            CareEmptyState(
              emoji: '🎮',
              title: l10n.t(L10nKeys.careGamesEmptyTitle),
              body: l10n.t(L10nKeys.careGamesEmptyBody),
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final cols = constraints.maxWidth >= 640
                    ? 3
                    : (constraints.maxWidth >= 380 ? 2 : 1);
                final width =
                    (constraints.maxWidth - (cols - 1) * AppSpacing.md) / cols;
                return Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: [
                    for (final a in filtered)
                      SizedBox(
                        width: width,
                        child: _GameCard(
                          activityId: a.id,
                          title: l10n.t(a.titleKey),
                          subtitleKey: a.subtitleKey,
                          category: a.category,
                          stat: progress?.games
                              .where((g) => g.activityId == a.id)
                              .firstOrNull,
                        ),
                      ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _categoryChip(String label, String? value) {
    final selected = _category == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => setState(() => _category = value),
        selectedColor: CareColors.primary,
        labelStyle: Theme.of(context).textTheme.labelMedium
            ?.copyWith(color: selected ? Colors.white : CareColors.text),
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  const _GameCard({
    required this.activityId,
    required this.title,
    required this.subtitleKey,
    required this.category,
    required this.stat,
  });

  final String activityId;
  final String title;
  final String? subtitleKey;
  final String category;
  final CareGameStat? stat;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final hasStat = stat != null && stat!.playCount > 0;

    return CareCard(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CareRouteScope(
            child: _GameDetailScreen(
              activityId: activityId,
              title: title,
              subtitleKey: subtitleKey,
              category: category,
            ),
          ),
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: CareColors.leafSoft,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  careCategoryIcon(category),
                  style: const TextStyle(fontSize: 26),
                ),
              ),
              const Spacer(),
              if (hasStat)
                CareTag(
                  label: '${stat!.avgScore.round()}%',
                  color: CareColors.secondarySoft,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(title, style: theme.textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            l10n.t(careCategoryLabelKey(category)),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: CareColors.textSoft,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (hasStat)
            Row(
              children: [
                CareStat(
                  inline: true,
                  value: '${stat!.playCount}',
                  label: l10n.t(L10nKeys.careStatsGames),
                ),
                const SizedBox(width: AppSpacing.lg),
                CareStat(
                  inline: true,
                  value: '${stat!.bestScore.round()}',
                  label: l10n.t(L10nKeys.careBestScore),
                  accent: CareColors.gold,
                ),
              ],
            )
          else
            Text(
              l10n.t(L10nKeys.careNotPlayedYet),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: CareColors.textFaint,
              ),
            ),
        ],
      ),
    );
  }
}

class _GameDetailScreen extends ConsumerWidget {
  const _GameDetailScreen({
    required this.activityId,
    required this.title,
    required this.subtitleKey,
    required this.category,
  });

  final String activityId;
  final String title;
  final String? subtitleKey;
  final String category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final range = ref.watch(careRangeProvider);
    final progress = ref.watch(careProgressProvider(range)).value;
    final stat = progress?.games
        .where((g) => g.activityId == activityId)
        .firstOrNull;
    final sessions =
        progress?.sessions.where((s) => s.activityId == activityId).toList() ??
        const <CareSessionRecord>[];

    return CarePage(
      title: title,
      onBack: () => Navigator.of(context).pop(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CareTag(label: l10n.t(careCategoryLabelKey(category))),
          const SizedBox(height: AppSpacing.lg),
          if (stat != null && stat.playCount > 0)
            CareCard(
              padding: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: CareStat(
                        value: '${stat.playCount}',
                        label: l10n.t(L10nKeys.careGamePlayCountTitle),
                      ),
                    ),
                    Expanded(
                      child: CareStat(
                        value: '${stat.avgScore.round()}%',
                        label: l10n.t(L10nKeys.careGameAvgTitle),
                      ),
                    ),
                    Expanded(
                      child: CareStat(
                        value: '${stat.bestScore.round()}%',
                        label: l10n.t(L10nKeys.careGameBestTitle),
                        accent: CareColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            CareCard(
              child: Text(
                l10n.t(L10nKeys.careNotPlayedYet),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: CareColors.textSoft,
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          if (subtitleKey != null && subtitleKey!.isNotEmpty) ...[
            CareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.t(L10nKeys.careGameHowToPlay),
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.t(subtitleKey!, {'title': title}),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: CareColors.textSoft,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (stat != null && stat.mostActiveDayKey.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            CareCard(
              child: Row(
                children: [
                  const Icon(
                    Icons.trending_up_rounded,
                    color: CareColors.accent,
                    size: 32,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.t(L10nKeys.careGameMostActiveDay),
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${stat.mostActiveDayKey} · '
                          '${stat.mostActiveMinutes} ${l10n.t(L10nKeys.careStatsMinutes)}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: CareColors.textSoft,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          CareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.t(L10nKeys.careGameRecentRounds),
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                if (sessions.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      l10n.t(L10nKeys.careGameNoSessions),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: CareColors.textSoft,
                      ),
                    ),
                  )
                else
                  for (var i = 0; i < sessions.length; i++) ...[
                    _simpleSessionRow(sessions[i], l10n, theme),
                    if (i != sessions.length - 1) const Divider(),
                  ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _simpleSessionRow(
    CareSessionRecord s,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final ts = s.startedAt;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${ts.day}/${ts.month}',
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  '${s.minutes} ${l10n.t(L10nKeys.careStatsMinutes)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: CareColors.textSoft,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${s.score.round()}',
            style: theme.textTheme.titleMedium?.copyWith(
              color: CareColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
