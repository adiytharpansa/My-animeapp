import 'package:flutter/material.dart';

/// Warna utama terpusat. Ganti [seed] untuk ganti seluruh tema.
/// Default: #6750A4 (Material 3 baseline purple).
abstract final class AppColors {
  static const Color seed = Color(0xFF6750A4);

  // Aksen tambahan untuk kebutuhan dummy (badge rating, genre chip).
  static const Color ratingAmber = Color(0xFFFFB300);
  static const Color success = Color(0xFF4CAF50);
}
