import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/localization/l10n_keys.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/language_picker.dart';

/// Opens the bottom sheet that switches the current UI language live across
/// the auth screens (welcome, sign-up, login). Backed by [appLanguageProvider]
/// — the same live switch the Settings screen uses.
Future<void> showAuthLanguageSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.cream,
    isScrollControlled: true,
    builder: (_) => const _AuthLanguageSheet(),
  );
}

/// Globe button used in the top-right of the auth screens.
Widget languageButton(BuildContext context) {
  return IconButton(
    icon: const Icon(Icons.translate_rounded),
    color: AppColors.deepGreen,
    tooltip: AppLocalizations.of(context).t(L10nKeys.langChoose),
    onPressed: () => showAuthLanguageSheet(context),
  );
}

class _AuthLanguageSheet extends ConsumerWidget {
  const _AuthLanguageSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final current = ref.watch(appLanguageProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.t(L10nKeys.langChoose),
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(color: AppColors.deepGreen),
            ),
            const SizedBox(height: AppSpacing.md),
            Flexible(
              child: SingleChildScrollView(
                child: LanguagePicker(
                  selected: current,
                  onChanged: (code) {
                    ref.read(appLanguageProvider.notifier).set(code);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
