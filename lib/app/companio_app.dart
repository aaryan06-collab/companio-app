import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/localization/app_localizations.dart';
import '../core/localization/app_localizations_delegate.dart';
import '../core/localization/languages.dart';
import '../core/navigation/care_routes.dart';
import '../core/theme/app_theme.dart';
import '../features/assessment/screening_screen.dart';
import '../features/auth/auth_gate.dart';
import '../features/caregiver/caregiver_shell.dart';
import '../features/patient/patient_shell.dart';
import '../shared/widgets/splash_screen.dart';
import 'providers.dart';

/// Root widget: selects the top-level experience from the active session.
class CompanioApp extends ConsumerWidget {
  const CompanioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(appLanguageProvider);
    final highContrast = ref.watch(highContrastProvider);
    final textScale = ref.watch(patientTextScaleProvider).factor;
    return MaterialApp(
      title: 'Companio',
      debugShowCheckedModeBanner: false,
      theme: highContrast ? AppTheme.highContrast : AppTheme.light,
      builder: (context, child) {
        if (textScale != 1.0) {
          final mq = MediaQuery.of(context);
          final scaled = mq.textScaler.scale(textScale);
          return MediaQuery(
            data: mq.copyWith(textScaler: TextScaler.linear(scaled)),
            child: child!,
          );
        }
        return child!;
      },
      locale: Locale(globalLocaleFor(language.isEmpty ? 'en' : language)),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        AppLocalizationsDelegate(
          overrideLanguage: language.isEmpty ? 'en' : language,
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const RootRouter(),
      onGenerateRoute: (settings) {
        final name = settings.name;
        if (name != null && name.startsWith('/caregiver/')) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => CareRouteScope(
              child: CaregiverShell(initialSection: CareSection.fromPath(name)),
            ),
          );
        }
        return null;
      },
    );
  }
}

class RootRouter extends ConsumerWidget {
  const RootRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    return session.when(
      loading: () => const SplashScreen(),
      error: (error, stack) => _StartupError(
        onRetry: () => ref.read(sessionProvider.notifier).refresh(),
      ),
      data: (value) {
        if (value != null) {
          return value.isCaregiver ? const CaregiverShell() : _PatientGate();
        }
        return const AuthGate();
      },
    );
  }
}

/// Patient route: shows the memory check-up on first run, then the shell.
class _PatientGate extends ConsumerWidget {
  const _PatientGate();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pending = ref.watch(screeningPendingProvider).value ?? false;
    if (pending) return const ScreeningScreen();
    return const PatientShell();
  }
}

class _StartupError extends StatelessWidget {
  const _StartupError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🫖', style: TextStyle(fontSize: 56)),
              const SizedBox(height: 16),
              Text(
                l10n.t('errorGeneric'),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.t('errorGenericBody'),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(l10n.t('retry')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
