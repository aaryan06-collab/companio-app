import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/caregiver_theme.dart';
import '../../features/caregiver/providers/care_providers.dart';

/// Named destinations within the caregiver experience.
abstract final class CareRoutes {
  static const home = '/caregiver/home';
  static const progress = '/caregiver/progress';
  static const games = '/caregiver/games';
  static const notes = '/caregiver/notes';
  static const memories = '/caregiver/memories';
  static const achievements = '/caregiver/achievements';
  static const profile = '/caregiver/profile';
  static const settings = '/caregiver/settings';
  static const emergency = '/caregiver/emergency';

  static const all = [
    home,
    progress,
    games,
    notes,
    memories,
    achievements,
    profile,
    settings,
    emergency,
  ];
}

/// Applies the caregiver visual language (theme + text scale) to any widget
/// pushed above the app shell — normally `Theme` in the shell wouldn't reach
/// routes created by `Navigator.push`/`pushNamed`.
class CareRouteScope extends StatelessWidget {
  const CareRouteScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final settings = ref.watch(careSettingsProvider);
        final theme = CareTheme.light(settings.highContrast);
        final scale = settings.textScaleFactor;
        Widget content = Theme(data: theme, child: child ?? this.child);
        if (scale != 1.0) {
          final mq = MediaQuery.of(context);
          final base = mq.textScaler.scale(16);
          content = MediaQuery(
            data: mq.copyWith(textScaler: TextScaler.linear(base * scale)),
            child: content,
          );
        }
        return content;
      },
      child: child,
    );
  }
}

/// Pushes a caregiver section route. `CompanioApp` maps these to a fresh
/// `CaregiverShell`, so deep links / OS actions open the flow reliably.
Future<void> openCareSection(BuildContext context, String path) {
  final entry = _sectionOf(path);
  return Navigator.of(context).pushNamed(path, arguments: entry);
}

/// The resolved section key for [path], or null when unknown.
String? _sectionOf(String path) {
  for (final p in CareRoutes.all) {
    if (p == path) return p;
  }
  return null;
}
