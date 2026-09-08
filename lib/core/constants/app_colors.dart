import 'package:flutter/material.dart';

abstract class AppColors {
  // 1. Primary & Brand Colors
  static const Color primary = Color(0xFF673AB7); // Deep Purple
  static const Color primaryDark = Color(0xFF512DA8);
  static const Color secondary = Color(0xFFFF9800); // Accent Orange

  // 2. Backgrounds & Surfaces
  static const Color background = Colors.white;
  static const Color surface = Colors.white; // Card / Sheet surface
  static const Color border = Color(0xFFEEEEEE);

  // 3. Text Colors
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  // 4. Feedback / Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFB300);
}
