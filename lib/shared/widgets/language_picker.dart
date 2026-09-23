import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/localization/l10n_keys.dart';
import '../../core/localization/languages.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Grouped language picker (primary, North-East India, major Indian languages)
/// shown with each language's native name. Shared by sign-up and settings.
class LanguagePicker extends StatelessWidget {
  const LanguagePicker({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final major = appLanguages
        .where(
          (l) =>
              !northEastCodes.contains(l.code) &&
              l.code != 'hi' &&
              l.code != 'en',
        )
        .toList(growable: false);
    final groups = <(String, List<AppLanguage>)>[
      (
        l10n.t(L10nKeys.langPrimary),
        appLanguages
            .where((l) => l.code == 'hi' || l.code == 'en')
            .toList(growable: false),
      ),
      (
        l10n.t(L10nKeys.langNorthEast),
        appLanguages
            .where((l) => northEastCodes.contains(l.code))
            .toList(growable: false),
      ),
      (l10n.t(L10nKeys.langMajor), major),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (title, langs) in groups)
          if (langs.isNotEmpty) ...[
            if (title != groups.first.$1) const SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium
                    ?.copyWith(color: AppColors.inkSoft),
              ),
            ),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final lang in langs)
                  ChoiceChip(
                    label: Text(lang.nativeName),
                    selected: selected == lang.code,
                    selectedColor: AppColors.deepGreen,
                    checkmarkColor: Colors.white,
                    labelStyle: Theme.of(context).textTheme.labelLarge
                        ?.copyWith(
                          color: selected == lang.code
                              ? Colors.white
                              : AppColors.ink,
                          fontWeight: FontWeight.w600,
                        ),
                    side: BorderSide(
                      color: selected == lang.code
                          ? AppColors.deepGreen
                          : AppColors.lineStrong,
                      width: 1.5,
                    ),
                    onSelected: (_) => onChanged(lang.code),
                  ),
              ],
            ),
          ],
      ],
    );
  }
}
