import 'package:criminal_brushes/features/checkout/domain/checkout_draft.dart';
import 'package:criminal_brushes/features/checkout/domain/mock_order_confirmation.dart';
import 'package:flutter_riverpod/legacy.dart';

final checkoutDraftProvider = StateProvider<CheckoutDraft>(
  (ref) => const CheckoutDraft(),
);

final mockOrderConfirmationProvider = StateProvider<MockOrderConfirmation?>(
  (ref) => null,
);
