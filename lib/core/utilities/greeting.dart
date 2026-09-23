import 'package:flutter/material.dart';

/// Time-of-day aware greeting for a friendly home screen.
abstract final class Greeting {
  static String forHour(int hour) {
    if (hour < 5) return 'goodNight';
    if (hour < 12) return 'goodMorning';
    if (hour < 17) return 'goodAfternoon';
    return 'goodEvening';
  }

  static String now() => forHour(DateTime.now().hour);

  static String withName(String key, String name, String emoji) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '$key $emoji';
    return '$key, $trimmed $emoji';
  }

  static BuildContext debugContext(BuildContext context) => context;
}
