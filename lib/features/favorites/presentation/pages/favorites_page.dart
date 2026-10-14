import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_providers.dart';
import '../../../core/providers/dummy_providers.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/empty_state.dart';
import 'widgets/favorite_list_tile.dart';

/// Daftar favorit (dummy). Baca dari favoriteIdsProvider,
/// hapus = update Set. Tanpa persistensi — kerangka.
class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favIds = ref.watch(favoriteIdsProvider);
    final all = ref.watch(allAnimeProvider);
    final favs = all.where((e) => favIds.contains(e.id)).toList();

    return AppScaffoldUnscrolled(
      appBar: AppBar(title: const Text('Favorites')),
      body: favs.isEmpty
          ? EmptyState(
              icon: Icons.favorite_outline_rounded,
              title: 'Belum ada favorit',
              subtitle: 'Tap hati di halaman detail untuk menyimpan.',
              actionLabel: 'Ke Home',
              onAction: () => context.go(AppRoutes.home),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(AppDimens.lg),
              itemCount: favs.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppDimens.sm),
              itemBuilder: (context, i) => FavoriteListTile(
                anime: favs[i],
                onTap: () => context.go(
                  '${AppRoutes.home}/${AppRoutes.detail}/${favs[i].id}',
                ),
                onRemove: () {
                  final next = Set<String>.from(favIds)..remove(favs[i].id);
                  ref.read(favoriteIdsProvider.notifier).state = next;
                },
              ),
            ),
    );
  }
}
