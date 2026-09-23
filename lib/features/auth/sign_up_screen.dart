import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/localization/l10n_keys.dart';
import '../../core/localization/languages.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'auth_language_sheet.dart';
import 'auth_scaffold.dart';

/// First-run account creation. A Companio profile is strictly single-per-
/// device, so the sign-up form only shows when no account exists yet.
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key, this.onBack});

  /// Goes back to the welcome page when shown inside the [AuthGate].
  final VoidCallback? onBack;

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pairingController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  static final _usernamePattern = RegExp(r'^[a-zA-Z0-9._-]+$');

  String _role = 'patient';
  String _region = 'assam';
  String _language = 'hi';
  bool _obscure = true;
  bool _busy = false;
  String? _error;

  static const _regions = [
    'assam',
    'meghalaya',
    'arunachal',
    'nagaland',
    'manipur',
    'mizoram',
    'tripura',
    'westbengal',
    'restind',
  ];

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _pairingController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final username = _usernameController.text.trim();
    final name = _nameController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    String? invalid;
    if (username.length < 3) {
      invalid = l10n.t(L10nKeys.authUsernameShort);
    } else if (!_usernamePattern.hasMatch(username)) {
      invalid = l10n.t(L10nKeys.authUsernameInvalid);
    } else if (name.isEmpty) {
      invalid = l10n.t(L10nKeys.authNameRequired);
    } else if (password.length < 6) {
      invalid = l10n.t(L10nKeys.authPasswordShort);
    } else if (password != confirm) {
      invalid = l10n.t(L10nKeys.authPasswordMismatch);
    }
    if (invalid != null) {
      setState(() => _error = invalid);
      return;
    }

    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final notifier = ref.read(sessionProvider.notifier);
      if (_role == 'caregiver') {
        await notifier.signUpCaregiver(
          username: username,
          password: password,
          name: name,
          pairingCode: _pairingController.text.trim(),
        );
      } else {
        final contacts = <(String, String, String)>[];
        final phone = _phoneController.text.trim();
        if (phone.isNotEmpty) {
          contacts.add((name.isEmpty ? 'Family' : 'Family', phone, ''));
        }
        await notifier.signUpPatient(
          username: username,
          password: password,
          name: name,
          region: _region,
          language: _language,
          voiceLanguage: voiceLocaleFor(_language),
          contacts: contacts.isEmpty ? null : contacts,
        );
      }
    } on AuthFailure catch (failure) {
      if (mounted) {
        setState(
          () => _error = AppLocalizations.of(context).t(failure.messageKey),
        );
      }
    } catch (_) {
      if (mounted) {
        setState(() => _error = AppLocalizations.of(context).t('errorGeneric'));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String>(appLanguageProvider, (prev, next) {
      if (next != _language) setState(() => _language = next);
    });
    final l10n = AppLocalizations.of(context);
    final isPatient = _role == 'patient';
    return AuthScaffold(
      title: l10n.t(L10nKeys.authSignUpTitle),
      subtitle: l10n.t(L10nKeys.authSignUpBody),
      onBack: widget.onBack,
      headerActions: [languageButton(context)],
      children: [
        AuthErrorBanner(message: _error),
        TextField(
          key: const ValueKey('signup-username'),
          controller: _usernameController,
          autocorrect: false,
          enableSuggestions: false,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: l10n.t(L10nKeys.authUsername),
            hintText: l10n.t(L10nKeys.authUsernameHint),
            prefixIcon: const Icon(Icons.person_outline_rounded),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.sm),
            ),
            filled: true,
            fillColor: AppColors.creamCard,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          key: const ValueKey('signup-name'),
          controller: _nameController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: l10n.t(L10nKeys.authDisplayName),
            prefixIcon: const Icon(Icons.badge_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.sm),
            ),
            filled: true,
            fillColor: AppColors.creamCard,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AuthSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.t(L10nKeys.authRoleQuestion),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              SegmentedButton<String>(
                segments: [
                  ButtonSegment(
                    value: 'patient',
                    icon: const Text('☀️'),
                    label: Text(l10n.t(L10nKeys.authRolePatient)),
                  ),
                  ButtonSegment(
                    value: 'caregiver',
                    icon: const Text('🤝'),
                    label: Text(l10n.t(L10nKeys.authRoleCaregiver)),
                  ),
                ],
                selected: {_role},
                onSelectionChanged: (s) => setState(() => _role = s.first),
                showSelectedIcon: false,
              ),
            ],
          ),
        ),
        if (!isPatient) ...[
          TextField(
            key: const ValueKey('signup-pairing'),
            controller: _pairingController,
            autocorrect: false,
            enableSuggestions: false,
            textCapitalization: TextCapitalization.characters,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: l10n.t(L10nKeys.careLinkCode),
              hintText: l10n.t(L10nKeys.careLinkCodeHint),
              helperText: l10n.t(L10nKeys.careLinkBody),
              prefixIcon: const Icon(Icons.tag_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.sm),
              ),
              filled: true,
              fillColor: AppColors.creamCard,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
        if (isPatient) ...[
          AuthSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.t(L10nKeys.onboardingRegionTitle),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: [
                    for (final region in _regions)
                      ChoiceChip(
                        label: Text(_regionLabel(region)),
                        selected: _region == region,
                        onSelected: (_) => setState(() {
                          _region = region;
                          _language = suggestedLanguageForRegion(region);
                        }),
                      ),
                  ],
                ),
              ],
            ),
          ),
          AuthSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.t(L10nKeys.onboardingEmergencyTitle),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  l10n.t(L10nKeys.onboardingEmergencyBody),
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: AppColors.inkSoft),
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  key: const ValueKey('signup-phone'),
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: l10n.t(L10nKeys.careContactPhone),
                    prefixIcon: const Icon(Icons.phone_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadii.sm),
                    ),
                    filled: true,
                    fillColor: AppColors.creamCard,
                  ),
                ),
              ],
            ),
          ),
        ],
        TextField(
          key: const ValueKey('signup-password'),
          controller: _passwordController,
          obscureText: _obscure,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: l10n.t(L10nKeys.authPassword),
            hintText: l10n.t(L10nKeys.authPasswordHint),
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            suffixIcon: IconButton(
              icon: Icon(
                _obscure
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
              ),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.sm),
            ),
            filled: true,
            fillColor: AppColors.creamCard,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          key: const ValueKey('signup-confirm'),
          controller: _confirmController,
          obscureText: _obscure,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _submit(),
          decoration: InputDecoration(
            labelText: l10n.t(L10nKeys.authConfirmPassword),
            prefixIcon: const Icon(Icons.lock_rounded),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.sm),
            ),
            filled: true,
            fillColor: AppColors.creamCard,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AuthSubmitButton(
          label: l10n.t(L10nKeys.authCreate),
          icon: Icons.check_rounded,
          busy: _busy,
          onPressed: _submit,
        ),
      ],
    );
  }

  static String _regionLabel(String region) => switch (region) {
    'assam' => 'Assam',
    'meghalaya' => 'Meghalaya',
    'arunachal' => 'Arunachal',
    'nagaland' => 'Nagaland',
    'manipur' => 'Manipur',
    'mizoram' => 'Mizoram',
    'tripura' => 'Tripura',
    'westbengal' => 'West Bengal',
    _ => 'Other India',
  };
}
