import 'package:criminal_brushes/features/cart/domain/cart_item.dart';
import 'package:criminal_brushes/features/catalog/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartControllerProvider =
    NotifierProvider<CartController, List<CartItem>>(CartController.new);

final cartItemCountProvider = Provider<int>((ref) {
  return ref.watch(cartControllerProvider).fold<int>(
        0,
        (total, item) => total + item.quantity,
      );
});

final cartTotalsProvider = Provider<CartTotals>((ref) {
  final subtotal = ref.watch(cartControllerProvider).fold<int>(
        0,
        (total, item) => total + item.lineTotalMinor,
      );
  return CartTotals(
    subtotalMinor: subtotal,
    deliveryMinor: subtotal == 0 ? 0 : 39000,
    discountMinor: 0,
  );
});

class CartController extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => const [];

  void add(Product product, ProductVariant variant) {
    if (!variant.isInStock) return;

    final existingIndex = state.indexWhere(
      (item) => item.product.id == product.id && item.variant.id == variant.id,
    );

    if (existingIndex == -1) {
      state = [
        ...state,
        CartItem(
          product: product,
          variant: variant,
          quantity: 1,
          unitPriceMinor: variant.priceMinor,
        ),
      ];
      return;
    }

    final existing = state[existingIndex];
    final nextQuantity = (existing.quantity + 1).clamp(1, variant.stockQuantity).toInt();
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == existingIndex) existing.copyWith(quantity: nextQuantity) else state[i],
    ];
  }

  void setQuantity(String itemId, int quantity) {
    state = [
      for (final item in state)
        if (item.id == itemId)
          item.copyWith(quantity: quantity.clamp(1, item.variant.stockQuantity).toInt())
        else
          item,
    ];
  }

  void remove(String itemId) {
    state = state.where((item) => item.id != itemId).toList();
  }

  void clear() {
    state = const [];
  }
}

