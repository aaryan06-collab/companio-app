import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utilities/greeting.dart';
import '../../data/local/app_database.dart';
import '../../data/models/enums.dart';
import '../../domain/services/cognitive_screen_service.dart';
import '../../domain/services/garden_service.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_cards.dart';
import '../../shared/widgets/splash_screen.dart';
import 'activity_runner_screen.dart';
import 'patient_shell.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final home = ref.watch(homeDataProvider);
    final pending = ref.watch(pendingSyncCountProvider).value ?? 0;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: home.when(
          loading: () => const SplashMini(),
          error: (e, _) => EmptyState(
            emoji: '🍃',
            title: l10n.t('errorGeneric'),
            body: l10n.t('errorGenericBody'),
          ),
          data: (data) => RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(homeDataProvider);
              ref.invalidate(gardenProvider);
            },
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              children: [
                OfflineBanner(pending: pending),
                const SizedBox(height: AppSpacing.md),
                _GreetingCard(
                  name: data.profile.displayName,
                  onSettings: () => PatientTabController.of(context)?.value = 4,
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  l10n.t('homeWhatNeed'),
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSpacing.md),
                _LetsPlayCard(
                  onPlay: () => PatientTabController.of(context)?.value = 1,
                ),
                const SizedBox(height: AppSpacing.md),
                if (data.todayActivity != null && data.todaysCompletions == 0)
                  _TodayActivityCard(
                    onStart: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => ActivityRunnerScreen(
                            activity: data.todayActivity!,
                          ),
                        ),
                      );
                      ref.invalidate(homeDataProvider);
                    },
                  )
                else
                  _QuickMenu(),
                const SizedBox(height: AppSpacing.md),
                _MysteryCard(
                  unlocked: data.mystery?.unlocked ?? false,
                  remaining: data.mystery?.remaining ?? 0,
                  completions: data.mystery?.completions ?? 0,
                  memory: data.memoryOfDay,
                ),
                const SizedBox(height: AppSpacing.md),
                _ScreeningStatusCard(),
                const SizedBox(height: AppSpacing.md),
                _GardenPreviewCard(data: data),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GreetingCard extends StatelessWidget {
  const _GreetingCard({required this.name, this.onSettings});

  final String name;
  final VoidCallback? onSettings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final key = Greeting.now();
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: AppColors.sageMist,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text('🌸', style: TextStyle(fontSize: 34)),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${l10n.t(key)}, $name 🌿',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.deepGreen,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        if (onSettings != null)
          IconButton(
            onPressed: onSettings,
            icon: const Icon(Icons.settings_outlined),
            color: AppColors.deepGreen,
            iconSize: 30,
          ),
      ],
    );
  }
}

/// Big, unmissable "Let's play" call to action on the home screen.
class _LetsPlayCard extends StatelessWidget {
  const _LetsPlayCard({required this.onPlay});

  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.deepGreen, AppColors.deepGreenDark],
        ),
        borderRadius: BorderRadius.circular(AppRadii.lg),
        boxShadow: const [
          BoxShadow(
            color: Color(0x333F684C),
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🎮', style: TextStyle(fontSize: 34)),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  l10n.t('homeLetsPlayTitle'),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.t('homeLetsPlaySubtitle'),
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSpacing.md),
          AppPrimaryButton(
            label: l10n.t('homePlayCta'),
            icon: Icons.play_arrow_rounded,
            onPressed: onPlay,
          ),
        ],
      ),
    );
  }
}

class _ScreeningStatusCard extends ConsumerWidget {
  const _ScreeningStatusCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final patientId = ref.watch(patientIdProvider);
    if (patientId == null) return const SizedBox.shrink();
    final latest = ref.watch(latestAssessmentProvider(patientId)).value;
    if (latest == null) return const SizedBox.shrink();

    if (latest.score < 0) {
      return SectionCard(
        color: AppColors.skySoft,
        child: Row(
          children: [
            const Text('🤗', style: TextStyle(fontSize: 34)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                l10n.t('screenSkipped'),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      );
    }

    final band = screeningBandFor(latest.score);
    final resultTitle = l10n.t(latest.statusKey);
    return SectionCard(
      color: AppColors.sageMist,
      child: Row(
        children: [
          Text(
            latest.statusKey == 'screenSkipped' ? '🤗' : screeningEmoji(band),
            style: const TextStyle(fontSize: 34),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resultTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  '${latest.score}/${latest.maxScore}',
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: AppColors.inkSoft),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayActivityCard extends ConsumerWidget {
  const _TodayActivityCard({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final today = ref.watch(todayActivityProvider).value;
    if (today == null) {
      return const EmptyState(emoji: '🌱', title: '', body: '');
    }
    final content = ref
        .read(depsProvider)
        .activityRepository
        .contentOf(today.activity);
    return SectionCard(
      color: AppColors.sageMist,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '✨ ${l10n.t('homeTodayActivity')}',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(color: AppColors.terracotta),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${content.promptEmoji} ${l10n.t(today.activity.titleKey)}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${l10n.t(today.activity.subtitleKey ?? '')} · ',
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: AppColors.inkSoft),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.md),
          AppPrimaryButton(
            label: l10n.t('homeContinueActivity'),
            icon: Icons.play_arrow_rounded,
            onPressed: onStart,
          ),
        ],
      ),
    );
  }
}

class _QuickMenu extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: _QuickTile(
            emoji: '🎮',
            label: l10n.t('navGames'),
            onTap: () => PatientTabController.of(context)?.value = 1,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _QuickTile(
            emoji: '🌼',
            label: l10n.t('navGarden'),
            onTap: () => PatientTabController.of(context)?.value = 2,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _QuickTile(
            emoji: '📸',
            label: l10n.t('navMemories'),
            onTap: () => PatientTabController.of(context)?.value = 3,
          ),
        ),
      ],
    );
  }
}

class _GardenPreviewCard extends ConsumerWidget {
  const _GardenPreviewCard({required this.data});

  final HomeData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final emojis = data.elements
        .map(
          (e) => GardenPresentation.emojiFor(
            kind: GardenElementKind.fromString(e.kind),
            stage: e.stage,
          ).$1,
        )
        .take(8)
        .toList();
    return SectionCard(
      onTap: () => PatientTabController.of(context)?.value = 2,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.t('homeGardenPreview'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  emojis.isEmpty ? l10n.t('gardenEmpty') : emojis.join(' '),
                  style: const TextStyle(fontSize: 26),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${data.livePlants} ${l10n.t('gardenGrowth')} · '
                  '${data.points} ${l10n.t('unitsPoints')}',
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: AppColors.inkSoft),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            size: 36,
            color: AppColors.inkSoft,
          ),
        ],
      ),
    );
  }
}

class _MysteryCard extends StatelessWidget {
  const _MysteryCard({
    required this.unlocked,
    required this.remaining,
    required this.completions,
    required this.memory,
  });

  final bool unlocked;
  final int remaining;
  final int completions;
  final Memory? memory;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (unlocked && memory != null) {
      return SectionCard(
        child: Row(
          children: [
            const Text('🔓', style: TextStyle(fontSize: 40)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.t('homeMemoryUnlocked'),
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(color: AppColors.success),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    memory!.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    final progress = completions / 2.0;
    return SectionCard(
      color: AppColors.warmYellowSoft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${l10n.t('homeMemoryLocked')} 🎁',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.t('mysteryLockedBody', {'count': '$remaining'}),
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: AppColors.inkSoft),
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 10,
              backgroundColor: Colors.white,
              color: AppColors.terracotta,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({
    required this.emoji,
    required this.label,
    required this.onTap,
  });

  final String emoji;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.creamCard,
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(color: AppColors.line),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 34)),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
