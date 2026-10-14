import 'package:flutter/material.dart';

/// Shortcut agar page tidak bertele-tele:
/// `context.colors.primary` bukan `Theme.of(context).colorScheme.primary`.
extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get texts => Theme.of(this).textTheme;
  Size get screenSize => MediaQuery.sizeOf(this);
}
