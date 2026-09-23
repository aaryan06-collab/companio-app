import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_cards.dart';

/// Placeholder screen shown while an async session operation is in flight.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    this.footer,
    this.onBack,
    this.headerActions = const [],
  });

  final String title;
  final String subtitle;
  final List<Widget> children;
  final Widget? footer;

  /// Extra widgets rendered between the spacer and the corner logo in the top
  /// header row (e.g. the language switcher button).
  final List<Widget> headerActions;

  /// When set a back arrow is shown at the top (used when the screen lives
  /// inside the [AuthGate] page switcher instead of being the root route).
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Row(
              children: [
                if (onBack != null)
                  IconButton(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: AppColors.deepGreen,
                  ),
                const Spacer(),
                ...headerActions,
                if (headerActions.isNotEmpty)
                  const SizedBox(width: AppSpacing.sm),
                ClipOval(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium
                  ?.copyWith(color: AppColors.deepGreen),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(color: AppColors.inkSoft),
            ),
            const SizedBox(height: AppSpacing.xl),
            ...children,
            if (footer != null) ...[
              const SizedBox(height: AppSpacing.xl),
              footer!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Small inline error banner for failed auth attempts.
class AuthErrorBanner extends StatelessWidget {
  const AuthErrorBanner({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    if (message == null || message!.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF1F0),
          borderRadius: BorderRadius.circular(AppRadii.sm),
          border: Border.all(color: AppColors.rose.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.rose,
              size: 22,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                message!,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: const Color(0xFF9A4941)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Wraps [child] in a card on the cream background.
class AuthSectionCard extends StatelessWidget {
  const AuthSectionCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: SectionCard(child: child),
    );
  }
}

/// Busy button used by both auth screens.
class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({
    super.key,
    required this.label,
    required this.icon,
    required this.busy,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool busy;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    if (busy) {
      return SizedBox(
        width: double.infinity,
        height: 60,
        child: FilledButton(
          onPressed: null,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.line,
            foregroundColor: AppColors.inkFaint,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.lg),
            ),
          ),
          child: const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColors.inkFaint,
            ),
          ),
        ),
      );
    }
    return AppPrimaryButton(label: label, icon: icon, onPressed: onPressed);
  }
}
