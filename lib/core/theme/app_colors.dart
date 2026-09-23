import 'package:flutter/material.dart';

/// Warm, calm, garden-inspired palette for Companio.
///
/// Colors are intentional: deep green for primary actions, soft cream
/// background, terracotta/warm yellow as gentle accents. Nothing clinical.
abstract final class AppColors {
  // ── Warm-sage patient palette (calm, familiar, high-contrast) ───────────
  static const Color cream = Color(0xFFF4EFE5); // warm cream background
  static const Color creamCard = Color(0xFFFBF8F1); // card surface
  static const Color sageMist = Color(0xFFDCE5D7); // light sage

  static const Color deepGreen = Color(0xFF3F684C); // primary sage
  static const Color deepGreenDark = Color(0xFF203B2A); // dark forest
  static const Color gentleGreen = Color(0xFFA8C69F);
  static const Color sage = Color(0xFFCBE0C3);

  static const Color terracotta = Color(0xFFC96F55); // warm accent
  static const Color terracottaSoft = Color(0xFFE9C3AF);
  static const Color warmYellow = Color(0xFFE8B84B);
  static const Color warmYellowSoft = Color(0xFFF6E3B4);

  static const Color earthyBrown = Color(0xFF8A6D52);
  static const Color bark = Color(0xFF6B5440);

  // Spec-aligned aliases (colors are the source of truth; keep names).
  static const Color forest = deepGreenDark;
  static const Color sagePrimary = deepGreen;
  static const Color lightSage = sageMist;
  static const Color mutedBeige = Color(0xFFE9E0D2);
  static const Color warmBrown = Color(0xFF746A57);

  static const Color ink = Color(0xFF20251F);
  static const Color inkSoft = Color(0xFF5F634F);
  static const Color inkFaint = Color(0xFF8A8C7D);

  static const Color line = Color(0xFFE9E0D2);
  static const Color lineStrong = Color(0xFFD8D0BF);

  static const Color sky = Color(0xFF7FB5C9);
  static const Color skySoft = Color(0xFFD9ECF2);

  static const Color rose = Color(0xFFE07A7A);
  static const Color roseSoft = Color(0xFFF8D7D7);

  static const Color success = Color(0xFF4C9B5A);
  static const Color successSoft = Color(0xFFDFF0DC);
  static const Color infoSoft = Color(0xFFE3EFF7);

  // ── Wellness / caregiver palette ───────────────────────────────────────
  // Calm teal-blue health palette used by the caregiver dashboard. Mirrors
  // the Companio logo tones and stays additive to the warm garden system.
  static const Color careBg = Color(0xFFF1F7F8); // light teal off-white
  static const Color careCard = Color(0xFFFFFFFF);
  static const Color careTeal = Color(0xFF087F8C); // primary
  static const Color careTealDark = Color(0xFF056A75);
  static const Color careDeepBlue = Color(0xFF075985);
  static const Color careCyan = Color(0xFF38BDF8);
  static const Color careCyanSoft = Color(0xFFE0F2FE);
  static const Color careInk = Color(0xFF16323A); // main text
  static const Color careInkSoft = Color(0xFF5B7B84);
  static const Color careLine = Color(0xFFE2ECEE);
  static const Color careSuccess = Color(0xFF52A89A);
  static const Color careSuccessSoft = Color(0xFFDDF1EC);
  static const Color careWarning = Color(0xFFD99A2B);
  static const Color careWarningSoft = Color(0xFFFBEED3);
  static const Color careRose = Color(0xFFE07A7A);
  static const Color careRoseSoft = Color(0xFFFBE0E0);
  static const Color careBarMuted = Color(0xFF9EC6CE);
}
