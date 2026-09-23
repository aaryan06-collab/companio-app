import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/l10n_keys.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/caregiver_theme.dart';
import '../../../data/models/enums.dart';
import '../providers/care_providers.dart';
import '../widgets/care_ui.dart';
import 'care_notes_screen.dart';

/// Compose a caregiver observation note and persist it locally.
class CareAddNoteScreen extends ConsumerStatefulWidget {
  const CareAddNoteScreen({super.key});

  @override
  ConsumerState<CareAddNoteScreen> createState() => _CareAddNoteScreenState();
}

class _CareAddNoteScreenState extends ConsumerState<CareAddNoteScreen> {
  NoteKind _kind = NoteKind.general;
  final _body = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final canSave = _body.text.trim().isNotEmpty && !_saving;

    return CarePage(
      title: l10n.t(L10nKeys.careAddNote),
      onBack: () => Navigator.of(context).pop(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.t(L10nKeys.careNoteKindLabel),
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 8,
            children: [
              for (final kind in NoteKind.values)
                ChoiceChip(
                  avatar: Text(kNoteKindEmoji[kind]!),
                  label: Text(l10n.t(noteKindLabelKey(kind))),
                  selected: _kind == kind,
                  onSelected: (_) => setState(() => _kind = kind),
                  selectedColor: CareColors.primary,
                  labelStyle: theme.textTheme.labelMedium?.copyWith(
                    color: _kind == kind ? Colors.white : CareColors.text,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: _body,
            minLines: 6,
            maxLines: 12,
            maxLength: 2000,
            autofocus: true,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: l10n.t(L10nKeys.careNoteBodyHint),
              filled: true,
              fillColor: CareColors.card,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: CareColors.line),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: CareColors.line),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: CareColors.primary,
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: canSave ? _save : null,
              icon: const Icon(Icons.check_rounded),
              label: Text(l10n.t(L10nKeys.careAddNote)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    await ref
        .read(careNotesProvider.notifier)
        .add(kind: _kind, body: _body.text.trim());
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l10n.t(L10nKeys.careNoteSaved))));
    Navigator.of(context).pop();
  }
}
