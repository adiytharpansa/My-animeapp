import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_providers.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../shared/widgets/app_scaffold.dart';
import 'widgets/profile_menu_tile.dart';

/// Profil + pengaturan dummy: ganti tema, info akun, keluar ke onboarding.
/// Tanpa auth/backend — kerangka UI saja.
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    final favCount = ref.watch(favoriteIdsProvider).length;

    String modeLabel(ThemeMode m) => switch (m) {
          ThemeMode.system => 'Mengikuti HP',
          ThemeMode.light => 'Terang',
          ThemeMode.dark => 'Gelap',
        };

    return AppScaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header akun dummy
          Row(
            children: [
              const CircleAvatar(
                radius: 32,
                child: Icon(Icons.person_rounded, size: 32),
              ),
              const SizedBox(width: AppDimens.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Guest User (dummy)',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '$favCount favorit tersimpan',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              FilledButton.tonal(
                onPressed: () {},
                child: const Text('Edit'),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.xl),
          Text(
            'Pengaturan',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppDimens.sm),
          ProfileMenuTile(
            icon: Icons.palette_rounded,
            title: 'Tema',
            subtitle: modeLabel(mode),
            trailing: SegmentedButton<ThemeMode>(
              showSelectedIcon: false,
              style: const ButtonStyle(
                visualDensity: VisualDensity.compact,
              ),
              segments: const [
                ButtonSegment(
                  value: ThemeMode.light,
                  icon: Icon(Icons.light_mode_rounded, size: 16),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  icon: Icon(Icons.settings_rounded, size: 16),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  icon: Icon(Icons.dark_mode_rounded, size: 16),
                ),
              ],
              selected: {mode},
              onSelectionChanged: (s) =>
                  ref.read(themeModeProvider.notifier).state = s.first,
            ),
          ),
          const SizedBox(height: AppDimens.sm),
          ProfileMenuTile(
            icon: Icons.notifications_rounded,
            title: 'Notifikasi',
            subtitle: 'Dummy — belum ada logika',
            trailing: Switch(value: true, onChanged: (_) {}),
          ),
          const SizedBox(height: AppDimens.sm),
          ProfileMenuTile(
            icon: Icons.info_rounded,
            title: 'Tentang',
            subtitle: 'My-animeapp v0.1.0 skeleton',
            onTap: () {},
          ),
          const SizedBox(height: AppDimens.lg),
          OutlinedButton.icon(
            onPressed: () => context.go(AppRoutes.onboarding),
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Keluar (ke Onboarding)'),
          ),
        ],
      ),
    );
  }
}
