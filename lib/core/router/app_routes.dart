/// Konstanta path + nama route. Satu sumber kebenaran untuk navigasi.
abstract final class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';

  // Shell (bottom nav)
  static const String home = '/home';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String profile = '/profile';

  // Sub-route
  static const String detail = 'detail'; // dipakai sebagai /home/detail/:id
  static String detailPath(String id) => '$home/$detail/$id';
}
