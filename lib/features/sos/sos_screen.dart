import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/providers.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/local/app_database.dart';
import '../../data/models/enums.dart';
import '../../domain/services/sos_escalator.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_cards.dart';

/// Family / caregiver alert flow. Exclusively contacts people the patient
/// trusts — never framed as an emergency-services call.
class SosScreen extends ConsumerStatefulWidget {
  const SosScreen({super.key, this.onAddContact});

  /// Called when the user wants to add a family contact (usually pops the
  /// screen and opens Settings).
  final VoidCallback? onAddContact;

  @override
  ConsumerState<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends ConsumerState<SosScreen> {
  Timer? _ticker;
  int _secondsLeft = 0;
  bool _justEscalated = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final state = ref.read(sosControllerProvider);
      if (state.isActive) _startCountdown(state);
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  int get _escalationSeconds {
    final minutes =
        ref.watch(sessionProvider).value?.prefs?.escalationMinutes ?? 3;
    return minutes <= 0 ? 3 : minutes * 60;
  }

  void _startCountdown(SosViewState state) {
    _ticker?.cancel();
    setState(() => _secondsLeft = _escalationSeconds);
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!mounted) return;
      if (_secondsLeft <= 0) {
        final next = await ref.read(sosControllerProvider.notifier).escalate();
        setState(() {
          _justEscalated = true;
          _secondsLeft = _escalationSeconds;
        });
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) setState(() => _justEscalated = false);
        });
        _startCountdown(next);
      } else {
        setState(() => _secondsLeft -= 1);
      }
    });
  }

  Future<void> _confirmLaunch() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.creamCard,
        title: Text(l10n.t('sosNotSilent')),
        content: Text(l10n.t('sosHoldBody')),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.t('no')),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.rose),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.t('yes')),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      final state = await ref.read(sosControllerProvider.notifier).launch();
      if (mounted && state.isActive) _startCountdown(state);
    }
  }

  Future<void> _callContact(EmergencyContact contact) async {
    final l10n = AppLocalizations.of(context);
    final uri = Uri(scheme: 'tel', path: contact.phone);
    var opened = false;
    try {
      opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
    final next = await ref
        .read(sosControllerProvider.notifier)
        .reportAttempt(
          contactId: contact.id,
          method: AttemptMethod.call,
          delivered: opened,
        );
    if (mounted) {
      if (!opened) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.t('sosAlertNotDelivered'))));
      }
      _startCountdown(next);
    }
  }

  Future<void> _smsContact(EmergencyContact contact) async {
    final l10n = AppLocalizations.of(context);
    final uri = Uri(
      scheme: 'sms',
      path: contact.phone,
      queryParameters: {'body': l10n.t('sosContactFamily')},
    );
    var opened = false;
    try {
      opened = await launchUrl(uri);
    } catch (_) {}
    final next = await ref
        .read(sosControllerProvider.notifier)
        .reportAttempt(
          contactId: contact.id,
          method: AttemptMethod.sms,
          delivered: opened,
        );
    if (mounted) _startCountdown(next);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(sosControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.creamCard,
        title: Text(l10n.t('sosTitle')),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: _buildState(state, l10n),
        ),
      ),
    );
  }

  Widget _buildState(SosViewState state, AppLocalizations l10n) {
    if (state.isActive) return _buildActive(state, l10n);
    if (!state.hasContacts) return _buildNoContacts(l10n);
    return _buildIdle(l10n);
  }

  Widget _buildIdle(AppLocalizations l10n) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: AppSpacing.xl),
        Text('🫶', style: const TextStyle(fontSize: 88)),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.t('sosExplain'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.t('sosDisclaimer'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: AppColors.inkSoft),
        ),
        const SizedBox(height: AppSpacing.xl),
        EmergencyButton(onPressed: _confirmLaunch),
      ],
    );
  }

  Widget _buildNoContacts(AppLocalizations l10n) {
    return EmptyState(
      emoji: '☎️',
      title: l10n.t('sosNoContacts'),
      body: l10n.t('sosNoContactsBody'),
      action: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppPrimaryButton(
            label: l10n.t('sosAddContact'),
            icon: Icons.book_rounded,
            onPressed:
                widget.onAddContact ??
                () {
                  Navigator.of(context).pop();
                },
          ),
        ],
      ),
    );
  }

  Widget _buildActive(SosViewState state, AppLocalizations l10n) {
    final contact = state.currentContact;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          state.isAcknowledged ? '💚' : '🔔',
          style: const TextStyle(fontSize: 84),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          state.isAcknowledged
              ? l10n.t('sosAcknowledged')
              : l10n.t('sosActiveTitle'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.t(state.statusKey),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge
              ?.copyWith(color: AppColors.inkSoft),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (!state.isAcknowledged && contact != null) ...[
          SectionCard(
            color: AppColors.roseSoft,
            child: Column(
              children: [
                Text(
                  '${l10n.t('sosContacting')} ${contact.name}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (contact.relation != null)
                  Text(
                    contact.relation!,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: AppColors.inkSoft),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.deepGreen,
                    minimumSize: const Size(0, 60),
                  ),
                  onPressed: () => _callContact(contact),
                  icon: const Icon(Icons.call_rounded),
                  label: Text('${l10n.t('yes')} ${_mmss(_secondsLeft)}'),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.sky,
                    minimumSize: const Size(0, 60),
                  ),
                  onPressed: () => _smsContact(contact),
                  icon: const Icon(Icons.sms_rounded),
                  label: Text(l10n.t('sosContactedPerson')),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (_justEscalated)
            Text(
              l10n.t('sosEscalating'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: AppColors.terracotta),
            ),
        ] else ...[
          SectionCard(
            color: AppColors.successSoft,
            child: Text(
              l10n.t('sosHelpOnWay'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(color: AppColors.success),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.xl),
        AppPrimaryButton(
          label: state.isAcknowledged
              ? '${l10n.t('sosDone')} ✓'
              : l10n.t('sosCancelAction'),
          filledColor: state.isAcknowledged
              ? AppColors.deepGreen
              : AppColors.terracotta,
          onPressed: () async {
            if (state.isAcknowledged) {
              await ref.read(sosControllerProvider.notifier).resolve();
            } else {
              await ref.read(sosControllerProvider.notifier).cancel();
            }
            _ticker?.cancel();
            if (mounted) {
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  String _mmss(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}
