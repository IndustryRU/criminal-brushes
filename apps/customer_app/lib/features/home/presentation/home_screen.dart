import 'package:criminal_brushes/core/theme/app_breakpoints.dart';
import 'package:criminal_brushes/core/theme/app_colors.dart';
import 'package:criminal_brushes/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= AppBreakpoints.desktop;
            final horizontalPadding = isDesktop ? 64.0 : AppSpacing.lg;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: AppSpacing.lg,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1280),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _Header(),
                      const SizedBox(height: AppSpacing.xxl),
                      if (isDesktop)
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: _HeroCopy()),
                            SizedBox(width: AppSpacing.xxl),
                            Expanded(child: _ProductPlaceholder()),
                          ],
                        )
                      else
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _HeroCopy(),
                            SizedBox(height: AppSpacing.xl),
                            _ProductPlaceholder(),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          'CRIMINAL BRUSHES',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.5),
        ),
        Spacer(),
        Badge(label: Text('PHASE 1')),
      ],
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy();

  @override
  Widget build(BuildContext context) {
    final displayStyle = Theme.of(context).textTheme.displayLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColors.acidLime,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          child: const Text(
            'TINY TROUBLE DROP',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text('BRUSH LIKE\nA REBEL', style: displayStyle),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Электрическая зубная щётка для маленьких бунтарей. '
          'Понятная детям, спокойная для родителей.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: AppSpacing.lg),
        FilledButton(onPressed: () {}, child: const Text('СМОТРЕТЬ КАТАЛОГ')),
      ],
    );
  }
}

class _ProductPlaceholder extends StatelessWidget {
  const _ProductPlaceholder();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: DecoratedBox(
        decoration: const BoxDecoration(color: AppColors.pink),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.electric_bolt, size: 160, color: AppColors.black),
            Positioned(
              right: AppSpacing.md,
              bottom: AppSpacing.md,
              child: Container(
                color: AppColors.black,
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: const Text(
                  'PRODUCT VISUAL\nPLACEHOLDER',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
