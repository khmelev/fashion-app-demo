import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fashion_app/data/services/shop_service_remote.dart';
import 'package:fashion_app/domain/models/product.dart';

abstract class ShopService {
  Future<List<Product>> getProducts();
  Future<List<Product>> getSimilarProducts(String productId);
  Future<Product> getProduct(String productId);
}

final shopServiceProvider = Provider<ShopService>((ref) {
  final productService = ShopServiceRemote.build();

  ref.onDispose(() => productService.shutdown());

  return productService;
});
