import 'package:flutter/material.dart';

import '../../../shared/models/anime_dummy.dart';
import '../../../shared/widgets/anime_card.dart';
import '../../../core/theme/app_dimens.dart';

/// Baris poster horizontal reusable (Trending, Rilis terbaru).
/// Setiap kartu lebar fix 132 agar rasio 2:3 terjaga di semua layar.
class PosterRow extends StatelessWidget {
  const PosterRow({
    super.key,
    required this.items,
    required this.onTap,
  });

  final List<AnimeDummy> items;
  final void Function(AnimeDummy) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // 132 lebar -> poster 198 + blok teks ~60 + margin.
      height: 272,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.lg),
        itemCount: items.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: AppDimens.md),
        itemBuilder: (context, i) => AnimeCard(
          anime: items[i],
          width: 132,
          onTap: () => onTap(items[i]),
        ),
      ),
    );
  }
}
