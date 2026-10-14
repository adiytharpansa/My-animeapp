import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_dimens.dart';
import 'widgets/onboarding_card.dart';

/// Onboarding 3 slide dengan PageView. Tombol Skip/Next/Mulai.
/// Selesai -> go ke /home. Tanpa penyimpanan permanen (kerangka).
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _index = 0;

  static const _slides = [
    OnboardingCard(
      icon: Icons.explore_rounded,
      title: 'Jelajahi Ribuan Anime',
      subtitle: 'Katalog dummy yang rapi dengan filter genre dan rating.',
    ),
    OnboardingCard(
      icon: Icons.info_rounded,
      title: 'Detail Lengkap Sekilas',
      subtitle: 'Sinopsis, episode, tahun, dan genre dalam satu layar.',
    ),
    OnboardingCard(
      icon: Icons.favorite_rounded,
      title: 'Simpan Favoritmu',
      subtitle: 'Tandai anime favorit dan kelola dari satu tab khusus.',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _finish() => context.go(AppRoutes.home);

  @override
  Widget build(BuildContext context) {
    final isLast = _index == _slides.length - 1;
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (!isLast)
            TextButton(onPressed: _finish, child: const Text('Lewati')),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, i) => _slides[i],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin:
                      const EdgeInsets.symmetric(horizontal: AppDimens.xs),
                  height: 8,
                  width: i == _index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: i == _index
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.xl),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (isLast) {
                      _finish();
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                  child: Text(isLast ? 'Mulai Jelajah' : 'Lanjut'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
