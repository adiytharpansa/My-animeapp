import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/app_bottom_nav.dart';

/// Shell bottom-nav 4 tab. Meneruskan StatefulNavigationShell
/// dari go_router agar state tiap tab tidak hilang saat pindah tab.
class MainShellPage extends StatelessWidget {
  const MainShellPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNav(navigationShell: navigationShell),
    );
  }
}
