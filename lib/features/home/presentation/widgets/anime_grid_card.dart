import 'package:flutter/material.dart';

import '../../../shared/models/anime_dummy.dart';
import '../../../shared/widgets/anime_card.dart';

/// Wrapper grid-card Home agar HomePage tetap ramping.
/// (Logika grid — crossAxisCount responsif — ada di HomePage.)
class AnimeGridCard extends StatelessWidget {
  const AnimeGridCard({super.key, required this.anime, required this.onTap});

  final AnimeDummy anime;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimeCard(anime: anime, onTap: onTap);
  }
}
