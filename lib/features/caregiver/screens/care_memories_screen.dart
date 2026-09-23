import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/l10n_keys.dart';
import '../../../core/navigation/care_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/caregiver_theme.dart';
import '../../../data/local/app_database.dart';
import '../../../data/models/enums.dart';
import '../../../shared/widgets/memory_media.dart';
import '../providers/care_providers.dart';
import '../widgets/care_ui.dart';
import 'care_add_memory_screen.dart';

const Map<MemoryKind, String> kMemoryKindEmoji = {
  MemoryKind.text: '📝',
  MemoryKind.photo: '🖼️',
  MemoryKind.voice: '🎙️',
  MemoryKind.sound: '🔊',
  MemoryKind.place: '📍',
};

String memoryCategoryLabelKey(MemoryCategory c) => switch (c) {
  MemoryCategory.family => L10nKeys.careMemoryCategoryFamily,
  MemoryCategory.childhood => L10nKeys.careMemoryCategoryChildhood,
  MemoryCategory.places => L10nKeys.careMemoryCategoryPlaces,
  MemoryCategory.festivals => L10nKeys.careMemoryCategoryFestivals,
  MemoryCategory.important => L10nKeys.careMemoryCategoryImportant,
};

String memoryKindLabelKey(MemoryKind k) => switch (k) {
  MemoryKind.text => L10nKeys.careMemoryKindText,
  MemoryKind.photo => L10nKeys.careMemoryKindPhoto,
  MemoryKind.voice => L10nKeys.careMemoryKindVoice,
  MemoryKind.sound => L10nKeys.careMemoryKindSound,
  MemoryKind.place => L10nKeys.careMemoryKindPlace,
};

String memoryPlacementLabelKey(MemoryPlacement p) => switch (p) {
  MemoryPlacement.garden => L10nKeys.careMemoryPlacementGarden,
  MemoryPlacement.mystery => L10nKeys.careMemoryPlacementMystery,
  MemoryPlacement.rescue => L10nKeys.careMemoryPlacementRescue,
  MemoryPlacement.pictureMatch => L10nKeys.careMemoryPlacementPicture,
  MemoryPlacement.familiarObjects => L10nKeys.careMemoryPlacementObjects,
  MemoryPlacement.familyMemories => L10nKeys.careMemoryPlacementObjects,
};

List<MemoryPlacement> decodePlacements(Memory m) {
  try {
    final list = jsonDecode(m.placementsJson) as List<dynamic>;
    return list
        .map(
          (e) => MemoryPlacement.values.firstWhere(
            (p) => p.name == e,
            orElse: () => MemoryPlacement.garden,
          ),
        )
        .toList();
  } catch (_) {
    return const [MemoryPlacement.garden];
  }
}

/// The subject's Memory Garden with caregiver-authored contributions.
class CareMemoriesScreen extends ConsumerWidget {
  const CareMemoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final async = ref.watch(careMemoriesProvider);
    final memories = async.value ?? const <Memory>[];

    return CareBackground(
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              120,
            ),
            children: [
              Text(
                l10n.t(L10nKeys.careMemoriesTitle),
                style: theme.textTheme.displayMedium,
              ),
              const SizedBox(height: 4),
              Text(
                l10n.t(L10nKeys.careMemoriesSubtitle),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: CareColors.textSoft,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (async.isLoading && memories.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (memories.isEmpty)
                CareEmptyState(
                  emoji: '🌼',
                  title: l10n.t(L10nKeys.careMemoriesEmptyTitle),
                  body: l10n.t(L10nKeys.careMemoriesEmptyBody),
                  actionLabel: l10n.t(L10nKeys.careAddMemory),
                  onAction: () => _openAdd(context),
                )
              else
                for (final m in memories) ...[
                  _MemoryCard(memory: m),
                  const SizedBox(height: AppSpacing.md),
                ],
            ],
          ),
          Positioned(
            right: AppSpacing.lg,
            bottom: AppSpacing.lg,
            child: FloatingActionButton.extended(
              onPressed: () => _openAdd(context),
              icon: const Icon(Icons.add_rounded),
              label: Text(l10n.t(L10nKeys.careAddMemory)),
            ),
          ),
        ],
      ),
    );
  }

  void _openAdd(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CareRouteScope(child: CareAddMemoryScreen()),
      ),
    );
  }
}

class _MemoryCard extends StatelessWidget {
  const _MemoryCard({required this.memory});

  final Memory memory;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final kind = MemoryKind.fromString(memory.kind);
    final category = MemoryCategory.fromString(memory.category);
    final placements = decodePlacements(memory);
    final ts = memory.createdAt;

    return CareCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    kMemoryKindEmoji[kind]!,
                    style: const TextStyle(fontSize: 26),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        memory.title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontFamily: CareTheme.serif,
                        ),
                      ),
                      if (memory.caption != null &&
                          memory.caption!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          memory.caption!,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: CareColors.textSoft,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          CareTag(
                            label: l10n.t(memoryCategoryLabelKey(category)),
                          ),
                          for (final p in placements)
                            CareTag(
                              label: l10n.t(memoryPlacementLabelKey(p)),
                              color: CareColors.goldSoft,
                              foreground: CareColors.gold,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (kind == MemoryKind.photo &&
              ((memory.mediaUrl?.isNotEmpty ?? false) ||
                  (memory.mediaPath?.isNotEmpty ?? false)))
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: MemoryMediaImage(
                  mediaPath: memory.mediaPath,
                  mediaUrl: memory.mediaUrl,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              bottom: AppSpacing.md,
            ),
            child: Row(
              children: [
                Text(
                  '${ts.day}/${ts.month}/${ts.year}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: CareColors.textFaint,
                  ),
                ),
                const Spacer(),
                Text(
                  l10n.t('careByCaregiver'),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: CareColors.textFaint,
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

/// Generate a fresh memory id for caregiver-authored entries.
String newMemoryId() => 'memcare.${const Uuid().v4()}';
