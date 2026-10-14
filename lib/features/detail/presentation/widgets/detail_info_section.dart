import 'package:flutter/material.dart';

import '../../../shared/models/anime_dummy.dart';
import '../../../core/theme/app_dimens.dart';

/// Sinopsis + genre chips + info grid (dummy).
class DetailInfoSection extends StatelessWidget {
  const DetailInfoSection({super.key, required this.anime});

  final AnimeDummy anime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppDimens.sm,
            runSpacing: AppDimens.sm,
            children:
                anime.genres.map((g) => Chip(label: Text(g))).toList(),
          ),
          const SizedBox(height: AppDimens.lg),
          Text(
            'Sinopsis',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppDimens.sm),
          Text(anime.synopsis, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: AppDimens.lg),
          const _InfoGrid(),
        ],
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  const _InfoGrid();

  @override
  Widget build(BuildContext context) {
    const items = [
      ('Status', 'Ongoing (dummy)'),
      ('Studio', 'Studio Dummy'),
      ('Rating', 'PG-13 (dummy)'),
      ('Sumber', 'Manga (dummy)'),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 64,
      ),
      itemBuilder: (context, i) {
        final (label, value) = items[i];
        return Container(
          padding: const EdgeInsets.all(AppDimens.md),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelSmall),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        );
      },
    );
  }
}
