import 'package:criminal_brushes/core/formatters/money_formatter.dart';
import 'package:criminal_brushes/core/theme/app_colors.dart';
import 'package:criminal_brushes/core/theme/app_spacing.dart';
import 'package:criminal_brushes/features/catalog/data/mock_product_repository.dart';
import 'package:flutter/material.dart';

class UiKitScreen extends StatelessWidget {
  const UiKitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = mockProducts.first;
    final variant = product.defaultVariant;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text('UI Kit', style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: AppSpacing.lg),
        const _SectionTitle('Palette'),
        const Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            _Swatch('Pink', AppColors.pink),
            _Swatch('Acid Lime', AppColors.acidLime),
            _Swatch('Cool Blue', AppColors.coolBlue),
            _Swatch('Black', AppColors.black),
            _Swatch('Paper', AppColors.paper),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        const _SectionTitle('Buttons and badges'),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            FilledButton(onPressed: () {}, child: const Text('Primary')),
            OutlinedButton(onPressed: () {}, child: const Text('Secondary')),
            TextButton(onPressed: () {}, child: const Text('Text')),
            const Badge(label: Text('Mock'), child: Icon(Icons.star)),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        const _SectionTitle('Product card'),
        _ProductSample(
          title: product.name,
          subtitle: variant.colorName,
          price: formatMinorMoney(variant.priceMinor, product.currency),
        ),
        const SizedBox(height: AppSpacing.xl),
        const _SectionTitle('Form states'),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'parent@example.com',
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Error',
            errorText: 'Required mock field',
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        const _SectionTitle('Loading, empty, success'),
        const Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            Chip(label: Text('Loading')),
            Chip(label: Text('Empty')),
            Chip(label: Text('Success')),
          ],
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(text, style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch(this.label, this.color);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: AppColors.black),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(label),
      ],
    );
  }
}

class _ProductSample extends StatelessWidget {
  const _ProductSample({
    required this.title,
    required this.subtitle,
    required this.price,
  });

  final String title;
  final String subtitle;
  final String price;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.lineGray),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AspectRatio(
                aspectRatio: 1.2,
                child: ColoredBox(
                  color: AppColors.pink,
                  child: Icon(Icons.electric_bolt, size: 96),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
              Text(subtitle),
              const SizedBox(height: AppSpacing.sm),
              Text(price, style: const TextStyle(fontWeight: FontWeight.w900)),
            ],
          ),
        ),
      ),
    );
  }
}
