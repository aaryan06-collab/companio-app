import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Stores picked photos inside the app documents folder so a memory can load
/// them offline without the source gallery/picker image disappearing.
class MediaStore {
  const MediaStore._();

  static const String _dirName = 'memory_media';

  static Future<Directory> _originalsDir() async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory('${docs.path}${Platform.pathSeparator}$_dirName');
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  /// Copies [source] into the app's media folder with the given [name]
  /// (e.g. a memory id) and returns the absolute path to the copy.
  static Future<String> copyToMediaStore(File source, String name) async {
    final ext = source.path.split('.').last.toLowerCase();
    final target = File(
      '${(await _originalsDir()).path}${Platform.pathSeparator}'
      '$name.${ext.isEmpty ? 'jpg' : ext}',
    );
    if (await target.exists()) await target.delete();
    await source.copy(target.path);
    return target.path;
  }

  /// Deletes a stored media file if it exists. Swallows errors so deletion of
  /// an already-removed file is a no-op.
  static Future<void> delete(String path) async {
    if (path.isEmpty) return;
    try {
      final file = File(path);
      if (await file.exists()) await file.delete();
    } catch (_) {
      // Leftover files are harmless; cleanup is best-effort.
    }
  }
}