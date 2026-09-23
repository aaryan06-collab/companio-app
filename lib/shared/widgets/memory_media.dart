import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';

/// Renders a memory photo from whichever source is available. Prefers the
/// server ``mediaUrl`` (works across devices, authenticated with the JWT via
/// an ``Authorization`` header) and falls back to the local ``mediaPath``
/// file when it exists (fast, offline, same device). Shows a muted photo
/// placeholder when neither is usable.
class MemoryMediaImage extends ConsumerWidget {
  const MemoryMediaImage({
    super.key,
    this.mediaPath,
    this.mediaUrl,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  final String? mediaPath;
  final String? mediaUrl;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = mediaUrl;
    if (url != null && url.isNotEmpty) {
      final session = ref.watch(serverSessionProvider);
      final headers = session == null ? null : <String, String>{
        'Authorization': 'Bearer ${session.token}',
      };
      return _clip(
        Image.network(
          url,
          fit: fit,
          headers: headers,
          errorBuilder: (_, _, _) => const _PhotoPlaceholder(),
        ),
      );
    }
    final path = mediaPath;
    if (path != null && path.isNotEmpty) {
      return _clip(
        Image.file(
          File(path),
          fit: fit,
          errorBuilder: (_, _, _) => const _PhotoPlaceholder(),
        ),
      );
    }
    return _clip(const _PhotoPlaceholder());
  }

  Widget _clip(Widget child) {
    if (borderRadius == null) return child;
    return ClipRRect(borderRadius: borderRadius!, child: child);
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  const _PhotoPlaceholder();

  @override
  Widget build(BuildContext context) => Container(
    color: const Color(0xFFE9E4D9),
    alignment: Alignment.center,
    child: const Icon(
      Icons.photo_rounded,
      size: 32,
      color: Color(0xFF8A8575),
    ),
  );
}