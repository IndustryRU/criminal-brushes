import 'package:criminal_brushes/core/content/mock_claims.dart';
import 'package:criminal_brushes/features/catalog/data/product_repository.dart';
import 'package:criminal_brushes/features/catalog/domain/product.dart';

class MockProductRepository implements ProductRepository {
  const MockProductRepository();

  @override
  Future<Product?> getBySlug(String slug) async {
    for (final product in mockProducts) {
      if (product.slug == slug) return product;
    }
    return null;
  }

  @override
  Future<List<Product>> getFeaturedProducts() async {
    return mockProducts.where((product) => product.isFeatured).toList();
  }

  @override
  Future<List<Product>> getProducts() async => mockProducts;
}

const mockProducts = [
  Product(
    id: 'tiny-trouble',
    slug: 'tiny-trouble',
    name: 'Tiny Trouble',
    subtitle: 'Electric toothbrush for little rebels',
    description:
        'A compact storefront MVP item with mock copy and placeholder visuals.',
    collectionName: 'Tiny Trouble Drop',
    basePriceMinor: 599000,
    currency: 'RUB',
    isFeatured: true,
    mockRating: 4.8,
    mockReviewCount: 42,
    variants: [
      ProductVariant(
        id: 'bubblegum-pink',
        sku: 'TT-BP-001',
        colorName: 'Bubblegum Pink',
        colorHex: '#FF5AAE',
        priceMinor: 599000,
        stockQuantity: 12,
        imageAsset: 'assets/images/products/tiny-trouble-pink.webp',
        isActive: true,
      ),
      ProductVariant(
        id: 'acid-lime',
        sku: 'TT-AL-001',
        colorName: 'Acid Lime',
        colorHex: '#D7FF22',
        priceMinor: 599000,
        stockQuantity: 8,
        imageAsset: 'assets/images/products/tiny-trouble-lime.webp',
        isActive: true,
      ),
      ProductVariant(
        id: 'stealth-black',
        sku: 'TT-SB-001',
        colorName: 'Stealth Black',
        colorHex: '#050505',
        priceMinor: 599000,
        stockQuantity: 0,
        imageAsset: 'assets/images/products/tiny-trouble-black.webp',
        isActive: true,
      ),
      ProductVariant(
        id: 'cool-blue',
        sku: 'TT-CB-001',
        colorName: 'Cool Blue',
        colorHex: '#3B82F6',
        priceMinor: 599000,
        stockQuantity: 5,
        imageAsset: 'assets/images/products/tiny-trouble-blue.webp',
        isActive: true,
      ),
    ],
    images: [
      ProductImage(
        assetPath: 'assets/images/products/tiny-trouble-pink.webp',
        altText: 'Mock product image for Tiny Trouble in Bubblegum Pink',
        variantId: 'bubblegum-pink',
        sortOrder: 1,
      ),
    ],
    features: [
      ProductFeature(
        icon: 'bolt',
        title: 'Bold visual mood',
        description: '${MockClaims.unapprovedClaimNote} Decorative MVP copy.',
      ),
      ProductFeature(
        icon: 'shield',
        title: 'Parent-friendly checkout',
        description: 'Calm transactional copy and local mock order flow.',
      ),
    ],
    safetyNotes: [
      '${MockClaims.unapprovedClaimNote} Add approved age guidance.',
      '${MockClaims.unapprovedClaimNote} Add verified care instructions.',
    ],
  ),
];
