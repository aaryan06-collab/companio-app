/// Small date helpers. All app dates are local-first (device local time),
/// formatted as `yyyy-MM-dd` keys so daily state is stable offline.
abstract final class LocalDates {
  static String key(DateTime dt) {
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '${dt.year}-$m-$d';
  }

  static String todayKey() => key(DateTime.now());

  static DateTime fromKey(String key) {
    final parts = key.split('-');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  /// Yesterday's key, used on days after missed activity to greet softly.
  static String yesterdayKey() =>
      key(DateTime.now().subtract(const Duration(days: 1)));

  /// True when [completedOn] happened today (device local).
  static bool isToday(DateTime completedOn) {
    final now = DateTime.now();
    return completedOn.year == now.year &&
        completedOn.month == now.month &&
        completedOn.day == now.day;
  }
}
