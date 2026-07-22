import 'package:criminal_brushes/core/content/mock_claims.dart';
import 'package:criminal_brushes/core/formatters/money_formatter.dart';
import 'package:criminal_brushes/core/theme/app_breakpoints.dart';
import 'package:criminal_brushes/core/theme/app_colors.dart';
import 'package:criminal_brushes/core/theme/app_spacing.dart';
import 'package:criminal_brushes/features/catalog/application/product_providers.dart';
import 'package:criminal_brushes/features/catalog/domain/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredProducts = ref.watch(featuredProductListProvider);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= AppBreakpoints.desktop;
          final horizontalPadding = isDesktop ? 64.0 : AppSpacing.lg;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: AppSpacing.xl,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AppBreakpoints.wide),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _PhaseBadge(),
                    const SizedBox(height: AppSpacing.xl),
                    featuredProducts.when(
                      data: (products) {
                        final product = products.first;
                        return isDesktop
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(child: _HeroCopy(product: product)),
                                  const SizedBox(width: AppSpacing.xxl),
                                  Expanded(
                                    child: _ProductPlaceholder(product: product),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _HeroCopy(product: product),
                                  const SizedBox(height: AppSpacing.xl),
                                  _ProductPlaceholder(product: product),
                                ],
                              );
                      },
                      loading: () => const LinearProgressIndicator(),
                      error: (error, stackTrace) => Text('Mock error: $error'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PhaseBadge extends StatelessWidget {
  const _PhaseBadge();

  @override
  Widget build(BuildContext context) {
    return const Badge(
      label: Text('FOUNDATION'),
      child: Text(
        'PHASE 1',
        style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({required this.product});

  final Product product;

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
          child: Text(
            product.collectionName.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(MockClaims.heroTitle.toUpperCase(), style: displayStyle),
        const SizedBox(height: AppSpacing.lg),
        Text(MockClaims.heroBody, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.sm,
          children: [
            FilledButton(
              onPressed: () => context.go('/catalog'),
              child: const Text('Browse catalog'),
            ),
            OutlinedButton(
              onPressed: () => context.go('/ui-kit'),
              child: const Text('Open UI kit'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProductPlaceholder extends StatelessWidget {
  const _ProductPlaceholder({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final variant = product.defaultVariant;

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
                child: Text(
                  '${product.name}\n${variant.colorName}\n${formatMinorMoney(variant.priceMinor, product.currency)}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
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
