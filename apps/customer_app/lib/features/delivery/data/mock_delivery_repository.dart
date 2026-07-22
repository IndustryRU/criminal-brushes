import 'package:criminal_brushes/features/delivery/data/delivery_repository.dart';
import 'package:criminal_brushes/features/delivery/domain/delivery_method.dart';

class MockDeliveryRepository implements DeliveryRepository {
  const MockDeliveryRepository();

  @override
  Future<List<DeliveryMethod>> getActiveMethods(int subtotalMinor) async {
    return mockDeliveryMethods.where((method) => method.isActive).toList();
  }
}

const mockDeliveryMethods = [
  DeliveryMethod(
    id: 'pickup',
    name: 'Mock pickup',
    description: 'Demo pickup option for phase 1.',
    priceMinor: 0,
    estimatedDeliveryText: 'Today, demo-only',
    isActive: true,
  ),
  DeliveryMethod(
    id: 'courier',
    name: 'Mock courier',
    description: 'Local delivery estimate with no real booking.',
    priceMinor: 39000,
    estimatedDeliveryText: '1-2 demo days',
    isActive: true,
  ),
];
