import 'package:flutter/material.dart';

import '../../../shared/models/anime_dummy.dart';
import '../../../core/theme/app_dimens.dart';

/// Header detail: backdrop + poster + judul + meta.
/// Memakai Stack + Flexible agar aman di layar kecil/landscape.
/// Meta rating memakai ikon Material rounded (tanpa emoji).
class DetailHeader extends StatelessWidget {
  const DetailHeader({super.key, required this.anime});

  final AnimeDummy anime;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        SizedBox(
          height: 220,
          width: double.infinity,
          child: Image.network(
            anime.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Container(
              color: scheme.surfaceContainerHighest,
              child: const Icon(Icons.image_not_supported_rounded),
            ),
          ),
        ),
        Container(
          height: 220,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, scheme.surface.withValues(alpha: 0.95)],
            ),
          ),
        ),
        Positioned(
          left: AppDimens.lg,
          right: AppDimens.lg,
          bottom: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                child: Image.network(
                  anime.imageUrl,
                  width: 96,
                  height: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    width: 96,
                    height: 140,
                    color: scheme.surfaceContainerHighest,
                    child: const Icon(Icons.image_not_supported_rounded),
                  ),
                ),
              ),
              const SizedBox(width: AppDimens.md),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppDimens.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        anime.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              '${anime.year} • ${anime.episodes} eps',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: scheme.onSurfaceVariant,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.star_rounded,
                            size: 14,
                          ),
                          Text(
                            '${anime.rating}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w600,
                                ),
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
      ],
    );
  }
}
