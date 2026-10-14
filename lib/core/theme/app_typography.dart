import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tipografi Material 3 terpusat.
/// Memakai GoogleFonts.inter sebagai base, tetap fallback ke default jika gagal load.
abstract final class AppTypography {
  static TextTheme textTheme(ColorScheme scheme) {
    final base = ThemeData(useMaterial3: true, colorScheme: scheme).textTheme;
    try {
      return GoogleFonts.interTextTheme(base);
    } catch (_) {
      return base;
    }
  }
}
