import 'package:criminal_brushes/features/catalog/data/mock_product_repository.dart';
import 'package:criminal_brushes/features/catalog/data/product_repository.dart';
import 'package:criminal_brushes/features/catalog/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => const MockProductRepository(),
);

final productListProvider = FutureProvider<List<Product>>((ref) {
  return ref.watch(productRepositoryProvider).getProducts();
});

final featuredProductListProvider = FutureProvider<List<Product>>((ref) {
  return ref.watch(productRepositoryProvider).getFeaturedProducts();
});

final productBySlugProvider = FutureProvider.family<Product?, String>((ref, slug) {
  return ref.watch(productRepositoryProvider).getBySlug(slug);
});

final catalogFilterProvider = StateProvider<String>((ref) => '');
