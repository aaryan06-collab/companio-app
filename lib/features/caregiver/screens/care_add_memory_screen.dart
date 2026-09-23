import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/providers.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/l10n_keys.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/caregiver_theme.dart';
import '../../../data/local/media_store.dart';
import '../../../data/models/enums.dart';
import '../providers/care_providers.dart';
import '../widgets/care_ui.dart';
import 'care_memories_screen.dart';

/// Compose a caregiver memory draft and persist it locally.
class CareAddMemoryScreen extends ConsumerStatefulWidget {
  const CareAddMemoryScreen({super.key});

  @override
  ConsumerState<CareAddMemoryScreen> createState() =>
      _CareAddMemoryScreenState();
}

class _CareAddMemoryScreenState extends ConsumerState<CareAddMemoryScreen> {
  MemoryKind _kind = MemoryKind.text;
  MemoryCategory _category = MemoryCategory.family;
  final _title = TextEditingController();
  final _caption = TextEditingController();
  Set<MemoryPlacement> _placements = {MemoryPlacement.garden};
  File? _photo;
  bool _saving = false;

  @override
  void dispose() {
    _title.dispose();
    _caption.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final canSave = _title.text.trim().isNotEmpty && !_saving;

    return CarePage(
      title: l10n.t(L10nKeys.careMemoryAddTitle),
      onBack: () => Navigator.of(context).pop(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fieldLabel(l10n.t(L10nKeys.careMemoryTitleField), theme),
          TextField(
            controller: _title,
            onChanged: (_) => setState(() {}),
            decoration: _input(
              l10n.t(L10nKeys.careMemoryTitleField),
              Icons.edit_rounded,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _fieldLabel(l10n.t(L10nKeys.careMemoryCaption), theme),
          TextField(
            controller: _caption,
            minLines: 3,
            maxLines: 8,
            onChanged: (_) => setState(() {}),
            decoration: _input(l10n.t(L10nKeys.careMemoryCaption), null),
          ),
          const SizedBox(height: AppSpacing.lg),
          _fieldLabel(l10n.t(L10nKeys.careMemoryKindLabel), theme),
          Wrap(
            spacing: 8,
            children: [
              for (final kind in MemoryKind.values)
                ChoiceChip(
                  avatar: Text(kMemoryKindEmoji[kind]!),
                  label: Text(l10n.t(memoryKindLabelKey(kind))),
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
          _fieldLabel(l10n.t(L10nKeys.careMemoryCategory), theme),
          Wrap(
            spacing: 8,
            children: [
              for (final c in MemoryCategory.values)
                ChoiceChip(
                  label: Text(l10n.t(memoryCategoryLabelKey(c))),
                  selected: _category == c,
                  onSelected: (_) => setState(() => _category = c),
                  selectedColor: CareColors.primary,
                  labelStyle: theme.textTheme.labelMedium?.copyWith(
                    color: _category == c ? Colors.white : CareColors.text,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          if (_kind == MemoryKind.photo) ...[
            _fieldLabel(l10n.t(L10nKeys.careUploadPhoto), theme),
            if (_photo == null)
              OutlinedButton.icon(
                onPressed: _pickPhoto,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  side: const BorderSide(color: CareColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                icon: const Icon(Icons.add_a_photo_rounded),
                label: Text(
                  l10n.t(L10nKeys.careChoosePhoto),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: CareColors.primary,
                  ),
                ),
              )
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(_photo!, fit: BoxFit.cover),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Row(
                          children: [
                            _smallRound(Icons.edit_rounded, () => _pickPhoto(),
                                tooltip: l10n.t(L10nKeys.careReplacePhoto)),
                            const SizedBox(width: 8),
                            _smallRound(Icons.delete_rounded,
                                () => setState(() => _photo = null),
                                tooltip: l10n.t('remove')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: AppSpacing.lg),
          ],
          _fieldLabel(l10n.t(L10nKeys.careMemoryPlacementLabel), theme),
          Wrap(
            spacing: 8,
            children: [
              for (final p in MemoryPlacement.values)
                FilterChip(
                  label: Text(l10n.t(memoryPlacementLabelKey(p))),
                  selected: _placements.contains(p),
                  onSelected: (sel) => setState(() {
                    if (sel) {
                      _placements = {..._placements, p};
                    } else {
                      _placements.remove(p);
                    }
                  }),
                  selectedColor: CareColors.secondarySoft,
                  labelStyle: theme.textTheme.labelMedium?.copyWith(
                    color: CareColors.primary,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: canSave ? _save : null,
              icon: const Icon(Icons.check_rounded),
              label: Text(l10n.t(L10nKeys.careAddMemory)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(String text, ThemeData theme) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
    child: Text(text, style: theme.textTheme.titleMedium),
  );

  Widget _smallRound(IconData icon, VoidCallback onTap, {String? tooltip}) =>
      Material(
        color: Colors.black45,
        shape: const CircleBorder(),
        child: IconButton(
          onPressed: onTap,
          tooltip: tooltip,
          icon: Icon(icon, color: Colors.white, size: 20),
        ),
      );

  InputDecoration _input(String hint, IconData? icon) => InputDecoration(
    hintText: hint,
    prefixIcon: icon != null ? Icon(icon, color: CareColors.textFaint) : null,
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
      borderSide: const BorderSide(color: CareColors.primary, width: 2),
    ),
  );

  Future<void> _pickPhoto() async {
    final l10n = AppLocalizations.of(context);
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: CareColors.card,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppSpacing.sm),
            ListTile(
              leading: const Icon(Icons.photo_library_rounded),
              title: Text(l10n.t(L10nKeys.gallery)),
              onTap: () => Navigator.of(sheetContext).pop(ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: Text(l10n.t(L10nKeys.camera)),
              onTap: () => Navigator.of(sheetContext).pop(ImageSource.camera),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    );
    if (source == null) return;
    final picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 85,
    );
    if (picked == null || !mounted) return;
    setState(() => _photo = File(picked.path));
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final l10n = AppLocalizations.of(context);
    final deps = ref.read(depsProvider);
    final subject = await ref.read(careSubjectProvider.future);
    final memoryId = newMemoryId();

    String? mediaPath;
    if (_kind == MemoryKind.photo) {
      final photo = _photo;
      if (photo == null) {
        setState(() => _saving = false);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.t(L10nKeys.careChoosePhoto))),
        );
        return;
      }
      mediaPath = await MediaStore.copyToMediaStore(photo, memoryId);
    }

    await deps.memoryRepository.addMemory(
      id: memoryId,
      patientId: subject.id,
      kind: _kind,
      title: _title.text.trim(),
      caption: _caption.text.trim().isEmpty ? null : _caption.text.trim(),
      mediaPath: mediaPath,
      category: _category,
      createdBy: 'caregiver',
      placements: _placements.toList(),
    );

    // Sync the new memory to a linked patient on another device (the photo
    // file upload happens inside the sync engine, retrying while offline).
    final session = ref.read(serverSessionProvider);
    if (session != null && session.isCaregiver && session.hasPatient) {
      await deps.syncService.enqueueAndCommit(
        entityType: 'memory',
        entityId: memoryId,
        operation: SyncOperation.create,
        payload: {
          'patientId': subject.id,
          'kind': _kind.name,
          'title': _title.text.trim(),
          'caption': _caption.text.trim().isEmpty ? null : _caption.text.trim(),
          'mediaPath': mediaPath,
          'mediaUrl': null,
          'category': _category.name,
          'createdBy': 'caregiver',
        },
      );
    }

    ref.invalidate(careMemoriesProvider);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.t(L10nKeys.careMemorySaved))));
    Navigator.of(context).pop();
  }
}
