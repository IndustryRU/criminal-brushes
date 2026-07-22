class CheckoutDraft {
  const CheckoutDraft({
    this.customerName = '',
    this.email = '',
    this.phone = '',
    this.city = '',
    this.postalCode = '',
    this.addressLine1 = '',
    this.addressLine2 = '',
    this.deliveryMethodId = '',
    this.paymentMethod = 'mock-card',
    this.comment = '',
    this.consentAccepted = false,
  });

  final String customerName;
  final String email;
  final String phone;
  final String city;
  final String postalCode;
  final String addressLine1;
  final String addressLine2;
  final String deliveryMethodId;
  final String paymentMethod;
  final String comment;
  final bool consentAccepted;

  CheckoutDraft copyWith({
    String? customerName,
    String? email,
    String? phone,
    String? city,
    String? postalCode,
    String? addressLine1,
    String? addressLine2,
    String? deliveryMethodId,
    String? paymentMethod,
    String? comment,
    bool? consentAccepted,
  }) {
    return CheckoutDraft(
      customerName: customerName ?? this.customerName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      deliveryMethodId: deliveryMethodId ?? this.deliveryMethodId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      comment: comment ?? this.comment,
      consentAccepted: consentAccepted ?? this.consentAccepted,
    );
  }
}
