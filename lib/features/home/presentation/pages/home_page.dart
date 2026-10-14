import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_providers.dart';
import '../../../core/providers/dummy_providers.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/section_title.dart';
import 'widgets/anime_carousel.dart';
import 'widgets/continue_watching_row.dart';
import 'widgets/genre_chips.dart';
import 'widgets/home_header.dart';
import 'widgets/poster_row.dart';

/// Home (revisi): header ikon saja + carousel unggulan + chip genre +
/// baris Lanjut nonton / Trending / Rilis terbaru.
/// Semua baris horizontal (tanpa grid vertikal) agar anti-overflow
/// di layar kecil. Tanpa kartu statistik dev.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featured = ref.watch(featuredAnimeProvider);
    final continueWatching = ref.watch(continueWatchingProvider);
    final trending = ref.watch(trendingAnimeProvider);
    final latest = ref.watch(latestAnimeProvider);
    final genres = ref.watch(genreListProvider);
    final selectedGenre = ref.watch(selectedGenreProvider);

    void goDetail(String id) =>
        context.go('${AppRoutes.home}/${AppRoutes.detail}/$id');

    final filteredTrending = selectedGenre == 'Semua'
        ? trending
        : trending
            .where((e) => e.genres.contains(selectedGenre))
            .toList();

    return AppScaffold(
      scrollable: true,
      padding: EdgeInsets.zero,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(
              AppDimens.lg,
              AppDimens.lg,
              AppDimens.md,
              AppDimens.sm,
            ),
            child: HomeHeader(),
          ),
          FeaturedCarousel(
            items: featured,
            onTap: (a) => goDetail(a.id),
            onWatch: (a) => goDetail(a.id),
          ),
          const SizedBox(height: AppDimens.lg),
          GenreChips(
            genres: genres,
            selected: selectedGenre,
            onSelected: (g) =>
                ref.read(selectedGenreProvider.notifier).state = g,
          ),
          const SizedBox(height: AppDimens.md),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.lg),
            child: SectionTitle(title: 'Lanjut nonton'),
          ),
          const SizedBox(height: AppDimens.sm),
          ContinueWatchingRow(
            items: continueWatching,
            onTap: (a) => goDetail(a.id),
          ),
          const SizedBox(height: AppDimens.lg),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.lg),
            child: SectionTitle(title: 'Trending'),
          ),
          const SizedBox(height: AppDimens.sm),
          PosterRow(
            items: filteredTrending,
            onTap: (a) => goDetail(a.id),
          ),
          const SizedBox(height: AppDimens.lg),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.lg),
            child: SectionTitle(title: 'Rilis terbaru'),
          ),
          const SizedBox(height: AppDimens.sm),
          PosterRow(
            items: latest,
            onTap: (a) => goDetail(a.id),
          ),
          const SizedBox(height: AppDimens.xl),
        ],
      ),
    );
  }
}
