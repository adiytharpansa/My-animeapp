import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Kerangka state global. Belum ada logika bisnis — hanya wadah.
///
/// Contoh isi nanti:
/// - themeModeProvider -> disambung ke SharedPreferences
/// - bottomNavIndexProvider -> opsional jika butuh di luar go_router shell

/// Light / dark / system. Default system agar mengikuti HP user.
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

/// Flag dummy: apakah onboarding sudah pernah dilihat.
/// Nanti ganti dengan AsyncNotifier + storage. Sekarang selalu false.
final hasSeenOnboardingProvider = StateProvider<bool>((ref) => false);

/// Query pencarian (kerangka). Ditulis dari SearchBar, dibaca oleh grid hasil.
final searchQueryProvider = StateProvider<String>((ref) => '');

/// ID favorit (kerangka). Nanti ganti dengan StateNotifier/Set.
/// Sekarang default ada 2 dummy agar halaman Favorites tidak kosong.
final favoriteIdsProvider =
    StateProvider<Set<String>>((ref) => {'1', '3'});

/// Genre terpilih di Home (kerangka filter lokal).
final selectedGenreProvider = StateProvider<String>((ref) => 'Semua');
