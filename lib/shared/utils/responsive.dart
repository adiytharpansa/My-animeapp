import 'package:flutter/widgets.dart';
import '../../core/theme/app_dimens.dart';

/// Helper responsif. Dipakai semua page agar tanpa overflow
/// di HP kecil, tablet, maupun landscape.
abstract final class Responsive {
  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppDimens.tablet;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppDimens.desktop;

  /// Jumlah kolom grid adaptif: 2 di HP, 3 di tablet kecil, 4 di lebar.
  static int gridColumns(BuildContext context, {int mobile = 2}) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= AppDimens.desktop) return 4;
    if (w >= AppDimens.tablet) return 3;
    return mobile;
  }

  /// Lebar konten dibatasi agar nyaman dibaca di tablet/desktop.
  static double contentWidth(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w > AppDimens.maxContentWidth ? AppDimens.maxContentWidth : w;
  }
}
