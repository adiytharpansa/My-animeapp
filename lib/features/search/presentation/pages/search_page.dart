import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_providers.dart';
import '../../../core/providers/dummy_providers.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../shared/utils/responsive.dart';
import '../../../shared/widgets/anime_card.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/empty_state.dart';
import 'widgets/search_bar_field.dart';

/// Pencarian dummy: filter lokal dari allAnimeProvider berdasar query.
/// Tanpa debounce/API — kerangka saja.
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider).toLowerCase();
    final all = ref.watch(allAnimeProvider);
    final results = query.isEmpty
        ? all
        : all
            .where((e) =>
                e.title.toLowerCase().contains(query) ||
                e.genres.any((g) => g.toLowerCase().contains(query)))
            .toList();

    return AppScaffoldUnscrolled(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimens.lg),
            child: SearchBarField(
              controller: _controller,
              onChanged: (v) =>
                  ref.read(searchQueryProvider.notifier).state = v,
              onClear: () {
                _controller.clear();
                ref.read(searchQueryProvider.notifier).state = '';
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? EmptyState(
                    icon: Icons.search_off_rounded,
                    title: 'Tidak ditemukan',
                    subtitle: 'Coba kata kunci lain, mis. "kage" atau "action".',
                    actionLabel: 'Reset',
                    onAction: () {
                      _controller.clear();
                      ref.read(searchQueryProvider.notifier).state = '';
                      setState(() {});
                    },
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.lg,
                      0,
                      AppDimens.lg,
                      AppDimens.lg,
                    ),
                    itemCount: results.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Responsive.gridColumns(context),
                      mainAxisSpacing: AppDimens.md,
                      crossAxisSpacing: AppDimens.md,
                      // Kartu 2:3 + blok teks: rasio ~0.55 agar tidak terpotong.
                      childAspectRatio: 0.55,
                    ),
                    itemBuilder: (context, i) => AnimeCard(
                      anime: results[i],
                      onTap: () => context.go(
                        '${AppRoutes.home}/${AppRoutes.detail}/${results[i].id}',
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
