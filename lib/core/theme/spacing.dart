import 'package:flutter/material.dart';

/// Spacing constants using 8-point grid system
class AppSpacing {
  AppSpacing._();

  static const double unit = 4.0;
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;
  static const double screenPadding = 20.0;
  static const double cardPadding = 16.0;
  static const double sectionSpacing = 32.0;
  static const double itemSpacing = 12.0;
}

/// Border radius constants
class AppRadius {
  AppRadius._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double full = 100.0;
}

/// Shadow definitions
class AppShadows {
  AppShadows._();

  static List<BoxShadow> get sm => [
    BoxShadow(
      color: const Color(0xFF000000).withOpacity(0.05),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get md => [
    BoxShadow(
      color: const Color(0xFF000000).withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get lg => [
    BoxShadow(
      color: const Color(0xFF000000).withOpacity(0.1),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];
}
