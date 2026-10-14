import 'package:flutter/material.dart';

import '../../../shared/models/anime_dummy.dart';
import '../../../core/theme/app_dimens.dart';

/// Baris "Lanjut nonton": kartu landscape dengan progress dummy.
/// Tinggi fix, lebar fix, teks ellipsis — aman di layar kecil.
class ContinueWatchingRow extends StatelessWidget {
  const ContinueWatchingRow({
    super.key,
    required this.items,
    required this.onTap,
  });

  final List<AnimeDummy> items;
  final void Function(AnimeDummy) onTap;

  // Progress dummy deterministik per id (kerangka, tanpa storage).
  double _progressFor(String id) {
    final n = id.hashCode.abs() % 70 + 10;
    return n / 100;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 132,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.lg),
        itemCount: items.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: AppDimens.md),
        itemBuilder: (context, i) {
          final anime = items[i];
          final progress = _progressFor(anime.id);
          return SizedBox(
            width: 260,
            child: Card(
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => onTap(anime),
                child: Row(
                  children: [
                    SizedBox(
                      width: 88,
                      child: Image.network(
                        anime.imageUrl,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(
                          color: scheme.surfaceContainerHighest,
                          child: const Icon(
                            Icons.image_not_supported_rounded,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimens.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.history_rounded,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    'Ep ${(progress * anime.episodes).ceil()} / ${anime.episodes}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              anime.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(99),
                              child: LinearProgressIndicator(
                                value: progress,
                                minHeight: 6,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.play_circle_fill_rounded,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${(progress * 100).round()}%',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
