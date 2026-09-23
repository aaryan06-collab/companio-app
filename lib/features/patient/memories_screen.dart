import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

import '../../app/providers.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/local/app_database.dart';
import '../../data/models/enums.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_cards.dart';
import '../../shared/widgets/memory_media.dart';
import '../../shared/widgets/splash_screen.dart';

class MemoriesScreen extends ConsumerStatefulWidget {
  const MemoriesScreen({super.key});

  @override
  ConsumerState<MemoriesScreen> createState() => _MemoriesScreenState();
}

class _MemoryAttachment {
  const _MemoryAttachment({required this.type, required this.path});

  final String type;
  final String path;
}

class _MemoriesScreenState extends ConsumerState<MemoriesScreen> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;

  // ============================================================
  // STORAGE
  // ============================================================

  Future<Directory> _memoryMediaDirectory() async {
    final baseDirectory = await getApplicationDocumentsDirectory();
    final directory = Directory('${baseDirectory.path}/companio_memories');

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    return directory;
  }

  String _mimeType(String fileName, {required String fallback}) {
    final lower = fileName.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.gif')) return 'image/gif';
    if (lower.endsWith('.mov')) return 'video/quicktime';
    if (lower.endsWith('.webm')) return 'video/webm';
    if (lower.endsWith('.mkv')) return 'video/x-matroska';
    if (lower.endsWith('.mp4')) return 'video/mp4';
    return fallback;
  }

  Future<String> _storePickedFile(
    XFile file, {
    required String type,
    required String fallbackMime,
  }) async {
    if (kIsWeb) {
      final bytes = await file.readAsBytes();
      final mime = _mimeType(file.name, fallback: fallbackMime);
      return 'data:$mime;base64,${base64Encode(bytes)}';
    }

    final directory = await _memoryMediaDirectory();
    final extension = file.name.contains('.')
        ? '.${file.name.split('.').last}'
        : (type == 'video' ? '.mp4' : '.jpg');
    final savedFile = File(
      '${directory.path}/${type}_${DateTime.now().millisecondsSinceEpoch}$extension',
    );

    await File(file.path).copy(savedFile.path);
    return savedFile.path;
  }

  String _encodeMemoryBundle(List<_MemoryAttachment> attachments) {
    return jsonEncode({
      'companioMemory': 1,
      'attachments': [
        for (final attachment in attachments)
          {
            'type': attachment.type,
            'path': attachment.path,
          },
      ],
    });
  }

  Future<void> _saveComposedMemory({
    required String title,
    required String? caption,
    required MemoryCategory category,
    required List<_MemoryAttachment> attachments,
  }) async {
    final patientId = ref.read(patientIdProvider);

    if (patientId == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No patient profile found. Please sign in again.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final kind = attachments.any((item) => item.type == 'photo')
        ? MemoryKind.photo
        : attachments.any((item) => item.type == 'video')
            ? MemoryKind.photo
            : attachments.any((item) => item.type == 'voice')
                ? MemoryKind.voice
                : MemoryKind.text;

    await ref.read(depsProvider).memoryRecordService.addMemory(
          patientId: patientId,
          kind: kind,
          title: title,
          caption: caption,
          mediaPath: attachments.isEmpty
              ? null
              : _encodeMemoryBundle(attachments),
          category: category,
          createdBy: 'patient',
        );

    ref.invalidate(memoriesProvider);
    ref.invalidate(gardenProvider);
    ref.invalidate(homeDataProvider);
  }

  // ============================================================
  // ADD PHOTO / VIDEO TO COMPOSER
  // ============================================================

  Future<void> _pickPhoto(
    void Function(void Function()) setSheet,
    List<_MemoryAttachment> attachments,
  ) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) return;

    try {
      final path = await _storePickedFile(
        image,
        type: 'photo',
        fallbackMime: 'image/jpeg',
      );

      setSheet(() {
        attachments.add(_MemoryAttachment(type: 'photo', path: path));
      });
    } catch (e) {
      debugPrint('Photo selection error: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not add this photo. Please try again.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _pickVideo(
    void Function(void Function()) setSheet,
    List<_MemoryAttachment> attachments,
  ) async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video == null) return;

    try {
      final path = await _storePickedFile(
        video,
        type: 'video',
        fallbackMime: 'video/mp4',
      );

      setSheet(() {
        attachments.add(_MemoryAttachment(type: 'video', path: path));
      });
    } catch (e) {
      debugPrint('Video selection error: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not add this video. Please try again.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // ============================================================
  // VOICE RECORDER FOR COMPOSER
  // ============================================================

  Future<void> _toggleComposerVoice(
    void Function(void Function()) setSheet,
    List<_MemoryAttachment> attachments,
  ) async {
    if (_isRecording) {
      try {
        final path = await _audioRecorder.stop();

        setState(() => _isRecording = false);

        if (path == null || path.isEmpty) return;

        String mediaPath = path;

        if (kIsWeb && path.startsWith('blob:')) {
          final response = await http.get(Uri.parse(path));
          if (response.statusCode < 200 || response.statusCode >= 300) {
            throw Exception('Could not read the browser recording.');
          }
          mediaPath =
              'data:audio/webm;base64,${base64Encode(response.bodyBytes)}';
        }

        setSheet(() {
          attachments.add(
            _MemoryAttachment(type: 'voice', path: mediaPath),
          );
        });
      } catch (e) {
        debugPrint('Voice recording error: $e');
        setState(() => _isRecording = false);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not save the voice recording.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }

    final hasPermission = await _audioRecorder.hasPermission();
    if (!hasPermission) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Microphone permission is needed for a voice memory.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    try {
      if (kIsWeb) {
        await _audioRecorder.start(
          const RecordConfig(encoder: AudioEncoder.opus),
          path: '',
        );
      } else {
        final directory = await _memoryMediaDirectory();
        final path =
            '${directory.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

        await _audioRecorder.start(
          const RecordConfig(encoder: AudioEncoder.aacLc),
          path: path,
        );
      }

      setState(() => _isRecording = true);
    } catch (e) {
      debugPrint('Voice recording start error: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not start recording. Please try again.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // ============================================================
  // MEMORY COMPOSER
  // ============================================================

  Future<void> _addMemory() async {
    final title = TextEditingController();
    final caption = TextEditingController();
    final attachments = <_MemoryAttachment>[];
    MemoryCategory chosen = MemoryCategory.family;

    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.creamCard,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, setSheet) {
          return Padding(
            padding: EdgeInsets.only(
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.lg,
              bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Create a Memory',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(sheetContext).pop(false),
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),

                  Text(
                    'Add a title, some text, and as many photos, videos or voice notes as you want.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.inkSoft,
                        ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  TextField(
                    controller: title,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: 'Memory title',
                      hintText: 'e.g. My daughter\'s wedding',
                      prefixIcon: const Icon(Icons.title_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadii.sm),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  TextField(
                    controller: caption,
                    maxLines: 4,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: 'Write something about this memory',
                      hintText: 'What happened? Who was there? How did it feel?',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(bottom: 55),
                        child: Icon(Icons.edit_note_rounded),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadii.sm),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  Text(
                    'Add to this memory',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.deepGreen,
                        ),
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  Row(
                    children: [
                      Expanded(
                        child: _ComposerOption(
                          icon: Icons.photo_camera_rounded,
                          label: 'Photo',
                          onTap: () => _pickPhoto(setSheet, attachments),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _ComposerOption(
                          icon: Icons.videocam_rounded,
                          label: 'Video',
                          onTap: () => _pickVideo(setSheet, attachments),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _ComposerOption(
                          icon: _isRecording
                              ? Icons.stop_rounded
                              : Icons.mic_rounded,
                          label: _isRecording ? 'Stop' : 'Voice',
                          active: _isRecording,
                          onTap: () =>
                              _toggleComposerVoice(setSheet, attachments),
                        ),
                      ),
                    ],
                  ),

                  if (attachments.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      '${attachments.length} attachment${attachments.length == 1 ? '' : 's'} added',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.deepGreen,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: [
                        for (var i = 0; i < attachments.length; i++)
                          _AttachmentChip(
                            attachment: attachments[i],
                            onRemove: () {
                              setSheet(() => attachments.removeAt(i));
                            },
                          ),
                      ],
                    ),
                  ],

                  const SizedBox(height: AppSpacing.md),

                  Text(
                    'Category',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: [
                      for (final category in MemoryCategory.values)
                        ChoiceChip(
                          label: Text(_categoryLabel(category)),
                          selected: chosen == category,
                          onSelected: (_) =>
                              setSheet(() => chosen = category),
                        ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  AppPrimaryButton(
                    label: 'Save Memory',
                    icon: Icons.bookmark_add_rounded,
                    onPressed: () async {
                      if (title.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please give this memory a title.'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      }

                      if (_isRecording) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Stop the voice recording first.'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      }

                      Navigator.of(sheetContext).pop(true);

                      await _saveComposedMemory(
                        title: title.text.trim(),
                        caption: caption.text.trim().isEmpty
                            ? null
                            : caption.text.trim(),
                        category: chosen,
                        attachments: List<_MemoryAttachment>.from(attachments),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    title.dispose();
    caption.dispose();

    if (saved == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Memory saved 💙'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  String _categoryLabel(MemoryCategory category) => switch (category) {
        MemoryCategory.family => '👨‍👩‍👧‍👦 Family',
        MemoryCategory.childhood => '🧒 Childhood',
        MemoryCategory.places => '🏔️ Places',
        MemoryCategory.festivals => '🪔 Festivals',
        MemoryCategory.important => '⭐ Important',
      };

  @override
  void dispose() {
    if (_isRecording) {
      _audioRecorder.stop();
    }
    _audioRecorder.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Memories',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  color: AppColors.deepGreen,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Keep your favourite moments close.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.inkSoft),
                          ),
                        ],
                      ),
                    ),
                    IconButton.filled(
                      onPressed: _addMemory,
                      icon: const Icon(Icons.add_rounded),
                      tooltip: 'Add a memory',
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.lg),

                // One composer instead of separate Photo / Video / Voice / Write cards.
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: _addMemory,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.creamCard,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.sageMist),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                              color: AppColors.sageMist,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.add_a_photo_rounded,
                              color: AppColors.deepGreen,
                              size: 29,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create a Memory',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.deepGreen,
                                      ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Photo • Video • Voice • Text',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: AppColors.inkSoft),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.inkSoft,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                Text(
                  'Saved Memories',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.deepGreen,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),

                if (list.isEmpty)
                  EmptyState(
                    emoji: '🌸',
                    title: 'No memories yet',
                    body:
                        'Create one memory and add photos, videos, voice or text to it.',
                    action: AppPrimaryButton(
                      label: 'Create a Memory',
                      icon: Icons.add_rounded,
                      onPressed: _addMemory,
                    ),
                  )
                else
                  _MemoryGrid(memories: list),

                const SizedBox(height: AppSpacing.xl),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ComposerOption extends StatelessWidget {
  const _ComposerOption({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: active ? AppColors.sageMist : AppColors.cream,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.sageMist),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: AppColors.deepGreen,
                size: 27,
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.deepGreen,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AttachmentChip extends StatelessWidget {
  const _AttachmentChip({
    required this.attachment,
    required this.onRemove,
  });

  final _MemoryAttachment attachment;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final data = switch (attachment.type) {
      'photo' => (Icons.photo_rounded, 'Photo'),
      'video' => (Icons.videocam_rounded, 'Video'),
      'voice' => (Icons.mic_rounded, 'Voice'),
      _ => (Icons.attach_file_rounded, 'File'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.sageMist),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(data.$1, size: 18, color: AppColors.deepGreen),
          const SizedBox(width: 5),
          Text(
            data.$2,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(width: 3),
          InkWell(
            onTap: onRemove,
            child: const Icon(Icons.close_rounded, size: 17),
          ),
        ],
      ),
    );
  }
}

class _MemoryGrid extends StatelessWidget {
  const _MemoryGrid({required this.memories});

  final List<Memory> memories;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: memories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 0.86,
      ),
      itemBuilder: (context, index) => _MemoryCard(memory: memories[index]),
    );
  }
}

class _MemoryCard extends ConsumerWidget {
  const _MemoryCard({required this.memory});

  final Memory memory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attachments = _decodeBundle(memory.mediaPath);
    final hasPhoto = attachments.any((item) => item.type == 'photo');
    final hasVideo = attachments.any((item) => item.type == 'video');
    final hasVoice = attachments.any((item) => item.type == 'voice');
    final hasText = memory.caption != null && memory.caption!.trim().isNotEmpty;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () => _openMemory(context, ref),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.creamCard,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.sageMist),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Center(
                    child: Text(
                      memory.title,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.deepGreen,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 9, 10, 10),
                child: Row(
                  children: [
                    if (hasPhoto) _MiniTypeIcon(icon: Icons.photo_rounded),
                    if (hasVideo) _MiniTypeIcon(icon: Icons.videocam_rounded),
                    if (hasVoice) _MiniTypeIcon(icon: Icons.mic_rounded),
                    if (hasText) _MiniTypeIcon(icon: Icons.edit_rounded),
                    const Spacer(),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                      color: AppColors.inkSoft,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openMemory(BuildContext context, WidgetRef ref) async {
    final attachments = _decodeBundle(memory.mediaPath);
    final fallbackUrl = _mediaPlaybackUrl(ref, memory.mediaUrl) ?? '';
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.creamCard,
          title: Text(
            memory.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.deepGreen,
                  fontWeight: FontWeight.w700,
                ),
          ),
          content: SizedBox(
            width: 430,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (attachments.isEmpty &&
                      memory.caption != null &&
                      memory.caption!.isNotEmpty)
                    _TextMemoryContent(text: memory.caption!),

                  for (final attachment in attachments) ...[
                    _AttachmentViewer(
                      attachment: attachment,
                      fallbackUrl: fallbackUrl,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],

                  if (memory.caption != null &&
                      memory.caption!.trim().isNotEmpty &&
                      attachments.isNotEmpty)
                    _TextMemoryContent(text: memory.caption!),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Close'),
            ),
            TextButton.icon(
              onPressed: () async {
                await ref
                    .read(depsProvider)
                    .memoryRecordService
                    .deleteMemory(memory.id);
                ref.invalidate(memoriesProvider);
                ref.invalidate(gardenProvider);
                ref.invalidate(homeDataProvider);
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
              },
              icon: const Icon(Icons.delete_outline_rounded),
              label: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }
}

List<_MemoryAttachment> _decodeBundle(String? mediaPath) {
  if (mediaPath == null || mediaPath.isEmpty) return [];

  try {
    final decoded = jsonDecode(mediaPath);
    if (decoded is Map && decoded['companioMemory'] == 1) {
      final raw = decoded['attachments'];
      if (raw is List) {
        return raw
            .whereType<Map>()
            .map(
              (item) => _MemoryAttachment(
                type: item['type']?.toString() ?? 'file',
                path: item['path']?.toString() ?? '',
              ),
            )
            .where((item) => item.path.isNotEmpty)
            .toList();
      }
    }
  } catch (_) {}

  return [
    _MemoryAttachment(
      type: _classifyLegacyPath(mediaPath),
      path: mediaPath,
    ),
  ];
}

/// Builds an absolute playback URL for video/voice memories synced from the
/// caregiver device. The server media route accepts the JWT as a ``token``
/// query parameter (video/audio players cannot send authorisation headers),
/// and already-absolute URLs are passed through unchanged. Returns null when
/// the device is not linked to the server.
String? _mediaPlaybackUrl(WidgetRef ref, String? mediaUrl) {
  final url = mediaUrl;
  if (url == null || url.isEmpty) return null;
  if (url.startsWith('http://') || url.startsWith('https://')) return url;
  final client = ref.read(depsProvider).serverClient;
  final session = ref.read(serverSessionProvider);
  if (!client.enabled || session == null) return null;
  final base = client.baseUrl.endsWith('/')
      ? client.baseUrl.substring(0, client.baseUrl.length - 1)
      : client.baseUrl;
  final path = url.startsWith('/') ? url : '/$url';
  return Uri.parse('$base$path')
      .replace(queryParameters: {'token': session.token})
      .toString();
}

String _classifyLegacyPath(String path) {
  if (path.startsWith('data:image/')) return 'photo';
  if (path.startsWith('data:video/')) return 'video';
  if (path.startsWith('data:audio/')) return 'voice';
  if (kIsWeb) return 'file';

  final lower = path.toLowerCase();
  if (lower.endsWith('.jpg') ||
      lower.endsWith('.jpeg') ||
      lower.endsWith('.png') ||
      lower.endsWith('.webp') ||
      lower.endsWith('.gif') ||
      lower.endsWith('.heic') ||
      lower.endsWith('.heif')) {
    return 'photo';
  }
  if (lower.endsWith('.mp4') ||
      lower.endsWith('.mov') ||
      lower.endsWith('.webm') ||
      lower.endsWith('.mkv')) {
    return 'video';
  }
  if (lower.endsWith('.m4a') ||
      lower.endsWith('.mp3') ||
      lower.endsWith('.wav') ||
      lower.endsWith('.ogg')) {
    return 'voice';
  }
  return 'file';
}

class _MiniTypeIcon extends StatelessWidget {
  const _MiniTypeIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Icon(
        icon,
        size: 18,
        color: AppColors.deepGreen,
      ),
    );
  }
}

class _TextMemoryContent extends StatelessWidget {
  const _TextMemoryContent({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

class _AttachmentViewer extends StatelessWidget {
  const _AttachmentViewer({
    required this.attachment,
    this.fallbackUrl = '',
  });

  final _MemoryAttachment attachment;
  final String fallbackUrl;

  @override
  Widget build(BuildContext context) {
    switch (attachment.type) {
      case 'photo':
        return _ImageContent(
          path: attachment.path,
          fallbackUrl: fallbackUrl,
        );
      case 'video':
        return _VideoContent(path: attachment.path, fallbackUrl: fallbackUrl);
      case 'voice':
        return _VoicePlayer(path: attachment.path, fallbackUrl: fallbackUrl);
      default:
        return const SizedBox.shrink();
    }
  }
}

class _ImageContent extends StatelessWidget {
  const _ImageContent({
    required this.path,
    this.fallbackUrl = '',
  });

  final String path;
  final String fallbackUrl;

  @override
  Widget build(BuildContext context) {
    Widget image;

    if (path.startsWith('data:image/')) {
      try {
        final commaIndex = path.indexOf(',');
        final bytes = base64Decode(path.substring(commaIndex + 1));
        image = Image.memory(
          bytes,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 240,
        );
      } catch (_) {
        image = const _BrokenMedia(icon: Icons.photo_rounded);
      }
    } else if (fallbackUrl.isNotEmpty) {
      image = SizedBox(
        width: double.infinity,
        height: 240,
        child: MemoryMediaImage(
          mediaPath: path,
          mediaUrl: fallbackUrl,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(18),
        ),
      );
    } else if (!kIsWeb) {
      final file = File(path);
      image = file.existsSync()
          ? Image.file(
              file,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 240,
            )
          : const _BrokenMedia(icon: Icons.photo_rounded);
    } else {
      image = const _BrokenMedia(icon: Icons.photo_rounded);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: image,
    );
  }
}

class _VideoContent extends StatefulWidget {
  const _VideoContent({required this.path, this.fallbackUrl = ''});

  final String path;
  final String fallbackUrl;

  @override
  State<_VideoContent> createState() => _VideoContentState();
}

class _VideoContentState extends State<_VideoContent> {
  VideoPlayerController? _controller;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    try {
      VideoPlayerController controller;
      final serverUrl = widget.fallbackUrl;
      if (widget.path.startsWith('data:video/')) {
        controller = VideoPlayerController.networkUrl(
          Uri.parse(widget.path),
        );
      } else if (File(widget.path).existsSync()) {
        controller = VideoPlayerController.file(File(widget.path));
      } else if (serverUrl.isNotEmpty) {
        controller = VideoPlayerController.networkUrl(
          Uri.parse(serverUrl),
        );
      } else {
        throw StateError('no video source');
      }

      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }

      setState(() => _controller = controller);
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return const _BrokenMedia(icon: Icons.videocam_rounded);
    }

    final controller = _controller;
    if (controller == null) {
      return const SizedBox(
        height: 220,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio == 0
            ? 16 / 9
            : controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(controller),
            IconButton.filled(
              onPressed: () {
                setState(() {
                  controller.value.isPlaying
                      ? controller.pause()
                      : controller.play();
                });
              },
              icon: Icon(
                controller.value.isPlaying
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrokenMedia extends StatelessWidget {
  const _BrokenMedia({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.sageMist,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(
        icon,
        size: 46,
        color: AppColors.deepGreen,
      ),
    );
  }
}

/// Plays a voice memory. Prefers the local file, falls back to the server
/// ``mediaUrl`` (which carries the JWT as a ``token`` query), and shows a
/// broken-media card when no source is playable.
class _VoicePlayer extends StatefulWidget {
  const _VoicePlayer({required this.path, this.fallbackUrl = ''});

  final String path;
  final String fallbackUrl;

  @override
  State<_VoicePlayer> createState() => _VoicePlayerState();
}

class _VoicePlayerState extends State<_VoicePlayer> {
  final AudioPlayer _player = AudioPlayer();
  Object? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      if (widget.path.startsWith('data:audio/')) {
        setState(() {
          _loading = false;
          _error = true;
        });
        return;
      }
      final source = File(widget.path).existsSync()
          ? AudioSource.file(widget.path)
          : widget.fallbackUrl.isNotEmpty
              ? AudioSource.uri(Uri.parse(widget.fallbackUrl))
              : throw StateError('no voice source');
      await _player.setAudioSource(source);
      if (mounted) setState(() => _loading = false);
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = e;
        });
      }
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const SizedBox(
        height: 80,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return const _BrokenMedia(icon: Icons.mic_rounded);
    }

    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (context, state) {
        final playing = state.data?.playing ?? false;
        return Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.sageMist,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              StreamBuilder<Duration>(
                stream: _player.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final duration = _player.duration ?? Duration.zero;
                  final total = duration.inMilliseconds > 0
                      ? duration.inSeconds
                      : 0;
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          total > 0
                              ? '${_fmt(position)} / ${_fmt(duration)}'
                              : _fmt(position),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: total > 0 ? position.inSeconds / total : 0,
                          backgroundColor: AppColors.creamCard,
                          minHeight: 6,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              IconButton.filled(
                onPressed: playing ? _player.pause : _player.play,
                icon: Icon(
                  playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static String _fmt(Duration d) {
    final m = d.inMinutes.toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}
