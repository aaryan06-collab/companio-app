import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/caregiver_theme.dart';
import '../model/care_models.dart';

/// Warm garden backdrop used by every caregiver screen.
class CareBackground extends StatelessWidget {
  const CareBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: CareColors.bg),
      child: child,
    );
  }
}

/// Rounded warm card; the spec's primary content surface.
class CareCard extends StatelessWidget {
  const CareCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.color,
    this.onTap,
    this.margin,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shape = theme.cardTheme.shape;
    final borderColor = shape is RoundedRectangleBorder
        ? shape.side.color
        : CareColors.line;
    final card = Card(
      color: color ?? theme.cardTheme.color,
      margin: margin ?? EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(color: borderColor),
      ),
      child: Padding(padding: padding, child: child),
    );
    if (onTap == null) return card;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: card,
    );
  }
}

/// Serif section heading with an optional trailing action.
class CareSectionHeader extends StatelessWidget {
  const CareSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
    this.subtitle,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: CareColors.text,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: CareColors.textSoft,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (actionLabel != null && onAction != null)
            TextButton(onPressed: onAction, child: Text(actionLabel!)),
        ],
      ),
    );
  }
}

/// A delicate ornamental divider with a centred label.
class CareBotanicalDivider extends StatelessWidget {
  const CareBotanicalDivider({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const Expanded(child: Divider()),
        if (label != null) ...[
          const SizedBox(width: AppSpacing.sm),
          Text(
            label!,
            style: theme.textTheme.labelSmall?.copyWith(
              color: CareColors.textFaint,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        const Expanded(child: Divider()),
      ],
    );
  }
}

/// A single large number + label block (used in 2×2 summary grids).
class CareStat extends StatelessWidget {
  const CareStat({
    super.key,
    required this.value,
    required this.label,
    this.iconEmoji,
    this.accent = CareColors.primary,
    this.valueStyle,
    this.inline = false,
  });

  final String value;
  final String label;
  final String? iconEmoji;
  final Color accent;
  final TextStyle? valueStyle;
  final bool inline;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final numberStyle =
        valueStyle ??
        theme.textTheme.headlineLarge?.copyWith(
          color: accent,
          fontWeight: FontWeight.w700,
        );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (iconEmoji != null) ...[
          Text(iconEmoji!, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 2),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(child: Text(value, style: numberStyle)),
            if (inline) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: CareColors.textSoft,
                ),
              ),
            ],
          ],
        ),
        if (!inline) ...[
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: CareColors.textSoft,
            ),
          ),
        ],
      ],
    );
  }
}

/// Friendly empty/placeholder state used across caregiver screens.
class CareEmptyState extends StatelessWidget {
  const CareEmptyState({
    super.key,
    required this.emoji,
    required this.title,
    required this.body,
    this.actionLabel,
    this.onAction,
  });

  final String emoji;
  final String title;
  final String body;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 52)),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              color: CareColors.text,
              fontFamily: CareTheme.serif,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: CareColors.textSoft,
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onAction,
              icon: const Icon(Icons.add_rounded),
              label: Text(actionLabel!),
            ),
          ],
        ],
      ),
    );
  }
}

/// Small pill label for categories / stats provenance.
class CareTag extends StatelessWidget {
  const CareTag({
    super.key,
    required this.label,
    this.color = CareColors.secondarySoft,
    this.foreground = CareColors.primary,
    this.icon,
  });

  final String label;
  final Color color;
  final Color foreground;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: foreground),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// The patient's avatar (emoji in a warm circle) with optional demo badge.
class CareAvatar extends StatelessWidget {
  const CareAvatar({
    super.key,
    required this.emoji,
    this.size = 52,
    this.badge,
    this.showPreviewTag = false,
  });

  final String emoji;
  final double size;
  final String? badge;
  final bool showPreviewTag;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: CareColors.secondarySoft,
            shape: BoxShape.circle,
            border: Border.all(color: CareColors.lineStrong, width: 1.5),
          ),
          child: Text(emoji, style: TextStyle(fontSize: size * 0.5)),
        ),
        if (showPreviewTag) ...[
          const SizedBox(height: 6),
          CareTag(label: badge ?? 'Preview', color: CareColors.goldSoft),
        ],
      ],
    );
  }
}

/// Segmented control for Week / Month / All ranges.
class CareRangeSelector extends StatelessWidget {
  const CareRangeSelector({
    super.key,
    required this.value,
    required this.onChanged,
    required this.weekLabel,
    required this.monthLabel,
    required this.allLabel,
  });

  final CareRange value;
  final ValueChanged<CareRange> onChanged;
  final String weekLabel;
  final String monthLabel;
  final String allLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final options = [
      (CareRange.week, weekLabel),
      (CareRange.month, monthLabel),
      (CareRange.all, allLabel),
    ];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: CareColors.secondarySoft,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Row(
        children: [
          for (final (range, label) in options)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onChanged(range),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.sm + 4,
                  ),
                  decoration: BoxDecoration(
                    color: value == range
                        ? CareColors.cardRaised
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppRadii.md - 4),
                    boxShadow: value == range
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 6,
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: value == range
                          ? CareColors.primary
                          : CareColors.textSoft,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Settings-style list row with a switch on the right.
class CareSwitchRow extends StatelessWidget {
  const CareSwitchRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.iconColor = CareColors.primary,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: CareColors.secondarySoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 26),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: CareColors.textSoft,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

/// Segmented preference toggle used on Settings.
class CareSegmentRow extends StatelessWidget {
  const CareSegmentRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.segments,
    required this.index,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final List<String> segments;
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: CareColors.textSoft,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 8,
            children: [
              for (var i = 0; i < segments.length; i++)
                ChoiceChip(
                  label: Text(segments[i]),
                  selected: i == index,
                  onSelected: (_) => onChanged(i),
                  selectedColor: CareColors.primary,
                  labelStyle: theme.textTheme.labelMedium?.copyWith(
                    color: i == index ? Colors.white : CareColors.text,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Number badge used on SOS cards / timers.
class CareNumberBadge extends StatelessWidget {
  const CareNumberBadge({
    super.key,
    required this.text,
    this.color = CareColors.rose,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

/// A simple horizontal progress bar with a rounded track.
class CareProgressBar extends StatelessWidget {
  const CareProgressBar({
    super.key,
    required this.progress,
    this.color = CareColors.primary,
    this.height = 10,
  });

  /// 0..1
  final double progress;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.pill),
      child: LinearProgressIndicator(
        value: progress.clamp(0, 1),
        minHeight: height,
        color: color,
        backgroundColor: CareColors.secondarySoft,
      ),
    );
  }
}

/// Primary screen scaffold for pushed caregiver pages (app bar + warm bg).
class CarePage extends StatelessWidget {
  const CarePage({
    super.key,
    required this.title,
    required this.child,
    this.actions,
    this.scrollable = true,
    this.onBack,
  });

  final String title;
  final Widget child;
  final List<Widget>? actions;
  final bool scrollable;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final body = scrollable
        ? SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              8,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            child: child,
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              8,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            child: child,
          );
    return CareBackground(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading: onBack != null
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: onBack,
                )
              : null,
          actions: actions,
        ),
        body: body,
      ),
    );
  }
}
