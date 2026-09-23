import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../domain/models/patient_progress.dart';
import '../../shared/widgets/app_cards.dart';
import 'garden_screen.dart';

/// The Garden tab: progress summary feeding the memory garden (one view, same
/// name — the garden IS the progress). Plants come from real garden data;
/// weekly numbers come from the demo progress provider (swappable later).
class PatientGardenScreen extends ConsumerWidget {
  const PatientGardenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final progress = ref.watch(patientProgressProvider);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => ref.invalidate(gardenProvider),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              _WeekProgressSummary(progress: progress),
              const SizedBox(height: AppSpacing.lg),
              const GardenContent(showHeader: true),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.t('progressKeepGoing'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(color: AppColors.deepGreen),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeekProgressSummary extends ConsumerWidget {
  const _WeekProgressSummary({required this.progress});

  final PatientProgress progress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🎯 ${l10n.t('progressRecentActivity')}',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(color: AppColors.deepGreen),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: StatTile(
                  emoji: '🎮',
                  label: l10n.t('progressGamesPlayed'),
                  value: '${progress.gamesPlayedTotal}',
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: StatTile(
                  emoji: '🔥',
                  label: l10n.t('progressBestStreak'),
                  value: l10n.t('progressStreakDays', {
                    'n': '${progress.bestStreakDays}',
                  }),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Text('🌿', style: TextStyle(fontSize: 24)),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  l10n.t('progressGamesThisWeek', {
                    'n': '${progress.gamesThisWeek}',
                  }),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
