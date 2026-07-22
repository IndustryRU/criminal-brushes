import 'package:criminal_brushes/features/delivery/data/delivery_repository.dart';
import 'package:criminal_brushes/features/delivery/data/mock_delivery_repository.dart';
import 'package:criminal_brushes/features/delivery/domain/delivery_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deliveryRepositoryProvider = Provider<DeliveryRepository>(
  (ref) => const MockDeliveryRepository(),
);

final activeDeliveryMethodsProvider =
    FutureProvider.family<List<DeliveryMethod>, int>((ref, subtotalMinor) {
      return ref
          .watch(deliveryRepositoryProvider)
          .getActiveMethods(subtotalMinor);
    });
