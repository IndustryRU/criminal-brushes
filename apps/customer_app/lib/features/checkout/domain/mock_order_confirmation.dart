import 'package:criminal_brushes/features/cart/domain/cart_item.dart';

class MockOrderConfirmation {
  const MockOrderConfirmation({
    required this.orderNumber,
    required this.createdAt,
    required this.items,
    required this.totalMinor,
    required this.deliverySummary,
    required this.contactSummary,
  });

  final String orderNumber;
  final DateTime createdAt;
  final List<CartItem> items;
  final int totalMinor;
  final String deliverySummary;
  final String contactSummary;
}
