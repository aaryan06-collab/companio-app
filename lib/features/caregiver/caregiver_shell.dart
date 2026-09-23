import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/localization/l10n_keys.dart';
import '../../core/navigation/care_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/caregiver_theme.dart';
import 'providers/care_providers.dart';
import 'screens/care_achievements_screen.dart';
import 'screens/care_emergency_screen.dart';
import 'screens/care_games_screen.dart';
import 'screens/care_home_screen.dart';
import 'screens/care_memories_screen.dart';
import 'screens/care_notes_screen.dart';
import 'screens/care_profile_screen.dart';
import 'screens/care_progress_screen.dart';
import 'screens/care_settings_screen.dart';

/// Caregiver experience shell — the ten caregiver destinations in one
/// responsive frame. On phones a bottom navigation bar is used; from 900px
/// wide a sidebar navigation rail appears. The shell always re-applies the
/// caregiver visual language (the app-level theme is the patient's).
class CaregiverShell extends ConsumerStatefulWidget {
  const CaregiverShell({super.key, this.initialSection = CareSection.home});

  final CareSection initialSection;

  @override
  ConsumerState<CaregiverShell> createState() => _CaregiverShellState();
}

/// The ten caregiver sections, each mapping to a route path.
enum CareSection {
  home(CareRoutes.home, Icons.home_outlined, Icons.home_rounded, 'navHome'),
  progress(
    CareRoutes.progress,
    Icons.insights_outlined,
    Icons.insights_rounded,
    'careProgressTitle',
  ),
  games(
    CareRoutes.games,
    Icons.sports_esports_outlined,
    Icons.sports_esports_rounded,
    'careGamesTitle',
  ),
  notes(
    CareRoutes.notes,
    Icons.edit_note_outlined,
    Icons.edit_note_rounded,
    'careNotesTitle',
  ),
  memories(
    CareRoutes.memories,
    Icons.menu_book_outlined,
    Icons.menu_book_rounded,
    'careMemoriesTitle',
  ),
  achievements(
    CareRoutes.achievements,
    Icons.emoji_events_outlined,
    Icons.emoji_events_rounded,
    'careAchieveTitle',
  ),
  profile(
    CareRoutes.profile,
    Icons.person_outline_rounded,
    Icons.person_rounded,
    'careProfileTitle',
  ),
  settings(
    CareRoutes.settings,
    Icons.tune_outlined,
    Icons.tune_rounded,
    'careSettingsTitle',
  ),
  emergency(
    CareRoutes.emergency,
    Icons.emergency_rounded,
    Icons.emergency_rounded,
    'careEmergencyTitle',
  );

  const CareSection(this.path, this.icon, this.selectedIcon, this.labelKey);

  final String path;
  final IconData icon;
  final IconData selectedIcon;
  final String labelKey;

  static CareSection fromPath(String path) => CareSection.values.firstWhere(
    (s) => s.path == path,
    orElse: () => CareSection.home,
  );
}

/// Six most-used sections for the compact bottom bar; the remainder live in
/// the "More" sheet on phones.
const _mobileDestinations = [
  CareSection.home,
  CareSection.progress,
  CareSection.games,
  CareSection.notes,
  CareSection.memories,
];

class _CaregiverShellState extends ConsumerState<CaregiverShell> {
  late CareSection _section = widget.initialSection;

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(careSettingsProvider);
    final theme = CareTheme.light(settings.highContrast);

    return Theme(
      data: theme,
      child: Builder(
        builder: (context) {
          final width = MediaQuery.sizeOf(context).width;
          final isDesktop = width >= 900;
          return Scaffold(
            body: SafeArea(
              child: isDesktop
                  ? Row(
                      children: [
                        _Rail(
                          selected: _section,
                          onSelect: (s) => setState(() => _section = s),
                        ),
                        const VerticalDivider(width: 1),
                        Expanded(child: _Body(section: _section)),
                      ],
                    )
                  : Stack(
                      children: [
                        Positioned.fill(child: _Body(section: _section)),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: _BottomBar(
                            selected: _section,
                            onSelect: (s) => setState(() => _section = s),
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.section});

  final CareSection section;

  @override
  Widget build(BuildContext context) {
    return switch (section) {
      CareSection.home => const CareHomeScreen(),
      CareSection.progress => const CareProgressScreen(),
      CareSection.games => const CareGamesScreen(),
      CareSection.notes => const CareNotesScreen(),
      CareSection.memories => const CareMemoriesScreen(),
      CareSection.achievements => const CareAchievementsScreen(),
      CareSection.profile => const CareProfileScreen(),
      CareSection.settings => const CareSettingsScreen(),
      CareSection.emergency => const CareEmergencyScreen(),
    };
  }
}

class _Rail extends StatelessWidget {
  const _Rail({required this.selected, required this.onSelect});

  final CareSection selected;
  final ValueChanged<CareSection> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return NavigationRail(
      selectedIndex: selected.index,
      onDestinationSelected: (i) => onSelect(CareSection.values[i]),
      extended: true,
      backgroundColor: CareColors.bg,
      indicatorColor: CareColors.secondarySoft,
      selectedIconTheme: const IconThemeData(color: CareColors.primary),
      unselectedIconTheme: const IconThemeData(color: CareColors.textSoft),
      groupAlignment: -0.7,
      destinations: [
        for (final s in CareSection.values)
          NavigationRailDestination(
            icon: Icon(s.icon),
            selectedIcon: Icon(s.selectedIcon),
            label: Text(l10n.t(s.labelKey)),
          ),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.selected, required this.onSelect});

  final CareSection selected;
  final ValueChanged<CareSection> onSelect;

  @override
  Widget build(BuildContext context) {
    final moreSection = _mobileDestinations.contains(selected)
        ? null
        : selected;
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: CareColors.card,
        borderRadius: BorderRadius.circular(AppSpacing.xl),
        border: Border.all(color: CareColors.line),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: _BottomNavContents(
        selected: selected,
        onSelect: onSelect,
        moreSection: moreSection,
      ),
    );
  }
}

class _BottomNavContents extends StatelessWidget {
  const _BottomNavContents({
    required this.selected,
    required this.onSelect,
    required this.moreSection,
  });

  final CareSection selected;
  final ValueChanged<CareSection> onSelect;
  final CareSection? moreSection;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < _mobileDestinations.length; i++)
          _navItem(
            context,
            _mobileDestinations[i],
            selected == _mobileDestinations[i],
            () => onSelect(_mobileDestinations[i]),
          ),
        _navItem(
          context,
          null,
          moreSection != null,
          () => _openMore(context, onSelect),
          isMore: true,
        ),
      ],
    );
  }

  Widget _navItem(
    BuildContext context,
    CareSection? section,
    bool active,
    VoidCallback onTap, {
    bool isMore = false,
  }) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final label = isMore
        ? l10n.t(L10nKeys.careNavMore)
        : l10n.t(section!.labelKey);
    final icon = isMore
        ? const Icon(Icons.more_horiz_rounded)
        : Icon(active ? section!.selectedIcon : section!.icon);
    final width = MediaQuery.sizeOf(context).width / 6;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          height: 62,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconTheme.merge(
                data: IconThemeData(
                  color: active ? CareColors.primary : CareColors.textSoft,
                  size: 24,
                ),
                child: icon,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: active ? CareColors.primary : CareColors.textSoft,
                  fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openMore(BuildContext context, ValueChanged<CareSection> onSelect) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: CareColors.bg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.md,
            horizontal: AppSpacing.lg,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Text(
                l10n.t(L10nKeys.careNavMore),
                style: Theme.of(sheetContext).textTheme.headlineSmall,
              ),
            ),
            for (final s in CareSection.values)
              if (!_mobileDestinations.contains(s))
                ListTile(
                  leading: Icon(s.selectedIcon, color: CareColors.primary),
                  title: Text(
                    l10n.t(s.labelKey),
                    style: Theme.of(sheetContext).textTheme.titleMedium,
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: CareColors.textFaint,
                  ),
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    onSelect(s);
                  },
                ),
          ],
        ),
      ),
    );
  }
}
