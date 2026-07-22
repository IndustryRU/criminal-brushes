import 'package:criminal_brushes/core/theme/app_colors.dart';
import 'package:criminal_brushes/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    required this.title,
    required this.description,
    this.primaryPath,
    this.primaryLabel,
    super.key,
  });

  final String title;
  final String description;
  final String? primaryPath;
  final String? primaryLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColors.acidLime,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                child: const Text(
                  'PHASE 1 PLACEHOLDER',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(title, style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: AppSpacing.md),
              Text(description, style: Theme.of(context).textTheme.bodyLarge),
              if (primaryPath != null && primaryLabel != null) ...[
                const SizedBox(height: AppSpacing.lg),
                FilledButton(
                  onPressed: () => context.go(primaryPath!),
                  child: Text(primaryLabel!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
