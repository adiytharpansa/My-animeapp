import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_providers.dart';
import '../../../core/providers/dummy_providers.dart';
import '../../../shared/widgets/app_scaffold.dart';
import 'widgets/detail_header.dart';
import 'widgets/detail_info_section.dart';

/// Halaman detail anime (dummy). Terima [id] dari route param.
/// FAB favorit hanya toggle StateProvider lokal (kerangka).
class DetailPage extends ConsumerWidget {
  const DetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final anime = ref.watch(animeByIdProvider(id));
    final favs = ref.watch(favoriteIdsProvider);
    final isFav = favs.contains(anime.id);

    return AppScaffold(
      padding: EdgeInsets.zero,
      appBar: AppBar(title: const Text('Detail')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final next = Set<String>.from(favs);
          if (isFav) {
            next.remove(anime.id);
          } else {
            next.add(anime.id);
          }
          ref.read(favoriteIdsProvider.notifier).state = next;
        },
        icon: Icon(isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded),
        label: Text(isFav ? 'Favorit' : 'Tambah favorit'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailHeader(anime: anime),
          DetailInfoSection(anime: anime),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Kembali'),
            ),
          ),
          const SizedBox(height: 80), // ruang FAB
        ],
      ),
    );
  }
}
