import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/l10n_keys.dart';
import '../../../core/navigation/care_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/caregiver_theme.dart';
import '../../../data/models/enums.dart';
import '../model/care_models.dart';
import '../providers/care_providers.dart';
import '../widgets/care_ui.dart';
import 'care_add_note_screen.dart';

const Map<NoteKind, String> kNoteKindEmoji = {
  NoteKind.general: '📝',
  NoteKind.mood: '💭',
  NoteKind.activities: '🌿',
  NoteKind.health: '🩺',
};

String noteKindLabelKey(NoteKind kind) => switch (kind) {
  NoteKind.general => L10nKeys.careNoteKindGeneral,
  NoteKind.mood => L10nKeys.careNoteKindMood,
  NoteKind.activities => L10nKeys.careNoteKindActivities,
  NoteKind.health => L10nKeys.careNoteKindHealth,
};

/// Daily caregiver observation notes for the current subject.
class CareNotesScreen extends ConsumerStatefulWidget {
  const CareNotesScreen({super.key});

  @override
  ConsumerState<CareNotesScreen> createState() => _CareNotesScreenState();
}

class _CareNotesScreenState extends ConsumerState<CareNotesScreen> {
  NoteKind? _filter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final async = ref.watch(careNotesProvider);
    final notes = async.value ?? const <CareDailyNote>[];
    final filtered =
        notes.where((n) => _filter == null || n.kind == _filter).toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.t(L10nKeys.careNotesTitle),
                          style: theme.textTheme.displayMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.t(L10nKeys.careNotesSubtitle),
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: CareColors.textSoft,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _chip(l10n.t(L10nKeys.careNoteFilterAll), null),
                    for (final kind in NoteKind.values)
                      _chip(l10n.t(noteKindLabelKey(kind)), kind),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              if (async.isLoading && notes.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (filtered.isEmpty)
                CareEmptyState(
                  emoji: '📖',
                  title: l10n.t(L10nKeys.careNotesEmptyTitle),
                  body: l10n.t(L10nKeys.careNotesEmptyBody),
                  actionLabel: l10n.t(L10nKeys.careAddNote),
                  onAction: () => _openAdd(context),
                )
              else
                for (var i = 0; i < filtered.length; i++) ...[
                  _NoteCard(
                    note: filtered[i],
                    onDelete: () => _confirmDelete(context, filtered[i]),
                  ),
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
              label: Text(l10n.t(L10nKeys.careAddNote)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, NoteKind? kind) {
    final selected = _filter == kind;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => setState(() => _filter = kind),
        selectedColor: CareColors.primary,
        labelStyle: Theme.of(context).textTheme.labelMedium
            ?.copyWith(color: selected ? Colors.white : CareColors.text),
      ),
    );
  }

  void _openAdd(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CareRouteScope(child: CareAddNoteScreen()),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, CareDailyNote note) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.t(L10nKeys.careNoteDelete)),
        content: Text(note.body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.t('careCancel')),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.t(L10nKeys.careNoteDelete)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(careNotesProvider.notifier).remove(note.id);
    }
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.note, required this.onDelete});

  final CareDailyNote note;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final ts = note.createdAt;
    final dateLabel = '${ts.day} ${_monthAbbr(ts.month)}, ${ts.year}';

    return CareCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: CareColors.secondarySoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              kNoteKindEmoji[note.kind]!,
              style: const TextStyle(fontSize: 22),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CareTag(label: l10n.t(noteKindLabelKey(note.kind))),
                    const SizedBox(width: 8),
                    Text(
                      dateLabel,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: CareColors.textFaint,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(note.body, style: theme.textTheme.bodyLarge),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          IconButton(
            tooltip: l10n.t(L10nKeys.careNoteDelete),
            icon: const Icon(Icons.delete_outline_rounded),
            color: CareColors.textFaint,
            onPressed: onDelete,
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
