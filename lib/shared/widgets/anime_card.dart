import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../models/anime_dummy.dart';

/// Kartu poster reusable rasio 2:3 — dipakai di Home, Search, Favorites.
/// Poster selalu AspectRatio 2:3 agar konsisten di semua layar.
/// Rating badge memakai ikon Material rounded (tanpa emoji).
class AnimeCard extends StatelessWidget {
  const AnimeCard({
    super.key,
    required this.anime,
    this.onTap,
    this.showRating = true,
    this.width,
  });

  final AnimeDummy anime;
  final VoidCallback? onTap;
  final bool showRating;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final card = Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppDimens.radiusMd),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      anime.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: scheme.surfaceContainerHighest,
                          child: const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, e, s) => Container(
                        color: scheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.image_not_supported_rounded,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    if (showRating)
                      Positioned(
                        top: AppDimens.sm,
                        left: AppDimens.sm,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.sm,
                            vertical: AppDimens.xs,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(
                              AppDimens.radiusSm,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 14,
                                color: AppColors.ratingAmber,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                anime.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    anime.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${anime.year} • ${anime.genres.first}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    if (width == null) return card;
    return SizedBox(width: width, child: card);
  }
}
