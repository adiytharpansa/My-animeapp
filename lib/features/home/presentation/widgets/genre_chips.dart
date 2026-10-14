import 'package:flutter/material.dart';

import '../../../core/theme/app_dimens.dart';

/// Baris chip genre horizontal. Single-select (kerangka).
/// Memakai ListView horizontal + ChoiceChip agar anti-overflow.
class GenreChips extends StatelessWidget {
  const GenreChips({
    super.key,
    required this.genres,
    required this.selected,
    required this.onSelected,
  });

  final List<String> genres;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.lg),
        itemCount: genres.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: AppDimens.sm),
        itemBuilder: (context, i) {
          final genre = genres[i];
          return ChoiceChip(
            label: Text(genre),
            selected: genre == selected,
            onSelected: (_) => onSelected(genre),
          );
        },
      ),
    );
  }
}
