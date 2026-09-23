/// Spacing scale (8pt grid) with generous, elderly-friendly gaps.
abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  static const double screenPadding = md;
  static const double cardPadding = lg;
  static const double buttonHeightLarge = 64;
  static const double buttonHeight = 56;
  static const double touchTarget = 48;
}

/// Shared radii.
abstract final class AppRadii {
  static const double sm = 10;
  static const double md = 16;
  static const double lg = 24;
  static const double pill = 999;
}

/// Elevation used across cards — soft and low.
abstract final class AppElevation {
  static const double card = 1;
}
