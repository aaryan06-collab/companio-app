import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// The Companio design system.
///
/// Large readable typography, high contrast, generous hit targets,
/// warm garden palette, calm motion.
abstract final class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.deepGreen,
        brightness: Brightness.light,
        primary: AppColors.deepGreen,
        onPrimary: Colors.white,
        secondary: AppColors.terracotta,
        onSecondary: Colors.white,
        surface: AppColors.creamCard,
        onSurface: AppColors.ink,
        error: AppColors.rose,
      ),
      scaffoldBackgroundColor: AppColors.cream,
    );

    final textTheme = base.textTheme.copyWith(
      displayLarge: _display.copyWith(
        fontSize: 40,
        height: 1.15,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: _display.copyWith(
        fontSize: 34,
        height: 1.2,
        fontWeight: FontWeight.w700,
      ),
      headlineLarge: _display.copyWith(
        fontSize: 30,
        height: 1.25,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: _display.copyWith(
        fontSize: 26,
        height: 1.3,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: _display.copyWith(
        fontSize: 22,
        height: 1.35,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: _body.copyWith(
        fontSize: 20,
        height: 1.35,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: _body.copyWith(
        fontSize: 18,
        height: 1.4,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: _body.copyWith(
        fontSize: 16,
        height: 1.4,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: _body.copyWith(
        fontSize: 18,
        height: 1.55,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: _body.copyWith(
        fontSize: 16,
        height: 1.55,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: _body.copyWith(
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: _body.copyWith(
        fontSize: 18,
        height: 1.3,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
      labelMedium: _body.copyWith(
        fontSize: 16,
        height: 1.3,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
      labelSmall: _body.copyWith(
        fontSize: 14,
        height: 1.3,
        fontWeight: FontWeight.w600,
      ),
    );

    return base.copyWith(
      textTheme: textTheme,
      splashFactory: InkRipple.splashFactory,
      pageTransitionsTheme: _pageTransitions,
      dividerTheme: const DividerThemeData(
        color: AppColors.line,
        thickness: 1,
        space: 1,
      ),
      chipTheme: base.chipTheme.copyWith(
        side: const BorderSide(color: AppColors.lineStrong),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        labelStyle: textTheme.labelLarge,
        backgroundColor: AppColors.creamCard,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.cream,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall!.copyWith(color: AppColors.ink),
        iconTheme: const IconThemeData(color: AppColors.deepGreen, size: 28),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.deepGreen,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
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
          backgroundColor: AppColors.creamCard,
          foregroundColor: AppColors.deepGreen,
          elevation: AppElevation.card,
          minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
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
          foregroundColor: AppColors.deepGreen,
          side: const BorderSide(color: AppColors.lineStrong, width: 1.5),
          minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
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
          foregroundColor: AppColors.deepGreen,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          textStyle: textTheme.labelMedium,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.creamCard,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: const BorderSide(color: AppColors.lineStrong),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: const BorderSide(color: AppColors.lineStrong),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: const BorderSide(color: AppColors.deepGreen, width: 2),
        ),
        labelStyle: textTheme.bodyMedium!.copyWith(color: AppColors.inkSoft),
      ),
      cardTheme: CardThemeData(
        color: AppColors.creamCard,
        elevation: AppElevation.card,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColors.bark.withValues(alpha: 0.06),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.ink,
        contentTextStyle: textTheme.bodyLarge!.copyWith(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
        actionTextColor: AppColors.warmYellow,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.creamCard,
        selectedItemColor: AppColors.deepGreen,
        unselectedItemColor: AppColors.inkFaint,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: textTheme.labelMedium!.copyWith(
          color: AppColors.deepGreen,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: textTheme.labelSmall!.copyWith(
          color: AppColors.inkFaint,
        ),
        showUnselectedLabels: true,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.creamCard,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
        titleTextStyle: textTheme.headlineSmall!.copyWith(color: AppColors.ink),
        contentTextStyle: textTheme.bodyLarge,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.deepGreen,
        inactiveTrackColor: AppColors.sage,
        thumbColor: AppColors.terracotta,
        overlayColor: AppColors.terracotta.withValues(alpha: 0.15),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.terracotta;
          }
          return AppColors.inkFaint;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.terracottaSoft;
          }
          return AppColors.line;
        }),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.deepGreen,
        linearTrackColor: AppColors.sage,
      ),
    );
  }

  /// High-contrast variant for the patient experience: near-black text,
  /// pure-white cards and darker accents for maximum legibility.
  static ThemeData get highContrast {
    final base = light;
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.deepGreenDark,
        onPrimary: Colors.white,
        secondary: AppColors.terracotta,
        onSurface: Colors.black,
        surface: Colors.white,
        error: const Color(0xFFB3261E),
      ),
      textTheme: base.textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),
      scaffoldBackgroundColor: const Color(0xFFFDFBF6),
      cardTheme: base.cardTheme.copyWith(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lineStrong,
        thickness: 1.5,
        space: 1,
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.md)),
          borderSide: BorderSide(color: AppColors.lineStrong, width: 2),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.md)),
          borderSide: BorderSide(color: AppColors.lineStrong, width: 2),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.md)),
          borderSide: BorderSide(color: AppColors.deepGreenDark, width: 2.5),
        ),
      ),
    );
  }

  static final PageTransitionsTheme _pageTransitions = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: const FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
      TargetPlatform.windows: const FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: const CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: const FadeForwardsPageTransitionsBuilder(),
    },
  );

  static const TextStyle _display = TextStyle(
    color: AppColors.ink,
    fontFamilyFallback: [
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
    ],
  );

  static const TextStyle _body = TextStyle(
    color: AppColors.ink,
    fontFamilyFallback: [
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
    ],
  );
}
