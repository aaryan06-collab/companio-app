import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/localization/l10n_keys.dart';
import '../../core/theme/app_colors.dart';
import '../sos/sos_screen.dart';
import 'activities_screen.dart';
import 'home_screen.dart';
import 'memories_screen.dart';
import 'patient_garden_screen.dart';
import 'settings_screen.dart';

/// Allows any descendant (e.g. Home quick actions) to switch tabs.
class PatientTabController extends InheritedNotifier<ValueNotifier<int>> {
  const PatientTabController({
    super.key,
    required ValueNotifier<int> super.notifier,
    required super.child,
  });

  static ValueNotifier<int>? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<PatientTabController>()
      ?.notifier;
}

/// Patient experience: gentle home, garden, activities, memories, settings.
class PatientShell extends ConsumerWidget {
  const PatientShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const _ShellBody();
  }
}

class _ShellBody extends ConsumerStatefulWidget {
  const _ShellBody();

  @override
  ConsumerState<_ShellBody> createState() => _ShellBodyState();
}

class _ShellBodyState extends ConsumerState<_ShellBody> {
  final ValueNotifier<int> _tab = ValueNotifier(0);

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final screens = [
      const HomeScreen(),
      const ActivitiesScreen(),
      const PatientGardenScreen(),
      const MemoriesScreen(),
      const SettingsScreen(),
    ];
    return PatientTabController(
      notifier: _tab,
      child: ValueListenableBuilder<int>(
        valueListenable: _tab,
        builder: (context, index, child) => Scaffold(
          body: IndexedStack(index: index, children: screens),
          bottomNavigationBar: NavigationBar(
            selectedIndex: index,
            backgroundColor: AppColors.creamCard,
            indicatorColor: AppColors.sageMist,
            onDestinationSelected: (i) => _tab.value = i,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home_rounded),
                label: l10n.t('navHome'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.games_outlined),
                selectedIcon: const Icon(Icons.games_rounded),
                label: l10n.t('navGames'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.local_florist_outlined),
                selectedIcon: const Icon(Icons.local_florist_rounded),
                label: l10n.t('navGarden'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.photo_album_outlined),
                selectedIcon: const Icon(Icons.photo_album_rounded),
                label: l10n.t('navMemories'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings_rounded),
                label: l10n.t('navProfile'),
              ),
            ],
          ),
          floatingActionButton: index == 0
              ? FloatingActionButton.extended(
                  heroTag: 'sos',
                  backgroundColor: AppColors.rose,
                  foregroundColor: Colors.white,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => const SosScreen()),
                  ),
                  icon: const Icon(Icons.support_agent_rounded),
                  label: Text(l10n.t(L10nKeys.sosShort)),
                )
              : null,
        ),
      ),
    );
  }
}
