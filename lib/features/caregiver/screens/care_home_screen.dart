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
import '../widgets/care_chart.dart';
import '../widgets/care_ui.dart';

/// Caregiver Home — the daily surface.
///
/// Greets the patient by name, surfaces a live SOS banner, shows today's
/// numbers, keeps gentle review items on hand and links to every other
/// section through quick actions.
class CareHomeScreen extends ConsumerWidget {
  const CareHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subject = ref.watch(careSubjectProvider).value;
    final progress = ref.watch(careProgressProvider(CareRange.week)).value;
    final remote = ref.watch(careRemoteProvider);
    final preview = ref.watch(carePreviewProvider);

    if (subject == null) {
      return const _CenterLoader();
    }

    final activeSos = remote.alerts.isEmpty ? null : remote.alerts.first;

    return CareBackground(
      child: RefreshIndicator(
        onRefresh: () async => ref.read(careRemoteProvider.notifier).refresh(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: _HomeHeader(subject: subject, preview: preview),
              ),
            ),
            if (activeSos != null)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  0,
                ),
                sliver: SliverToBoxAdapter(
                  child: _SosBanner(subjectName: subject.name),
                ),
              ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: _GreetingCard(subject: subject, preview: preview),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                0,
              ),
              sliver: SliverToBoxAdapter(child: _TodayGrid(progress: progress)),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.lg,
              ),
              sliver: SliverToBoxAdapter(
                child: _ReviewSection(
                  progress: progress,
                  onOpenProgress: () =>
                      openCareSection(context, CareRoutes.progress),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              sliver: SliverToBoxAdapter(
                child: _QuickActions(
                  onSelect: (path) {
                    openCareSection(context, path);
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              sliver: SliverToBoxAdapter(
                child: _WeekCard(
                  progress: progress,
                  onView: () => openCareSection(context, CareRoutes.progress),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CenterLoader extends StatelessWidget {
  const _CenterLoader();

  @override
  Widget build(BuildContext context) {
    return const CareBackground(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.subject, required this.preview});

  final CareSubject subject;
  final bool preview;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.t(L10nKeys.careBrandName),
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: CareColors.primary,
                  fontFamily: CareTheme.serif,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                l10n.t(L10nKeys.careBrandTagline),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: CareColors.textSoft,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => openCareSection(context, CareRoutes.profile),
          child: CareAvatar(
            emoji: subject.patient.avatarEmoji,
            size: 52,
            showPreviewTag: false,
          ),
        ),
      ],
    );
  }
}

class _SosBanner extends StatelessWidget {
  const _SosBanner({required this.subjectName});

  final String subjectName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF9E3B33), Color(0xFFC0392B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: CareColors.rose.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.sos_rounded, color: Colors.white, size: 40),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.t(L10nKeys.careSosLiveTitle, {'name': subjectName}),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.t(L10nKeys.careSosLiveSubtitle),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: CareColors.rose,
              minimumSize: const Size(0, 48),
            ),
            onPressed: () => openCareSection(context, CareRoutes.emergency),
            child: Text(l10n.t(L10nKeys.careSosOpen)),
          ),
        ],
      ),
    );
  }
}

class _GreetingCard extends StatelessWidget {
  const _GreetingCard({required this.subject, required this.preview});

  final CareSubject subject;
  final bool preview;

  String _greetingKey(DateTime now) {
    final h = now.hour;
    if (h < 12) return L10nKeys.careGreetingMorning;
    if (h < 17) return L10nKeys.careGreetingAfternoon;
    return L10nKeys.careGreetingEvening;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final name = subject.patient.name;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.t(_greetingKey(DateTime.now()), {'name': name}),
          style: theme.textTheme.displayMedium?.copyWith(
            color: CareColors.text,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.t(L10nKeys.careGreetingOk, {'name': name}),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: CareColors.textSoft,
          ),
        ),
        if (preview) ...[
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              CareTag(
                label: l10n.t(L10nKeys.carePreviewBadge),
                color: CareColors.goldSoft,
              ),
              TextButton(
                onPressed: () => openCareSection(context, CareRoutes.profile),
                child: Text(l10n.t(L10nKeys.careLinkNow)),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _TodayGrid extends StatelessWidget {
  const _TodayGrid({required this.progress});

  final CareProgress? progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final today = progress?.today ?? const CareTodaySummary();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.t(L10nKeys.careHomeToday),
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        LayoutBuilder(
          builder: (context, constraints) {
            final cols = constraints.maxWidth >= 520 ? 4 : 2;
            return GridView.count(
              crossAxisCount: cols,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: cols == 4 ? 1.25 : 1.15,
              children: [
                CareCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Center(
                    child: CareStat(
                      value: '${today.gamesPlayed}',
                      label: l10n.t(L10nKeys.careStatsGames),
                      iconEmoji: '🎮',
                    ),
                  ),
                ),
                CareCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Center(
                    child: CareStat(
                      value: '${today.playMinutes}',
                      label: l10n.t(L10nKeys.careStatsMinutes),
                      iconEmoji: '⏱️',
                    ),
                  ),
                ),
                CareCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Center(
                    child: CareStat(
                      value: '${today.avgScore.round()}',
                      label: l10n.t(L10nKeys.careStatsAvgScore),
                      iconEmoji: '🎯',
                    ),
                  ),
                ),
                CareCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Center(
                    child: CareStat(
                      value: '+${today.improvementPercent.round()}',
                      label: l10n.t(L10nKeys.careStatsStreak),
                      iconEmoji: '🔥',
                      accent: CareColors.accent,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ReviewSection extends StatelessWidget {
  const _ReviewSection({required this.progress, required this.onOpenProgress});

  final CareProgress? progress;
  final VoidCallback onOpenProgress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final items = <(String, String)>[
      (
        l10n.t(L10nKeys.careReviewWeeklyTitle),
        l10n.t(L10nKeys.careReviewWeeklyBody),
      ),
      (
        l10n.t(L10nKeys.careReviewGardenTitle),
        l10n.t(L10nKeys.careReviewGardenBody),
      ),
      (
        l10n.t(L10nKeys.careReviewMilestoneTitle),
        l10n.t(L10nKeys.careReviewMilestoneBody),
      ),
      (
        l10n.t(L10nKeys.careReviewMedicationTitle),
        l10n.t(L10nKeys.careReviewMedicationBody),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.t(L10nKeys.careHomeToReview),
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final (title, body) in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CareCard(
              onTap: onOpenProgress,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  const Icon(Icons.spa_rounded, color: CareColors.leaf),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: theme.textTheme.titleMedium),
                        const SizedBox(height: 2),
                        Text(
                          body,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: CareColors.textSoft,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: onOpenProgress,
                    child: Text(l10n.t(L10nKeys.careCtaReview)),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.onSelect});

  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final actions = [
      ('🌿', l10n.t(L10nKeys.careQuickMemories), CareRoutes.memories),
      ('📝', l10n.t(L10nKeys.careQuickNotes), CareRoutes.notes),
      ('🏆', l10n.t(L10nKeys.careQuickAchievements), CareRoutes.achievements),
      ('🚨', l10n.t(L10nKeys.careQuickEmergency), CareRoutes.emergency),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.t(L10nKeys.careQuickActions),
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            for (final (emoji, label, path) in actions)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onSelect(path),
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: CareColors.card,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: CareColors.line),
                          ),
                          child: Text(
                            emoji,
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          label,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: CareColors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _WeekCard extends StatelessWidget {
  const _WeekCard({required this.progress, required this.onView});

  final CareProgress? progress;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final week = progress?.week ?? const CareWeeklyStats();

    return CareCard(
      onTap: onView,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.t(L10nKeys.careWeekHighlight),
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              Text(
                l10n.t(L10nKeys.careWeekUp, {
                  'percent': '${week.improvementPercent.round()}',
                }),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: CareColors.success,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 18,
                color: CareColors.success,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          CareWeekBarChart(
            points: week.points,
            height: 150,
            caption: l10n.t(L10nKeys.careWeekSessionsDone, {
              'count': '${week.completedThisWeek}',
            }),
          ),
        ],
      ),
    );
  }
}
