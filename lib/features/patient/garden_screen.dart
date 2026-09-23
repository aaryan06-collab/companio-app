import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/local/app_database.dart';
import '../../data/models/enums.dart';
import '../../domain/services/garden_service.dart';
import '../../shared/widgets/app_cards.dart';
import '../../shared/widgets/splash_screen.dart';

/// Memory Garden tab (kept as its own screen so it can be embedded by the
/// Garden-with-progress view without duplicating plant rendering).
class GardenScreen extends ConsumerWidget {
  const GardenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => ref.invalidate(gardenProvider),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: const [GardenContent()],
          ),
        ),
      ),
    );
  }
}

/// The garden body (header, plants, stats) — a plain column so it can be
/// dropped into any scrollable. `showHeader` hides the big title for reuse
/// inside composite screens.
class GardenContent extends ConsumerWidget {
  const GardenContent({super.key, this.showHeader = true});

  final bool showHeader;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final garden = ref.watch(gardenProvider);
    return garden.when(
      loading: () => const Center(child: SplashMini()),
      error: (e, _) => EmptyState(
        emoji: '🍃',
        title: l10n.t('errorGeneric'),
        body: l10n.t('errorGenericBody'),
      ),
      data: (view) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeader)
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.t('gardenTitle'),
                    style: Theme.of(context).textTheme.headlineLarge
                        ?.copyWith(color: AppColors.deepGreen),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.sageMist,
                    borderRadius: BorderRadius.circular(AppRadii.pill),
                  ),
                  child: Text(
                    '⭐ ${view.garden.points} ${l10n.t('unitsPoints')}',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(color: AppColors.deepGreenDark),
                  ),
                ),
              ],
            ),
          if (showHeader) const SizedBox(height: AppSpacing.md),
          if (view.elements.isEmpty)
            EmptyState(
              emoji: '🌱',
              title: l10n.t('gardenEmpty'),
              body: l10n.t('gardenEmptyBody'),
            )
          else
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final element in view.elements)
                  _PlantCard(element: element),
              ],
            ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: StatTile(
                  emoji: '🌿',
                  label: l10n.t('gardenGrowth'),
                  value: '${view.elements.length}',
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: StatTile(
                  emoji: '⭐',
                  label: l10n.t('unitsPoints'),
                  value: '${view.garden.points}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlantCard extends StatelessWidget {
  const _PlantCard({required this.element});

  final GardenElement element;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (emoji, stageLabel) = _visual();
    return Container(
      width: 132,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.creamCard,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 44)),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.t(stageLabel),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.deepGreen,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          if (element.memoryId != null)
            Text('🖼️', style: TextStyle(fontSize: 18))
          else
            Text(
              '·',
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: AppColors.inkFaint),
            ),
        ],
      ),
    );
  }

  (String, String) _visual() {
    final mapping = GardenPresentation.emojiFor(
      kind: GardenElementKind.fromString(element.kind),
      stage: element.stage,
    );
    return (mapping.$1, GardenPresentation.l10nKeyForStage(element.stage));
  }
}
