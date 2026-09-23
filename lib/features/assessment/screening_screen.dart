import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/local/app_database.dart';
import '../../domain/services/cognitive_screen_service.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_cards.dart';

/// Caregiver-facing memory check-up: 15 short questions about the patient,
/// shown right after a patient signs up. Completing it drops the patient onto
/// their dashboard (there is no re-take from Home).
class ScreeningScreen extends ConsumerStatefulWidget {
  const ScreeningScreen({super.key});

  @override
  ConsumerState<ScreeningScreen> createState() => _ScreeningScreenState();
}

class _ScreeningScreenState extends ConsumerState<ScreeningScreen> {
  final Map<String, String> _answers = {};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        title: Text(l10n.t('screenTitle')),
      ),
      body: _QuestionsView(
        answers: _answers,
        onAnswer: (key, value) => setState(() => _answers[key] = value),
        onFinish: _save,
      ),
    );
  }

  Future<void> _save() async {
    final patientId = ref.read(patientIdProvider);
    if (patientId == null) return;
    final now = DateTime.now();
    final total = screeningTotalFor(_answers);
    final band = screeningBandFor(total);
    final assessment = CognitiveAssessment(
      id: 'assessment.$patientId.${now.millisecondsSinceEpoch}',
      patientId: patientId,
      score: total,
      maxScore: screeningMaxScore,
      answersJson: jsonEncode(_answers),
      statusKey: screeningStatusKey(band),
      createdAt: now,
    );
    await ref.read(depsProvider).assessmentRepository.save(assessment);
    ref.invalidate(screeningPendingProvider);
    ref.invalidate(latestAssessmentProvider(patientId));
  }
}

class _QuestionsView extends StatelessWidget {
  const _QuestionsView({
    required this.answers,
    required this.onAnswer,
    required this.onFinish,
  });

  final Map<String, String> answers;
  final void Function(String key, String value) onAnswer;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final answered = answers.length;
    final total = screeningQuestionKeys.length;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                SectionCard(
                  color: AppColors.sageMist,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🧠',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        l10n.t('screenIntro'),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: answered / total,
                          minHeight: 10,
                          backgroundColor: AppColors.sage,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.deepGreen,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        '$answered/$total',
                        style: Theme.of(context).textTheme.labelLarge
                            ?.copyWith(color: AppColors.inkSoft),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                for (var i = 0; i < total; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: _QuestionCard(
                      number: i + 1,
                      text: l10n.t(screeningQuestionKeys[i]),
                      selected: answers[screeningQuestionKeys[i]],
                      onSelect: (value) =>
                          onAnswer(screeningQuestionKeys[i], value),
                    ),
                  ),
              ],
            ),
          ),
          if (answered == total)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: AppPrimaryButton(
                label: l10n.t('screenFinish'),
                icon: Icons.check_circle_outline,
                onPressed: onFinish,
              ),
            ),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.number,
    required this.text,
    required this.selected,
    required this.onSelect,
  });

  final int number;
  final String text;
  final String? selected;
  final ValueChanged<String> onSelect;

  static const _options = [
    ('rarely', 'screenRarely'),
    ('sometimes', 'screenSometimes'),
    ('frequently', 'screenFrequently'),
    ('veryfrequently', 'screenVeryFrequently'),
    ('notsure', 'screenNotSure'),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      borderColor: AppColors.lineStrong,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: AppColors.warmYellowSoft,
                child: Text(
                  '$number',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.deepGreen,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(color: AppColors.ink),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          for (final row in [_options.sublist(0, 3), _options.sublist(3)])
            Padding(
              padding: EdgeInsets.only(
                bottom: row.length == 3 ? AppSpacing.sm : 0,
              ),
              child: Row(
                children: [
                  for (final (value, labelKey) in row)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: value == row.last.$1 ? 0 : AppSpacing.sm,
                        ),
                        child: _AnswerPill(
                          label: l10n.t(labelKey),
                          isSelected: selected == value,
                          onTap: () => onSelect(value),
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

class _AnswerPill extends StatelessWidget {
  const _AnswerPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = isSelected ? AppColors.deepGreenDark : AppColors.inkSoft;
    return Material(
      color: isSelected ? AppColors.sageMist : AppColors.cream,
      borderRadius: BorderRadius.circular(AppRadii.pill),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.pill),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.pill),
            border: Border.all(
              color: isSelected ? AppColors.deepGreen : AppColors.lineStrong,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall
                ?.copyWith(color: foreground, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
