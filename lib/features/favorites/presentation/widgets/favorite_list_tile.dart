import 'package:flutter/material.dart';

import '../../../shared/models/anime_dummy.dart';
import '../../../core/theme/app_colors.dart';

/// Satu baris favorit: thumbnail + judul + rating + tombol hapus.
/// Rating memakai ikon Material rounded (tanpa emoji).
class FavoriteListTile extends StatelessWidget {
  const FavoriteListTile({
    super.key,
    required this.anime,
    this.onTap,
    this.onRemove,
  });

  final AnimeDummy anime;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            anime.imageUrl,
            width: 56,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) =>
                const Icon(Icons.image_not_supported_rounded),
          ),
        ),
        title: Text(
          anime.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.star_rounded,
              size: 14,
              color: AppColors.ratingAmber,
            ),
            const SizedBox(width: 2),
            Flexible(
              child: Text(
                '${anime.rating} • ${anime.year}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          tooltip: 'Hapus favorit',
          icon: const Icon(Icons.delete_outline_rounded),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
