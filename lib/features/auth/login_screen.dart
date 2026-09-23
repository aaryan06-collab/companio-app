import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/localization/l10n_keys.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'auth_language_sheet.dart';
import 'auth_scaffold.dart';

/// Unlock screen for an existing device account.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key, this.onBack});

  /// Goes back to the welcome page when shown inside the [AuthGate].
  final VoidCallback? onBack;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      setState(() => _error = l10n.t(L10nKeys.authBadCredentials));
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref
          .read(sessionProvider.notifier)
          .unlock(username: username, password: password);
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
    final l10n = AppLocalizations.of(context);
    return AuthScaffold(
      title: l10n.t(L10nKeys.authLoginTitle),
      subtitle: l10n.t(L10nKeys.authLoginBody),
      onBack: widget.onBack,
      headerActions: [languageButton(context)],
      children: [
        AuthErrorBanner(message: _error),
        TextField(
          key: const ValueKey('login-username'),
          controller: _usernameController,
          autocorrect: false,
          enableSuggestions: false,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: l10n.t(L10nKeys.authUsername),
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
          key: const ValueKey('login-password'),
          controller: _passwordController,
          obscureText: _obscure,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _submit(),
          decoration: InputDecoration(
            labelText: l10n.t(L10nKeys.authPassword),
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
        const SizedBox(height: AppSpacing.lg),
        AuthSubmitButton(
          label: l10n.t(L10nKeys.authSignIn),
          icon: Icons.login_rounded,
          busy: _busy,
          onPressed: _submit,
        ),
      ],
    );
  }
}
