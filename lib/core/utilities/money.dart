import 'package:intl/intl.dart';

/// Currency and number formatting tuned for Indian users.
abstract final class Money {
  static final NumberFormat _inr = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );

  static String rupees(int amount) => _inr.format(amount);

  /// Simple digit formatter (Indian grouping when locale supports it).
  static String number(int value) {
    final f = NumberFormat('###,##0', 'en_IN');
    return f.format(value);
  }

  static String minutes(int minutes) => '$minutes min';
}
