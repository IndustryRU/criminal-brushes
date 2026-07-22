import 'package:criminal_brushes/core/formatters/money_formatter.dart';
import 'package:criminal_brushes/features/cart/application/cart_controller.dart';
import 'package:criminal_brushes/features/catalog/data/mock_product_repository.dart';
import 'package:criminal_brushes/features/checkout/domain/checkout_draft.dart';
import 'package:criminal_brushes/features/delivery/data/mock_delivery_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('mock product repository exposes Tiny Trouble variants', () async {
    const repository = MockProductRepository();

    final products = await repository.getProducts();
    final tinyTrouble = await repository.getBySlug('tiny-trouble');

    expect(products, hasLength(1));
    expect(tinyTrouble, isNotNull);
    expect(tinyTrouble!.variants, hasLength(4));
    expect(
      tinyTrouble.variants.any((variant) => variant.stockQuantity == 0),
      true,
    );
  });

  test('formatMinorMoney formats minor units without double state storage', () {
    expect(formatMinorMoney(599000, 'RUB'), contains('5'));
  });

  test('cart merges equal variants and respects stock boundary', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final product = mockProducts.first;
    final variant = product.variants.first;
    final controller = container.read(cartControllerProvider.notifier);

    for (var i = 0; i < variant.stockQuantity + 3; i++) {
      controller.add(product, variant);
    }

    final items = container.read(cartControllerProvider);
    final totals = container.read(cartTotalsProvider);

    expect(items, hasLength(1));
    expect(items.single.quantity, variant.stockQuantity);
    expect(
      items.single.lineTotalMinor,
      variant.stockQuantity * variant.priceMinor,
    );
    expect(totals.subtotalMinor, variant.stockQuantity * variant.priceMinor);
  });

  test('cart ignores out-of-stock variants', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final product = mockProducts.first;
    final outOfStock = product.variants.firstWhere(
      (variant) => variant.stockQuantity == 0,
    );

    container.read(cartControllerProvider.notifier).add(product, outOfStock);

    expect(container.read(cartControllerProvider), isEmpty);
  });

  test('mock delivery repository returns active methods', () async {
    const repository = MockDeliveryRepository();

    final methods = await repository.getActiveMethods(599000);

    expect(methods, isNotEmpty);
    expect(methods.every((method) => method.isActive), true);
  });

  test('checkout draft copyWith preserves unchanged fields', () {
    const draft = CheckoutDraft(email: 'parent@example.com');

    final nextDraft = draft.copyWith(city: 'Moscow', consentAccepted: true);

    expect(nextDraft.email, 'parent@example.com');
    expect(nextDraft.city, 'Moscow');
    expect(nextDraft.consentAccepted, true);
  });
}
