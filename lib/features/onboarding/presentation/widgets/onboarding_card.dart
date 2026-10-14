import 'package:flutter/material.dart';
import '../../../core/theme/app_dimens.dart';

/// Kartu satu slide onboarding. Stateless + const-friendly.
class OnboardingCard extends StatelessWidget {
  const OnboardingCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(AppDimens.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: scheme.primaryContainer,
            child: Icon(icon, size: 48, color: scheme.onPrimaryContainer),
          ),
          const SizedBox(height: AppDimens.xl),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppDimens.sm),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}
