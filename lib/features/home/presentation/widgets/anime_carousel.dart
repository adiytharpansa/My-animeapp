import 'package:flutter/material.dart';

import '../../../shared/models/anime_dummy.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';

/// Carousel anime unggulan: PageView full-bleed dengan poster sebagai
/// background, gradient, judul, baris rating (ikon Material), dan
/// tombol Tonton. Menggantikan banner teks dev sebelumnya.
/// Tinggi adaptif dan semua teks di-ellipsis agar anti-overflow.
class FeaturedCarousel extends StatefulWidget {
  const FeaturedCarousel({
    super.key,
    required this.items,
    required this.onTap,
    this.onWatch,
  });

  final List<AnimeDummy> items;
  final void Function(AnimeDummy) onTap;
  final void Function(AnimeDummy)? onWatch;

  @override
  State<FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  final _controller = PageController(viewportFraction: 0.92);
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (widget.items.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) {
              final anime = widget.items[i];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppDimens.xs),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(AppDimens.radiusLg),
                  child: Material(
                    color: scheme.surfaceContainerHighest,
                    child: InkWell(
                      onTap: () => widget.onTap(anime),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            anime.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => Container(
                              color: scheme.surfaceContainerHighest,
                              child: const Center(
                                child: Icon(
                                  Icons.movie_rounded,
                                  size: 48,
                                ),
                              ),
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.75),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: AppDimens.lg,
                            right: AppDimens.lg,
                            bottom: AppDimens.md,
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimens.sm,
                                    vertical: AppDimens.xs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
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
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          '${anime.rating.toStringAsFixed(1)} • ${anime.year} • ${anime.genres.first}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: AppDimens.sm),
                                Text(
                                  anime.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                                const SizedBox(height: AppDimens.sm),
                                Row(
                                  children: [
                                    Flexible(
                                      child: FilledButton.icon(
                                        onPressed: () =>
                                            (widget.onWatch ?? widget.onTap)(
                                                anime),
                                        icon: const Icon(
                                          Icons.play_arrow_rounded,
                                          size: 18,
                                        ),
                                        label: const Text('Tonton'),
                                      ),
                                    ),
                                    const SizedBox(width: AppDimens.sm),
                                    Flexible(
                                      child: OutlinedButton.icon(
                                        onPressed: () =>
                                            widget.onTap(anime),
                                        icon: const Icon(
                                          Icons.info_outline_rounded,
                                          size: 18,
                                        ),
                                        label: const Text(
                                          'Detail',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          side: const BorderSide(
                                            color: Colors.white54,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppDimens.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.items.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin:
                  const EdgeInsets.symmetric(horizontal: AppDimens.xs / 2),
              height: 6,
              width: i == _index ? 20 : 6,
              decoration: BoxDecoration(
                color: i == _index
                    ? scheme.primary
                    : scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
