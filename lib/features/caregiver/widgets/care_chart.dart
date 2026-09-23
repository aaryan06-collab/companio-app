import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/caregiver_theme.dart';
import '../model/care_models.dart';

/// The integral weekly engagement bar chart (play minutes per day). Today's
/// bar is drawn in accent terracotta so the eye lands on “now”.
class CareWeekBarChart extends StatelessWidget {
  const CareWeekBarChart({
    super.key,
    required this.points,
    this.height = 168,
    required this.caption,
  });

  final List<CareDayPoint> points;
  final double height;

  /// Chart caption shown under the bars (e.g. "Total this week").
  final String caption;

  static const List<String> _weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final days = points.length == 7 ? points : _pad(points);
    final maxMinutes = days.fold<int>(
      0,
      (m, p) => p.playMinutes > m ? p.playMinutes : m,
    );
    final peak = maxMinutes == 0 ? 1 : maxMinutes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(days.length, (i) {
            final point = days[i];
            final barH = (height - 40) * (point.playMinutes.toDouble() / peak);
            final isToday = point.isToday;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (point.playMinutes > 0)
                      Text(
                        '${point.playMinutes}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: isToday
                              ? CareColors.text
                              : CareColors.textFaint,
                          fontWeight: isToday
                              ? FontWeight.w800
                              : FontWeight.w600,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Container(
                      height: barH < 4 && point.playMinutes > 0 ? 4 : barH,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isToday
                            ? CareColors.accent
                            : (point.playMinutes > 0
                                  ? CareColors.primary
                                  : CareColors.line),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _weekdays[i],
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isToday
                            ? CareColors.accent
                            : CareColors.textSoft,
                        fontWeight: isToday ? FontWeight.w800 : FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            const Icon(
              Icons.calendar_today_rounded,
              size: 14,
              color: CareColors.textFaint,
            ),
            const SizedBox(width: 6),
            Text(
              caption,
              style: theme.textTheme.bodySmall?.copyWith(
                color: CareColors.textSoft,
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<CareDayPoint> _pad(List<CareDayPoint> points) {
    final now = DateTime.now();
    final start = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(const Duration(days: 6));
    final byDay = {for (final p in points) _key(p.day): p};
    return List.generate(7, (i) {
      final day = start.add(Duration(days: i));
      return byDay[_key(day)] ?? CareDayPoint(day: day, isToday: day == now);
    });
  }

  static String _key(DateTime d) => '${d.year}-${d.month}-${d.day}';
}

/// Compact horizontal score bars for the per-game list (average vs best).
class CareScoreBars extends StatelessWidget {
  const CareScoreBars({
    super.key,
    required this.avgScore,
    required this.bestScore,
    required this.avgLabel,
    required this.bestLabel,
  });

  final double avgScore;
  final double bestScore;
  final String avgLabel;
  final String bestLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _row(context, avgLabel, avgScore, CareColors.primary),
        const SizedBox(height: 8),
        _row(context, bestLabel, bestScore, CareColors.gold),
      ],
    );
  }

  Widget _row(BuildContext context, String label, double value, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 92,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelSmall
                ?.copyWith(color: CareColors.textSoft),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.pill),
            child: Stack(
              children: [
                const SizedBox(
                  height: 10,
                  child: ColoredBox(color: CareColors.line),
                ),
                FractionallySizedBox(
                  widthFactor: value.clamp(0, 100) / 100,
                  child: SizedBox(height: 10, child: ColoredBox(color: color)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 40,
          child: Text(
            '${value.round()}',
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.labelMedium
                ?.copyWith(color: CareColors.text, fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
