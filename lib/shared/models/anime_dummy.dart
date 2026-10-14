import 'package:flutter/foundation.dart';

/// Model dummy — satu-satunya sumber data di skeleton ini.
/// Nanti diganti DTO dari API tanpa mengubah field yang dipakai UI.
@immutable
class AnimeDummy {
  const AnimeDummy({
    required this.id,
    required this.title,
    required this.genres,
    required this.rating,
    required this.year,
    required this.episodes,
    required this.synopsis,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final List<String> genres;
  final double rating;
  final int year;
  final int episodes;
  final String synopsis;
  final String imageUrl;

  static const List<AnimeDummy> samples = [
    AnimeDummy(
      id: '1',
      title: 'Hoshizora no Tabi',
      genres: ['Adventure', 'Fantasy'],
      rating: 8.9,
      year: 2024,
      episodes: 24,
      synopsis:
          'Seorang kartografer muda memetakan ulang langit yang retak demi menemukan kembali konstelasi yang hilang.',
      imageUrl: 'https://picsum.photos/seed/anime1/400/600',
    ),
    AnimeDummy(
      id: '2',
      title: 'Neon Ramen Nights',
      genres: ['Slice of Life', 'Comedy'],
      rating: 8.2,
      year: 2023,
      episodes: 12,
      synopsis:
          'Kedai ramen buka tengah malam di distrik neon, tiap mangkuk menyimpan cerita pelanggan yang mampir.',
      imageUrl: 'https://picsum.photos/seed/anime2/400/600',
    ),
    AnimeDummy(
      id: '3',
      title: 'Kage no Senki',
      genres: ['Action', 'Drama'],
      rating: 9.1,
      year: 2024,
      episodes: 26,
      synopsis:
          'Pewaris bayangan terakhir harus memilih antara membalas dendam klannya atau melindungi desa yang mengusirnya.',
      imageUrl: 'https://picsum.photos/seed/anime3/400/600',
    ),
    AnimeDummy(
      id: '4',
      title: 'Ameagari Library',
      genres: ['Romance', 'Drama'],
      rating: 8.4,
      year: 2022,
      episodes: 13,
      synopsis:
          'Dua pustakawan saingan yang selalu bertemu setiap hujan reda perlahan saling meminjamkan dunia mereka.',
      imageUrl: 'https://picsum.photos/seed/anime4/400/600',
    ),
    AnimeDummy(
      id: '5',
      title: 'Mecha Pantry Zero',
      genres: ['Sci-Fi', 'Comedy'],
      rating: 7.9,
      year: 2023,
      episodes: 12,
      synopsis:
          'Pilot mecha pensiun membuka toko kelontong; para pelanggan lamanya datang membawa masalah sebesar robot.',
      imageUrl: 'https://picsum.photos/seed/anime5/400/600',
    ),
    AnimeDummy(
      id: '6',
      title: 'Yurei Express',
      genres: ['Mystery', 'Supernatural'],
      rating: 8.7,
      year: 2024,
      episodes: 18,
      synopsis:
          'Kereta terakhir tiap malam hanya berhenti untuk penumpang yang belum menyelesaikan urusannya di dunia.',
      imageUrl: 'https://picsum.photos/seed/anime6/400/600',
    ),
  ];
}
