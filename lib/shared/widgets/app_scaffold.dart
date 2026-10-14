import 'package:flutter/material.dart';
import '../../core/theme/app_dimens.dart';
import '../utils/responsive.dart';

/// Scaffold standar semua page: aman dari notch, konten terpusat,
/// dan anti-overflow karena memakai SafeArea + Align + ConstrainedBox.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.padding = const EdgeInsets.all(AppDimens.lg),
    this.scrollable = true,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final EdgeInsetsGeometry padding;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final content = Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxWidth: AppDimens.maxContentWidth),
        child: Padding(padding: padding, child: body),
      ),
    );

    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: scrollable
            ? SingleChildScrollView(child: content)
            : content,
      ),
    );
  }
}

/// Varian tanpa scroll untuk page berisi ListView/GridView sendiri
/// (mis. Home, Search) — tetap terpusat di tablet.
class AppScaffoldUnscrolled extends StatelessWidget {
  const AppScaffoldUnscrolled({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Responsive.isDesktop(context)
                  ? AppDimens.maxContentWidth + 320
                  : AppDimens.maxContentWidth,
            ),
            child: body,
          ),
        ),
      ),
    );
  }
}
