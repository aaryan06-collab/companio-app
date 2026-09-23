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

class MemoriesScreen extends ConsumerStatefulWidget {
  const MemoriesScreen({super.key});

  @override
  ConsumerState<MemoriesScreen> createState() => _MemoriesScreenState();
}

class _MemoriesScreenState extends ConsumerState<MemoriesScreen> {
  Future<void> _addMemory() async {
    final l10n = AppLocalizations.of(context);
    final title = TextEditingController();
    final caption = TextEditingController();
    MemoryCategory chosen = MemoryCategory.family;
    final added = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.creamCard,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, setSheet) => Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.lg,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.t('memoriesTitle'),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: title,
                style: Theme.of(context).textTheme.titleMedium,
                decoration: InputDecoration(
                  labelText: l10n.t('careMemoryTitle'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.sm),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: caption,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: l10n.t('careMemoryCaption'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.sm),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.xs,
                children: [
                  for (final category in MemoryCategory.values)
                    ChoiceChip(
                      label: Text(_categoryLabel(category)),
                      selected: chosen == category,
                      onSelected: (_) => setSheet(() => chosen = category),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              AppPrimaryButton(
                label: l10n.t('save'),
                icon: Icons.check_rounded,
                onPressed: () async {
                  if (title.text.trim().isEmpty) return;
                  Navigator.of(sheetContext).pop(true);
                  await completeMemoryAdd(
                    ref: ref,
                    title: title.text.trim(),
                    caption: caption.text.trim().isEmpty
                        ? null
                        : caption.text.trim(),
                    category: chosen,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
    title.dispose();
    caption.dispose();
    if (added == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).t('activityPraise')),
        ),
      );
    }
  }

  String _categoryLabel(MemoryCategory category) => switch (category) {
    MemoryCategory.family => '👨‍👩‍👧‍👦',
    MemoryCategory.childhood => '🧒',
    MemoryCategory.places => '🏔️',
    MemoryCategory.festivals => '🪔',
    MemoryCategory.important => '⭐',
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final memories = ref.watch(memoriesProvider);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: memories.when(
          loading: () => const SplashMini(),
          error: (e, _) => EmptyState(
            emoji: '🍃',
            title: l10n.t('errorGeneric'),
            body: l10n.t('errorGenericBody'),
          ),
          data: (list) {
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.t('memoriesTitle'),
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(color: AppColors.deepGreen),
                      ),
                    ),
                    IconButton.filled(
                      onPressed: _addMemory,
                      icon: const Icon(Icons.add_rounded),
                      tooltip: l10n.t('add'),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                if (list.isEmpty)
                  EmptyState(
                    emoji: '🖼️',
                    title: l10n.t('memoriesEmpty'),
                    body: l10n.t('memoriesEmptyBody'),
                    action: AppPrimaryButton(
                      label: l10n.t('add'),
                      icon: Icons.add_rounded,
                      onPressed: _addMemory,
                    ),
                  )
                else
                  for (final memory in list) _MemoryTile(memory: memory),
                const SizedBox(height: AppSpacing.xl),
              ],
            );
          },
        ),
      ),
    );
  }
}

Future<void> completeMemoryAdd({
  required WidgetRef ref,
  required String title,
  String? caption,
  MemoryCategory category = MemoryCategory.family,
}) async {
  final deps = ref.read(depsProvider);
  final patientId = ref.read(patientIdProvider);
  if (patientId == null) return;
  await deps.memoryRecordService.addMemory(
    patientId: patientId,
    kind: MemoryKind.text,
    title: title,
    caption: caption,
    category: category,
    createdBy: 'family',
  );
  ref.invalidate(memoriesProvider);
  ref.invalidate(gardenProvider);
  ref.invalidate(homeDataProvider);
}

class _MemoryTile extends ConsumerWidget {
  const _MemoryTile({required this.memory});

  final Memory memory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final kind = MemoryKind.fromString(memory.kind);
    final emoji = switch (kind) {
      MemoryKind.photo => '🖼️',
      MemoryKind.voice => '🎙️',
      MemoryKind.text => '💬',
      MemoryKind.sound => '🎵',
      MemoryKind.place => '🏔️',
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: SectionCard(
        onTap: () => showDialog<void>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            backgroundColor: AppColors.creamCard,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(emoji, style: const TextStyle(fontSize: 40)),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  memory.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (memory.caption != null && memory.caption!.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    memory.caption!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(l10n.t('close')),
              ),
              TextButton.icon(
                onPressed: () async {
                  await ref
                      .read(depsProvider)
                      .memoryRecordService
                      .deleteMemory(memory.id);
                  ref.invalidate(memoriesProvider);
                  ref.invalidate(gardenProvider);
                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                },
                icon: const Icon(Icons.delete_outline_rounded),
                label: Text(l10n.t('remove')),
              ),
            ],
          ),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.sageMist,
              child: Text('💬'),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    memory.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (memory.relation != null && memory.relation!.isNotEmpty)
                    Text(
                      memory.relation!,
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: AppColors.inkSoft),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
