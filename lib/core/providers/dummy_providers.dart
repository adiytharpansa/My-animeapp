import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/models/anime_dummy.dart';

/// Provider dummy — menggantikan posisi repository/API di skeleton ini.
/// Nanti tinggal ganti implementasi dengan FutureProvider/StreamProvider
/// tanpa mengubah signature yang dipakai UI.

final trendingAnimeProvider = Provider<List<AnimeDummy>>((ref) {
  return AnimeDummy.samples.where((e) => e.rating >= 8.5).toList();
});

final allAnimeProvider = Provider<List<AnimeDummy>>((ref) {
  return AnimeDummy.samples;
});

/// Unggulan untuk carousel atas: 3 rating tertinggi.
final featuredAnimeProvider = Provider<List<AnimeDummy>>((ref) {
  final sorted = List<AnimeDummy>.from(AnimeDummy.samples)
    ..sort((a, b) => b.rating.compareTo(a.rating));
  return sorted.take(3).toList();
});

/// Lanjut nonton (dummy): 3 pertama.
final continueWatchingProvider = Provider<List<AnimeDummy>>((ref) {
  return AnimeDummy.samples.take(3).toList();
});

/// Rilis terbaru (dummy): urut tahun terbaru.
final latestAnimeProvider = Provider<List<AnimeDummy>>((ref) {
  final sorted = List<AnimeDummy>.from(AnimeDummy.samples)
    ..sort((a, b) => b.year.compareTo(a.year));
  return sorted;
});

/// Daftar genre unik untuk chip filter (kerangka).
final genreListProvider = Provider<List<String>>((ref) {
  final set = <String>{'Semua'};
  for (final anime in AnimeDummy.samples) {
    set.addAll(anime.genres);
  }
  return set.toList();
});

final animeByIdProvider = Provider.family<AnimeDummy, String>((ref, id) {
  return AnimeDummy.samples.firstWhere(
    (e) => e.id == id,
    orElse: () => AnimeDummy.samples.first,
  );
});
