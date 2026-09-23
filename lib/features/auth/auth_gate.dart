import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/localization/l10n_keys.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/app_button.dart';
import 'auth_language_sheet.dart';
import 'login_screen.dart';
import 'sign_up_screen.dart';

enum _AuthPage { welcome, login, signup }

/// Managed single widget shown whenever there is no active session.
///
/// Swaps between the welcome landing page (with both Sign-up and Login
/// entries), the login screen and the sign-up screen in place — no routes are
/// pushed, so a successful sign-in/sign-up simply lets the session provider
/// reroute the root to the dashboard without leaving a stale screen behind.
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  _AuthPage _page = _AuthPage.welcome;

  void _go(_AuthPage page) => setState(() => _page = page);

  @override
  Widget build(BuildContext context) {
    return switch (_page) {
      _AuthPage.welcome => _WelcomePage(
        onSignUp: () => _go(_AuthPage.signup),
        onLogin: () => _go(_AuthPage.login),
      ),
      _AuthPage.login => LoginScreen(onBack: () => _go(_AuthPage.welcome)),
      _AuthPage.signup => SignUpScreen(onBack: () => _go(_AuthPage.welcome)),
    };
  }
}

class _WelcomePage extends StatelessWidget {
  const _WelcomePage({required this.onSignUp, required this.onLogin});

  final VoidCallback onSignUp;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: SizedBox(
                      width: 96,
                      height: 96,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    l10n.t(L10nKeys.appName),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColors.deepGreen,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.t(L10nKeys.onboardingWelcomeTitle),
                    style: Theme.of(context).textTheme.bodyLarge
                        ?.copyWith(color: AppColors.inkSoft),
                  ),
                  const Spacer(),
                  AppPrimaryButton(
                    label: l10n.t(L10nKeys.authCreate),
                    icon: Icons.person_add_rounded,
                    onPressed: onSignUp,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppPrimaryButton(
                    label: l10n.t(L10nKeys.authSignIn),
                    icon: Icons.login_rounded,
                    filled: false,
                    onPressed: onLogin,
                  ),
                ],
              ),
            ),
            Positioned(top: 0, right: 0, child: languageButton(context)),
          ],
        ),
      ),
    );
  }
}
