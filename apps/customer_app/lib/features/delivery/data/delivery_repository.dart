import 'package:criminal_brushes/features/delivery/domain/delivery_method.dart';

abstract interface class DeliveryRepository {
  Future<List<DeliveryMethod>> getActiveMethods(int subtotalMinor);
}
