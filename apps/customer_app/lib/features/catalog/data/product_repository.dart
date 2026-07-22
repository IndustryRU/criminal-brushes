import 'package:criminal_brushes/features/catalog/domain/product.dart';

abstract interface class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product?> getBySlug(String slug);
  Future<List<Product>> getFeaturedProducts();
}
