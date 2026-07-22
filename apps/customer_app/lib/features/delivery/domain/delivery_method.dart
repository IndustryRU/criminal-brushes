class DeliveryMethod {
  const DeliveryMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.priceMinor,
    required this.estimatedDeliveryText,
    required this.isActive,
  });

  final String id;
  final String name;
  final String description;
  final int priceMinor;
  final String estimatedDeliveryText;
  final bool isActive;

  DeliveryMethod copyWith({
    String? id,
    String? name,
    String? description,
    int? priceMinor,
    String? estimatedDeliveryText,
    bool? isActive,
  }) {
    return DeliveryMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      priceMinor: priceMinor ?? this.priceMinor,
      estimatedDeliveryText:
          estimatedDeliveryText ?? this.estimatedDeliveryText,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DeliveryMethod && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
