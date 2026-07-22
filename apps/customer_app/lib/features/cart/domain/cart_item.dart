import 'package:criminal_brushes/features/catalog/domain/product.dart';

class CartItem {
  const CartItem({
    required this.product,
    required this.variant,
    required this.quantity,
    required this.unitPriceMinor,
  });

  final Product product;
  final ProductVariant variant;
  final int quantity;
  final int unitPriceMinor;

  String get id => '${product.id}:${variant.id}';
  int get lineTotalMinor => quantity * unitPriceMinor;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      product: product,
      variant: variant,
      quantity: quantity ?? this.quantity,
      unitPriceMinor: unitPriceMinor,
    );
  }
}

class CartTotals {
  const CartTotals({
    required this.subtotalMinor,
    required this.deliveryMinor,
    required this.discountMinor,
  });

  final int subtotalMinor;
  final int deliveryMinor;
  final int discountMinor;

  int get totalMinor => subtotalMinor + deliveryMinor - discountMinor;
}
