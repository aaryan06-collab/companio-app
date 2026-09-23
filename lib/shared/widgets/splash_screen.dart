import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Small branded progress indicator reused during save steps and loading.
class SplashMini extends StatelessWidget {
  const SplashMini({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: SizedBox(
              width: 76,
              height: 76,
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(strokeWidth: 4),
          ),
        ],
      ),
    );
  }
}

/// Branded loading screen shown while the engine warms up.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 132,
              height: 132,
              decoration: BoxDecoration(
                color: AppColors.sageMist,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.gentleGreen, width: 4),
              ),
              child: Center(
                child: ClipOval(
                  child: SizedBox(
                    width: 132,
                    height: 132,
                    child: Image(
                      image: const AssetImage('assets/images/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.t('appName'),
              style: Theme.of(context).textTheme.headlineLarge
                  ?.copyWith(color: AppColors.deepGreen),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.t('tagline'),
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(color: AppColors.inkSoft),
            ),
            const SizedBox(height: AppSpacing.xl),
            const SizedBox(
              width: 44,
              height: 44,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                color: AppColors.terracotta,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
