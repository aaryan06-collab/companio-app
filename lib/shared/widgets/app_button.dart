import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Primary full-width button with a warm, aged-ink feel and a big target.
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.filled = true,
    this.filledColor = AppColors.deepGreen,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool filled;
  final Color filledColor;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleLarge?.copyWith(
      color: filled ? Colors.white : filledColor,
      fontWeight: FontWeight.w700,
    );
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 26, color: filled ? Colors.white : filledColor),
          const SizedBox(width: AppSpacing.xs),
        ],
        Flexible(
          child: Text(label, textAlign: TextAlign.center, style: style),
        ),
      ],
    );
    if (filled) {
      return SizedBox(
        width: double.infinity,
        height: 60,
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: filledColor,
            foregroundColor: Colors.white,
            disabledBackgroundColor: AppColors.line,
            disabledForegroundColor: AppColors.inkFaint,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.lg),
            ),
          ),
          onPressed: onPressed,
          child: child,
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: filledColor, width: 2),
          foregroundColor: filledColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.lg),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

/// Emergency SOS trigger. Never conflated with fire/police/medical services;
/// it alerts family and caregivers only.
class EmergencyButton extends StatelessWidget {
  const EmergencyButton({
    super.key,
    required this.onPressed,
    this.enabled = true,
  });

  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 72,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.rose,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.lg),
          ),
        ),
        onPressed: enabled ? onPressed : null,
        iconAlignment: IconAlignment.end,
        icon: const Icon(Icons.support_agent_rounded, size: 30),
        label: Text(
          'SOS',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

/// Circular button that speaks the label aloud.
class SpeakButton extends StatelessWidget {
  const SpeakButton({super.key, required this.text, this.size = 52});

  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Voice prompts are opt-in at the profile/settings level.
      },
      borderRadius: BorderRadius.circular(size),
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: AppColors.skySoft,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.volume_up_rounded,
          size: size * 0.55,
          color: AppColors.deepGreenDark,
        ),
      ),
    );
  }
}
