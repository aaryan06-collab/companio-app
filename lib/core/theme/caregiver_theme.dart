import 'package:flutter/material.dart';

import 'app_spacing.dart';

/// Caregiver design tokens — a warm, editorial, botanical wellness palette.
///
/// These match the caregiver visual specification exactly:
/// cream background, deep forest green primary, muted sage secondary,
/// warm off-white cards, muted terracotta accent, dark charcoal text and
/// very subtle beige borders. Nothing clinical or enterprise-y.
abstract final class CareColors {
  // ── Warm garden care palette ────────────────────────────────────────────
  static const Color bg = Color(0xFFF7F3EA); // warm ivory / cream
  static const Color primary = Color(0xFF315C46); // deep forest green
  static const Color primaryDark = Color(0xFF1E3B2D);
  static const Color secondary = Color(0xFF879C87); // muted sage green
  static const Color secondarySoft = Color(0xFFDDE5DA);
  static const Color card = Color(0xFFF1EBDD); // warm off-white / beige
  static const Color cardRaised = Color(0xFFF8F4EA);
  static const Color accent = Color(0xFFC96F65); // muted terracotta / dusty red
  static const Color accentSoft = Color(0xFFF2DDD8);
  static const Color text = Color(0xFF20231F); // dark charcoal
  static const Color textSoft = Color(0xFF6A6F63);
  static const Color textFaint = Color(0xFF9A9C90);
  static const Color line = Color(0xFFE7E0D2); // subtle beige border
  static const Color lineStrong = Color(0xFFD9D0BD);
  static const Color success = Color(0xFF4C9B5A);
  static const Color successSoft = Color(0xFFDFF0DC);
  static const Color warning = Color(0xFFD99A2B);
  static const Color warningSoft = Color(0xFFFBEED3);
  static const Color rose = Color(0xFFC0392B);
  static const Color roseSoft = Color(0xFFF6DCD8);
  static const Color leaf = Color(0xFF6E8B5E); // botanical muted green
  static const Color leafSoft = Color(0xFFE3EBDD);
  static const Color gold = Color(0xFFC9A227); // gentle celebration accent
  static const Color goldSoft = Color(0xFFF5E9C4);
}

/// Caregiver Material 3 theme: soft, warm, garden-inspired.
///
/// Built on the patient theme so all shared component styling stays
/// consistent, then re-skinned with the caregiver palette and an elegant
/// serif for headings (sans-serif body).
abstract final class CareTheme {
  /// The serif family used for major editorial headings.
  static const String serif = 'NotoSerif';

  /// Fallback chain keeps every script readable when a heading is in an
  /// Indic/Bengali/Arabic locale: the serif only carries Latin, the bundled
  /// Noto Sans script faces carry the rest.
  static const List<String> _scriptFallback = [
    'NotoSansBengali',
    'NotoSansGujarati',
    'NotoSansGurmukhi',
    'NotoSansOriya',
    'NotoSansTamil',
    'NotoSansTelugu',
    'NotoSansKannada',
    'NotoSansMalayalam',
    'NotoNaskhArabic',
    'NotoSansOlChiki',
    'NotoSansMeeteiMayek',
    'NotoSansDevanagari',
    'Noto Sans',
    'Roboto',
  ];

  static ThemeData light([bool highContrast = false]) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: CareColors.primary,
        brightness: Brightness.light,
        primary: CareColors.primary,
        onPrimary: Colors.white,
        secondary: CareColors.secondary,
        onSecondary: Colors.white,
        surface: highContrast ? Colors.white : CareColors.card,
        onSurface: CareColors.text,
        error: CareColors.rose,
      ),
      scaffoldBackgroundColor: highContrast
          ? const Color(0xFFFDFBF6)
          : CareColors.bg,
    );

    final heading = TextStyle(
      color: CareColors.text,
      fontFamily: serif,
      fontFamilyFallback: _scriptFallback,
    );
    final body = TextStyle(
      color: CareColors.text,
      fontFamilyFallback: _scriptFallback,
    );

    final textTheme = base.textTheme.copyWith(
      displayLarge: heading.copyWith(
        fontSize: 40,
        height: 1.15,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: heading.copyWith(
        fontSize: 34,
        height: 1.2,
        fontWeight: FontWeight.w700,
      ),
      headlineLarge: heading.copyWith(
        fontSize: 30,
        height: 1.25,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: heading.copyWith(
        fontSize: 26,
        height: 1.3,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: heading.copyWith(
        fontSize: 22,
        height: 1.35,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: body.copyWith(
        fontSize: 20,
        height: 1.35,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: body.copyWith(
        fontSize: 18,
        height: 1.4,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: body.copyWith(
        fontSize: 16,
        height: 1.4,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: body.copyWith(
        fontSize: 18,
        height: 1.55,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: body.copyWith(
        fontSize: 16,
        height: 1.55,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: body.copyWith(
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: body.copyWith(
        fontSize: 18,
        height: 1.3,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
      labelMedium: body.copyWith(
        fontSize: 16,
        height: 1.3,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
      labelSmall: body.copyWith(
        fontSize: 14,
        height: 1.3,
        fontWeight: FontWeight.w600,
        color: CareColors.textSoft,
      ),
    );

    return base.copyWith(
      textTheme: textTheme,
      splashFactory: InkRipple.splashFactory,
      dividerTheme: DividerThemeData(
        color: highContrast ? CareColors.lineStrong : CareColors.line,
        thickness: 1,
        space: 1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall!.copyWith(
          color: CareColors.text,
        ),
        iconTheme: const IconThemeData(color: CareColors.primary, size: 28),
      ),
      cardTheme: CardThemeData(
        color: highContrast ? Colors.white : CareColors.card,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(
            color: highContrast ? CareColors.lineStrong : CareColors.line,
          ),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: CareColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(60),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.md),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: CareColors.card,
          foregroundColor: CareColors.primary,
          elevation: 0,
          side: const BorderSide(color: CareColors.line),
          minimumSize: const Size.fromHeight(60),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.md),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: CareColors.primary,
          side: const BorderSide(color: CareColors.lineStrong, width: 1.5),
          minimumSize: const Size.fromHeight(56),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.md),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: CareColors.primary,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: highContrast ? Colors.white : CareColors.cardRaised,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: const BorderSide(color: CareColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: const BorderSide(color: CareColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: const BorderSide(color: CareColors.primary, width: 2),
        ),
        labelStyle: textTheme.bodyMedium!.copyWith(color: CareColors.textSoft),
        hintStyle: textTheme.bodyMedium!.copyWith(color: CareColors.textFaint),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: CareColors.cardRaised,
        indicatorColor: CareColors.secondarySoft,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 76,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelMedium!.copyWith(
            color: selected ? CareColors.primary : CareColors.textFaint,
            fontWeight: FontWeight.w700,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? CareColors.primary : CareColors.textFaint,
            size: 28,
          );
        }),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: CareColors.text,
        contentTextStyle: textTheme.bodyLarge!.copyWith(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
        actionTextColor: CareColors.secondarySoft,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: highContrast ? Colors.white : CareColors.card,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
        titleTextStyle: textTheme.headlineSmall!.copyWith(
          color: CareColors.text,
        ),
        contentTextStyle: textTheme.bodyLarge,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return CareColors.primary;
          return CareColors.textFaint;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return CareColors.secondary.withValues(alpha: 0.5);
          }
          return CareColors.line;
        }),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: CareColors.primary,
        inactiveTrackColor: CareColors.secondarySoft,
        thumbColor: CareColors.accent,
        overlayColor: CareColors.accent.withValues(alpha: 0.15),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: CareColors.primary,
        linearTrackColor: CareColors.secondarySoft,
      ),
      chipTheme: base.chipTheme.copyWith(
        side: const BorderSide(color: CareColors.lineStrong),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        labelStyle: textTheme.labelMedium,
        backgroundColor: CareColors.cardRaised,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: CareColors.card,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadii.lg),
          ),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: CareColors.primary,
        unselectedLabelColor: CareColors.textSoft,
        indicatorColor: CareColors.primary,
        labelStyle: textTheme.labelLarge,
        unselectedLabelStyle: textTheme.labelMedium,
        dividerColor: Colors.transparent,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: CareColors.cardRaised,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
      ),
    );
  }
}
