import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/localization/l10n_keys.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utilities/greeting.dart';
import '../../core/utilities/routine_done_store.dart';
import '../../data/local/app_database.dart';
import '../../data/models/enums.dart';
import '../../domain/services/cognitive_screen_service.dart';
import '../../domain/services/garden_service.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_cards.dart';
import '../../shared/widgets/splash_screen.dart';
import 'activity_runner_screen.dart';
import 'patient_shell.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final Set<String> _completedRoutines = <String>{};

  @override
  void initState() {
    super.initState();
    _loadCompletedRoutines();
  }

  Future<void> _loadCompletedRoutines() async {
    final stored = await RoutineDoneStore.load();
    if (!mounted) return;
    setState(() => _completedRoutines.addAll(stored));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final home = ref.watch(homeDataProvider);
    final pending = ref.watch(pendingSyncCountProvider).value ?? 0;
    final remindersAsync = ref.watch(remindersProvider);
    final reminders = remindersAsync.value ?? const <Reminder>[];

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: home.when(
          loading: () => const SplashMini(),
          error: (e, _) => EmptyState(
            emoji: '🍃',
            title: l10n.t('errorGeneric'),
            body: l10n.t('errorGenericBody'),
          ),
          data: (data) => RefreshIndicator(
            color: AppColors.deepGreen,
            backgroundColor: AppColors.creamCard,
            onRefresh: () async {
              ref.invalidate(homeDataProvider);
              ref.invalidate(gardenProvider);
              ref.invalidate(remindersProvider);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                120,
              ),
              children: [
                OfflineBanner(pending: pending),
                const SizedBox(height: AppSpacing.sm),
                _GreetingHero(
                  name: data.profile.displayName,
                  onSettings: () => PatientTabController.of(context)?.value = 4,
                ),
                const SizedBox(height: AppSpacing.lg),
                if (remindersAsync.hasError) ...[
                  SectionCard(
                    color: AppColors.roseSoft,
                    borderColor: AppColors.terracotta,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          color: AppColors.terracotta,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            l10n.t(L10nKeys.errorGenericBody),
                            style: const TextStyle(color: AppColors.ink),
                          ),
                        ),
                        TextButton(
                          onPressed: () => ref.invalidate(remindersProvider),
                          child: Text(l10n.t(L10nKeys.retry)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
                _RoutineCheckCard(
                  reminders: reminders,
                  completed: _completedRoutines,
                  onToggle: (id) {
                    setState(() {
                      if (!_completedRoutines.add(id)) {
                        _completedRoutines.remove(id);
                      }
                    });
                    RoutineDoneStore.save(_completedRoutines);
                  },
                  onAdd: () => _addRoutine(context),
                  onDelete: (reminder) => _deleteRoutine(reminder),
                ),
                const SizedBox(height: AppSpacing.xl),
                _SectionHeading(
                  title: l10n.t('homeWhatNeed'),
                  icon: Icons.auto_awesome_rounded,
                ),
                const SizedBox(height: AppSpacing.sm),
                _LetsPlayCard(
                  onPlay: () => PatientTabController.of(context)?.value = 1,
                ),
                const SizedBox(height: AppSpacing.md),
                if (data.todayActivity != null && data.todaysCompletions == 0)
                  _TodayActivityCard(
                    onStart: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => ActivityRunnerScreen(
                            activity: data.todayActivity!,
                          ),
                        ),
                      );
                      ref.invalidate(homeDataProvider);
                    },
                  )
                else
                  _QuickMenu(),
                const SizedBox(height: AppSpacing.md),
                _MysteryCard(
                  unlocked: data.mystery?.unlocked ?? false,
                  remaining: data.mystery?.remaining ?? 0,
                  completions: data.mystery?.completions ?? 0,
                  memory: data.memoryOfDay,
                ),
                const SizedBox(height: AppSpacing.md),
                _ScreeningStatusCard(),
                const SizedBox(height: AppSpacing.md),
                _GardenPreviewCard(data: data),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addRoutine(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final patientId = ref.read(patientIdProvider);
    if (patientId == null) return;

    final titleController = TextEditingController();
    var selectedTime = TimeOfDay.now();
    var kind = 'routine';

    final added = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.creamCard,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 42,
                          height: 5,
                          decoration: BoxDecoration(
                            color: AppColors.lineStrong,
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        l10n.t(L10nKeys.routineAddTitle),
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: AppColors.deepGreenDark,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.t(L10nKeys.routineAddBody),
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: AppColors.inkSoft),
                      ),
                      const SizedBox(height: 18),
                      TextField(
                        controller: titleController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: l10n.t(L10nKeys.routineNameLabel),
                          hintText: l10n.t(L10nKeys.routineNameHint),
                          filled: true,
                          fillColor: AppColors.cream,
                          prefixIcon: const Icon(Icons.edit_note_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: selectedTime,
                          );
                          if (picked != null) {
                            setSheetState(() => selectedTime = picked);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.cream,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                color: AppColors.deepGreen,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  l10n.t(L10nKeys.timeLabel),
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                              Text(
                                selectedTime.format(context),
                                style: const TextStyle(
                                  color: AppColors.deepGreen,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: [
                          _RoutineTypeChip(
                            label: l10n.t(L10nKeys.routineKind),
                            icon: Icons.check_circle_outline_rounded,
                            selected: kind == 'routine',
                            onTap: () => setSheetState(() => kind = 'routine'),
                          ),
                          _RoutineTypeChip(
                            label: l10n.t(L10nKeys.medicineKind),
                            icon: Icons.medication_outlined,
                            selected: kind == 'medicine',
                            onTap: () => setSheetState(() => kind = 'medicine'),
                          ),
                          _RoutineTypeChip(
                            label: l10n.t(L10nKeys.waterKind),
                            icon: Icons.water_drop_outlined,
                            selected: kind == 'water',
                            onTap: () => setSheetState(() => kind = 'water'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: AppPrimaryButton(
                          label: l10n.t(L10nKeys.addRoutine),
                          icon: Icons.add_rounded,
                          onPressed: () async {
                            final title = titleController.text.trim();
                            if (title.isEmpty) return;
                            await ref
                                .read(depsProvider)
                                .reminderRepository
                                .addReminder(
                                  id: 'reminder.${DateTime.now().microsecondsSinceEpoch}',
                                  patientId: patientId,
                                  title: title,
                                  hour: selectedTime.hour,
                                  minute: selectedTime.minute,
                                  kind: kind,
                                );
                            if (sheetContext.mounted) {
                              Navigator.of(sheetContext).pop(true);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    titleController.dispose();
    if (added == true) {
      ref.invalidate(remindersProvider);
    }
  }

  Future<void> _deleteRoutine(Reminder reminder) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.creamCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(l10n.t(L10nKeys.deleteRoutineTitle)),
        content: Text(
          l10n.t(L10nKeys.deleteRoutineBody, {'title': reminder.title}),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.t(L10nKeys.cancel)),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.terracotta,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.t(L10nKeys.deleteAction)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await ref.read(depsProvider).reminderRepository.deleteReminder(reminder.id);
    setState(() => _completedRoutines.remove(reminder.id));
    RoutineDoneStore.save(_completedRoutines);
    ref.invalidate(remindersProvider);
  }
}

class _GreetingHero extends StatelessWidget {
  const _GreetingHero({required this.name, this.onSettings});

  final String name;
  final VoidCallback? onSettings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final greeting = l10n.t(Greeting.now());
    final date = MaterialLocalizations.of(context)
        .formatMediumDate(DateTime.now());

    return Container(
      padding: const EdgeInsets.fromLTRB(22, 20, 16, 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.sageMist, AppColors.gentleGreen],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color(0x193F684C),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .58),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        date,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.deepGreenDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  '$greeting,',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.deepGreenDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$name 🌿',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.deepGreenDark,
                    fontWeight: FontWeight.w900,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.t(L10nKeys.homeRoutineSubtitle),
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: AppColors.inkSoft),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  color: AppColors.creamCard,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: .7),
                    width: 3,
                  ),
                ),
                child: const Center(
                  child: Text('🌸', style: TextStyle(fontSize: 32)),
                ),
              ),
              const SizedBox(height: 8),
              if (onSettings != null)
                Material(
                  color: Colors.white.withValues(alpha: .58),
                  shape: const CircleBorder(),
                  child: IconButton(
                    onPressed: onSettings,
                    tooltip: l10n.t(L10nKeys.settings),
                    icon: const Icon(Icons.settings_outlined),
                    color: AppColors.deepGreenDark,
                    iconSize: 22,
                    constraints: const BoxConstraints.tightFor(
                      width: 42,
                      height: 42,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoutineCheckCard extends StatelessWidget {
  const _RoutineCheckCard({
    required this.reminders,
    required this.completed,
    required this.onToggle,
    required this.onAdd,
    required this.onDelete,
  });

  final List<Reminder> reminders;
  final Set<String> completed;
  final ValueChanged<String> onToggle;
  final VoidCallback onAdd;
  final ValueChanged<Reminder> onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final sorted = [...reminders]
      ..sort((a, b) {
        final aMinutes = a.hour * 60 + a.minute;
        final bMinutes = b.hour * 60 + b.minute;
        return aMinutes.compareTo(bMinutes);
      });

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 14, 14),
      decoration: BoxDecoration(
        color: AppColors.creamCard,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.line),
        boxShadow: const [
          BoxShadow(
            color: Color(0x123F684C),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.warmYellowSoft,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.checklist_rounded,
                  color: AppColors.bark,
                  size: 27,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.t(L10nKeys.routineCheckTitle),
                      style: const TextStyle(
                        color: AppColors.deepGreenDark,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.t(L10nKeys.routineCheckBody),
                      style: const TextStyle(
                        color: AppColors.inkSoft,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add_rounded, size: 20),
                label: Text(l10n.t(L10nKeys.add)),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.deepGreen,
                  textStyle: const TextStyle(fontWeight: FontWeight.w800),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (sorted.isEmpty)
            InkWell(
              onTap: onAdd,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: AppColors.sageMist.withValues(alpha: .55),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.add_circle_outline_rounded,
                      color: AppColors.deepGreen,
                      size: 30,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      l10n.t(L10nKeys.addFirstRoutine),
                      style: const TextStyle(
                        color: AppColors.deepGreen,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...sorted.map(
              (reminder) => _RoutineRow(
                reminder: reminder,
                isDone: completed.contains(reminder.id),
                onToggle: () => onToggle(reminder.id),
                onDelete: () => onDelete(reminder),
              ),
            ),
        ],
      ),
    );
  }
}

class _RoutineRow extends StatelessWidget {
  const _RoutineRow({
    required this.reminder,
    required this.isDone,
    required this.onToggle,
    required this.onDelete,
  });

  final Reminder reminder;
  final bool isDone;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final icon = switch (reminder.kind) {
      'medicine' => Icons.medication_outlined,
      'water' => Icons.water_drop_outlined,
      _ => Icons.check_circle_outline_rounded,
    };
    final time = TimeOfDay(
      hour: reminder.hour,
      minute: reminder.minute,
    ).format(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isDone ? AppColors.successSoft : AppColors.cream,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Checkbox(
              value: isDone,
              onChanged: (_) => onToggle(),
              activeColor: AppColors.deepGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isDone
                    ? Colors.white.withValues(alpha: .65)
                    : AppColors.sageMist,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icon, color: AppColors.deepGreen, size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminder.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.ink,
                      fontWeight: FontWeight.w700,
                      decoration: isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    time,
                    style: const TextStyle(
                      color: AppColors.inkSoft,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onDelete,
              tooltip: l10n.t(L10nKeys.deleteRoutineTooltip),
              icon: const Icon(Icons.delete_outline_rounded),
              color: AppColors.terracotta,
            ),
          ],
        ),
      ),
    );
  }
}

class _RoutineTypeChip extends StatelessWidget {
  const _RoutineTypeChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: selected,
      onSelected: (_) => onTap(),
      avatar: Icon(icon, size: 18),
      label: Text(label),
      selectedColor: AppColors.sageMist,
      backgroundColor: AppColors.cream,
      labelStyle: TextStyle(
        color: AppColors.deepGreenDark,
        fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
      ),
      side: BorderSide(color: selected ? AppColors.deepGreen : AppColors.line),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.terracotta, size: 22),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.deepGreenDark,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _LetsPlayCard extends StatelessWidget {
  const _LetsPlayCard({required this.onPlay});

  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.deepGreen, AppColors.deepGreenDark],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x293F684C),
            blurRadius: 18,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Center(
              child: Text('🎮', style: TextStyle(fontSize: 30)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.t('homeLetsPlayTitle'),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  l10n.t('homeLetsPlaySubtitle'),
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: Colors.white.withValues(alpha: .86)),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FilledButton.icon(
                    onPressed: onPlay,
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: Text(l10n.t('homePlayCta')),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.creamCard,
                      foregroundColor: AppColors.deepGreenDark,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScreeningStatusCard extends ConsumerWidget {
  const _ScreeningStatusCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final patientId = ref.watch(patientIdProvider);
    if (patientId == null) return const SizedBox.shrink();
    final latest = ref.watch(latestAssessmentProvider(patientId)).value;
    if (latest == null) return const SizedBox.shrink();

    if (latest.score < 0) {
      return SectionCard(
        color: AppColors.skySoft,
        child: Row(
          children: [
            const Text('🤗', style: TextStyle(fontSize: 34)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                l10n.t('screenSkipped'),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      );
    }

    final band = screeningBandFor(latest.score);
    final resultTitle = l10n.t(latest.statusKey);
    return SectionCard(
      color: AppColors.sageMist,
      child: Row(
        children: [
          Text(
            latest.statusKey == 'screenSkipped' ? '🤗' : screeningEmoji(band),
            style: const TextStyle(fontSize: 34),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resultTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  '${latest.score}/${latest.maxScore}',
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: AppColors.inkSoft),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayActivityCard extends ConsumerWidget {
  const _TodayActivityCard({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final today = ref.watch(todayActivityProvider).value;
    if (today == null) {
      return const EmptyState(emoji: '🌱', title: '', body: '');
    }
    final content = ref
        .read(depsProvider)
        .activityRepository
        .contentOf(today.activity);
    return SectionCard(
      color: AppColors.sageMist,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '✨ ${l10n.t('homeTodayActivity')}',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(color: AppColors.terracotta),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${content.promptEmoji} ${l10n.t(today.activity.titleKey)}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${l10n.t(today.activity.subtitleKey ?? '')} · ',
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: AppColors.inkSoft),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.md),
          AppPrimaryButton(
            label: l10n.t('homeContinueActivity'),
            icon: Icons.play_arrow_rounded,
            onPressed: onStart,
          ),
        ],
      ),
    );
  }
}

class _QuickMenu extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: _QuickTile(
            emoji: '🎮',
            label: l10n.t('navGames'),
            onTap: () => PatientTabController.of(context)?.value = 1,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _QuickTile(
            emoji: '🌼',
            label: l10n.t('navGarden'),
            onTap: () => PatientTabController.of(context)?.value = 2,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _QuickTile(
            emoji: '📸',
            label: l10n.t('navMemories'),
            onTap: () => PatientTabController.of(context)?.value = 3,
          ),
        ),
      ],
    );
  }
}

class _GardenPreviewCard extends ConsumerWidget {
  const _GardenPreviewCard({required this.data});

  final HomeData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final emojis = data.elements
        .map(
          (e) => GardenPresentation.emojiFor(
            kind: GardenElementKind.fromString(e.kind),
            stage: e.stage,
          ).$1,
        )
        .take(8)
        .toList();
    return SectionCard(
      onTap: () => PatientTabController.of(context)?.value = 2,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.t('homeGardenPreview'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  emojis.isEmpty ? l10n.t('gardenEmpty') : emojis.join(' '),
                  style: const TextStyle(fontSize: 26),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${data.livePlants} ${l10n.t('gardenGrowth')} · '
                  '${data.points} ${l10n.t('unitsPoints')}',
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: AppColors.inkSoft),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            size: 36,
            color: AppColors.inkSoft,
          ),
        ],
      ),
    );
  }
}

class _MysteryCard extends StatelessWidget {
  const _MysteryCard({
    required this.unlocked,
    required this.remaining,
    required this.completions,
    required this.memory,
  });

  final bool unlocked;
  final int remaining;
  final int completions;
  final Memory? memory;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (unlocked && memory != null) {
      return SectionCard(
        child: Row(
          children: [
            const Text('🔓', style: TextStyle(fontSize: 40)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.t('homeMemoryUnlocked'),
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(color: AppColors.success),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    memory!.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    final progress = completions / 2.0;
    return SectionCard(
      color: AppColors.warmYellowSoft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${l10n.t('homeMemoryLocked')} 🎁',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.t('mysteryLockedBody', {'count': '$remaining'}),
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: AppColors.inkSoft),
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 10,
              backgroundColor: Colors.white,
              color: AppColors.terracotta,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({
    required this.emoji,
    required this.label,
    required this.onTap,
  });

  final String emoji;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.creamCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.line),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D3F684C),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.sageMist,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 25)),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
