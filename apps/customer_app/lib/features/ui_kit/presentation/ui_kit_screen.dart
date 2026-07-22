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
        const _SectionTitle('Price, rating, and color swatches'),
        Wrap(
          spacing: AppSpacing.lg,
          runSpacing: AppSpacing.md,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _PriceBlock(
              price: formatMinorMoney(variant.priceMinor, product.currency),
            ),
            _Rating(value: product.mockRating, count: product.mockReviewCount),
            ...product.variants.map(
              (variant) => _ColorSwatch(
                label: variant.colorName,
                color: _parseHex(variant.colorHex),
                selected: variant.id == product.defaultVariant.id,
                disabled: !variant.isInStock,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        const _SectionTitle('Quantity and cart row'),
        _QuantityStepper(value: 1, onDecrease: () {}, onIncrease: () {}),
        const SizedBox(height: AppSpacing.md),
        _CartRow(
          title: product.name,
          variant: variant.colorName,
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
        const SizedBox(height: AppSpacing.md),
        DropdownButtonFormField<String>(
          initialValue: 'courier',
          decoration: const InputDecoration(labelText: 'Delivery method'),
          items: const [
            DropdownMenuItem(value: 'pickup', child: Text('Mock pickup')),
            DropdownMenuItem(value: 'courier', child: Text('Mock courier')),
          ],
          onChanged: (_) {},
        ),
        const SizedBox(height: AppSpacing.xl),
        const _SectionTitle('Checkout stepper'),
        const _CheckoutStepper(currentIndex: 1),
        const SizedBox(height: AppSpacing.xl),
        const _SectionTitle('Loading, empty, success'),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            const Chip(label: Text('Loading')),
            const Chip(label: Text('Empty')),
            const Chip(label: Text('Success')),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Mock snackbar')));
              },
              child: const Text('Snackbar'),
            ),
            OutlinedButton(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Mock modal'),
                    content: const Text('Dialog state for UI kit review.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Modal'),
            ),
            const _ErrorPill(),
          ],
        ),
      ],
    );
  }
}

class _PriceBlock extends StatelessWidget {
  const _PriceBlock({required this.price});

  final String price;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.acidLime,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Text(price, style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}

class _Rating extends StatelessWidget {
  const _Rating({required this.value, required this.count});

  final double value;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Mock rating $value from $count reviews',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: AppColors.warning),
          const SizedBox(width: AppSpacing.xs),
          Text('$value mock rating ($count)'),
        ],
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({
    required this.label,
    required this.color,
    required this.selected,
    required this.disabled,
  });

  final String label;
  final Color color;
  final bool selected;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: disabled ? '$label unavailable' : label,
      child: Opacity(
        opacity: disabled ? 0.38 : 1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.black : AppColors.lineGray,
                  width: selected ? 3 : 1,
                ),
              ),
              child: selected ? const Icon(Icons.check, size: 20) : null,
            ),
            const SizedBox(height: AppSpacing.xs),
            SizedBox(
              width: 88,
              child: Text(
                label,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.value,
    required this.onDecrease,
    required this.onIncrease,
  });

  final int value;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Decrease quantity',
            onPressed: onDecrease,
            icon: const Icon(Icons.remove),
          ),
          SizedBox(
            width: 40,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          IconButton(
            tooltip: 'Increase quantity',
            onPressed: onIncrease,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class _CartRow extends StatelessWidget {
  const _CartRow({
    required this.title,
    required this.variant,
    required this.price,
  });

  final String title;
  final String variant;
  final String price;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.lineGray),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            const SizedBox.square(
              dimension: 56,
              child: ColoredBox(color: AppColors.pink),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Text(variant),
                ],
              ),
            ),
            Text(price, style: const TextStyle(fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }
}

class _CheckoutStepper extends StatelessWidget {
  const _CheckoutStepper({required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    const steps = ['Contact', 'Delivery', 'Payment', 'Summary'];

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (var i = 0; i < steps.length; i++)
          Chip(
            avatar: CircleAvatar(
              backgroundColor: i <= currentIndex
                  ? AppColors.black
                  : AppColors.lineGray,
              foregroundColor: i <= currentIndex
                  ? AppColors.white
                  : AppColors.black,
              child: Text('${i + 1}'),
            ),
            label: Text(steps[i]),
          ),
      ],
    );
  }
}

class _ErrorPill extends StatelessWidget {
  const _ErrorPill();

  @override
  Widget build(BuildContext context) {
    return const Chip(
      avatar: Icon(Icons.error_outline, color: AppColors.danger),
      label: Text('Error state'),
    );
  }
}

Color _parseHex(String value) {
  final hex = value.replaceFirst('#', '');
  return Color(int.parse('FF$hex', radix: 16));
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
