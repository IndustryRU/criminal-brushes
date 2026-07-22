class Product {
  const Product({
    required this.id,
    required this.slug,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.collectionName,
    required this.basePriceMinor,
    required this.currency,
    required this.variants,
    required this.images,
    required this.features,
    required this.safetyNotes,
    required this.isFeatured,
    required this.mockRating,
    required this.mockReviewCount,
  });

  final String id;
  final String slug;
  final String name;
  final String subtitle;
  final String description;
  final String collectionName;
  final int basePriceMinor;
  final String currency;
  final List<ProductVariant> variants;
  final List<ProductImage> images;
  final List<ProductFeature> features;
  final List<String> safetyNotes;
  final bool isFeatured;
  final double mockRating;
  final int mockReviewCount;

  ProductVariant get defaultVariant =>
      variants.firstWhere((variant) => variant.isActive);

  Product copyWith({
    String? id,
    String? slug,
    String? name,
    String? subtitle,
    String? description,
    String? collectionName,
    int? basePriceMinor,
    String? currency,
    List<ProductVariant>? variants,
    List<ProductImage>? images,
    List<ProductFeature>? features,
    List<String>? safetyNotes,
    bool? isFeatured,
    double? mockRating,
    int? mockReviewCount,
  }) {
    return Product(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      collectionName: collectionName ?? this.collectionName,
      basePriceMinor: basePriceMinor ?? this.basePriceMinor,
      currency: currency ?? this.currency,
      variants: variants ?? this.variants,
      images: images ?? this.images,
      features: features ?? this.features,
      safetyNotes: safetyNotes ?? this.safetyNotes,
      isFeatured: isFeatured ?? this.isFeatured,
      mockRating: mockRating ?? this.mockRating,
      mockReviewCount: mockReviewCount ?? this.mockReviewCount,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Product && other.id == id && other.slug == slug;
  }

  @override
  int get hashCode => Object.hash(id, slug);
}

class ProductVariant {
  const ProductVariant({
    required this.id,
    required this.sku,
    required this.colorName,
    required this.colorHex,
    required this.priceMinor,
    required this.stockQuantity,
    required this.imageAsset,
    required this.isActive,
  });

  final String id;
  final String sku;
  final String colorName;
  final String colorHex;
  final int priceMinor;
  final int stockQuantity;
  final String imageAsset;
  final bool isActive;

  bool get isInStock => isActive && stockQuantity > 0;

  ProductVariant copyWith({
    String? id,
    String? sku,
    String? colorName,
    String? colorHex,
    int? priceMinor,
    int? stockQuantity,
    String? imageAsset,
    bool? isActive,
  }) {
    return ProductVariant(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      colorName: colorName ?? this.colorName,
      colorHex: colorHex ?? this.colorHex,
      priceMinor: priceMinor ?? this.priceMinor,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      imageAsset: imageAsset ?? this.imageAsset,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProductVariant && other.id == id && other.sku == sku;
  }

  @override
  int get hashCode => Object.hash(id, sku);
}

class ProductImage {
  const ProductImage({
    required this.assetPath,
    required this.altText,
    this.variantId,
    required this.sortOrder,
  });

  final String assetPath;
  final String altText;
  final String? variantId;
  final int sortOrder;

  @override
  bool operator ==(Object other) {
    return other is ProductImage &&
        other.assetPath == assetPath &&
        other.variantId == variantId;
  }

  @override
  int get hashCode => Object.hash(assetPath, variantId);
}

class ProductFeature {
  const ProductFeature({
    required this.icon,
    required this.title,
    required this.description,
  });

  final String icon;
  final String title;
  final String description;

  @override
  bool operator ==(Object other) {
    return other is ProductFeature &&
        other.icon == icon &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode => Object.hash(icon, title, description);
}
