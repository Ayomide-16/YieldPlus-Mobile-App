import 'package:flutter/material.dart';

/// Professional color palette for YieldPlus.AI
/// Inspired by modern agriculture apps (FarmLogs, Agrivi, Cropio)
class AppColors {
  // Prevent instantiation
  AppColors._();

  // === PRIMARY BRAND COLORS ===
  // Sophisticated forest green - main brand color
  static const Color primary = Color(0xFF10B981); // Emerald 500
  static const Color primaryLight = Color(0xFF34D399); // Emerald 400
  static const Color primaryDark = Color(0xFF059669); // Emerald 600
  static const Color primarySurface = Color(0xFFD1FAE5); // Emerald 100

  // === SECONDARY/ACCENT COLORS ===
  // Warm amber for CTAs and highlights
  static const Color accent = Color(0xFFF59E0B); // Amber 500
  static const Color accentLight = Color(0xFFFBBF24); // Amber 400
  static const Color accentDark = Color(0xFFD97706); // Amber 600

  // === SEMANTIC COLORS ===
  static const Color success = Color(0xFF22C55E); // Green 500
  static const Color successLight = Color(0xFFDCFCE7); // Green 100
  static const Color warning = Color(0xFFF97316); // Orange 500
  static const Color warningLight = Color(0xFFFED7AA); // Orange 200
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color errorLight = Color(0xFFFEE2E2); // Red 100
  static const Color info = Color(0xFF3B82F6); // Blue 500
  static const Color infoLight = Color(0xFFDBEAFE); // Blue 100

  // === NEUTRAL GRAYS (Light Mode) ===
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF4F4F5);
  static const Color gray200 = Color(0xFFE4E4E7);
  static const Color gray300 = Color(0xFFD4D4D8);
  static const Color gray400 = Color(0xFFA1A1AA);
  static const Color gray500 = Color(0xFF71717A);
  static const Color gray600 = Color(0xFF52525B);
  static const Color gray700 = Color(0xFF3F3F46);
  static const Color gray800 = Color(0xFF27272A);
  static const Color gray900 = Color(0xFF18181B);

  // === BACKGROUND COLORS ===
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color surfaceLight = Colors.white;
  static const Color backgroundDark = Color(0xFF0F172A); // Slate 900
  static const Color surfaceDark = Color(0xFF1E293B); // Slate 800

  // === TEXT COLORS ===
  static const Color textPrimary = Color(0xFF18181B); // Gray 900
  static const Color textSecondary = Color(0xFF71717A); // Gray 500
  static const Color textTertiary = Color(0xFFA1A1AA); // Gray 400
  static const Color textOnPrimary = Colors.white;
  static const Color textPrimaryDark = Color(0xFFF4F4F5); // Gray 100
  static const Color textSecondaryDark = Color(0xFFA1A1AA); // Gray 400

  // === CARD & SURFACE COLORS ===
  static const Color cardLight = Colors.white;
  static const Color cardDark = Color(0xFF1E293B);
  static const Color divider = Color(0xFFE4E4E7); // Gray 200
  static const Color dividerDark = Color(0xFF334155); // Slate 700

  // === GRADIENTS ===
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF10B981), Color(0xFF059669)],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF10B981), Color(0xFF047857)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD1FAE5), Color(0xFFA7F3D0)],
  );
}
