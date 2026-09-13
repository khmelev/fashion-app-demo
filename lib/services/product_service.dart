import 'package:fashion_app/models/product.dart';
import 'package:fashion_app/utils/const.dart';
import 'package:fashion_app/utils/fake_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _ProductService {
  Future<List<Product>> getProducts() async {
    await Future.delayed(mockNetworkDelay);
    return fakeProducts;
  }

  Future<List<Product>> getSimilarProducts(String productId) async {
    await Future.delayed(mockNetworkDelay);
    return fakeProducts.where((item) => item.id != productId).toList();
  }

  Future<Product> getProduct(String productId) async {
    await Future.delayed(mockNetworkDelay);
    return fakeProducts.firstWhere((item) => item.id == productId);
  }
}

final productServiceProvider = Provider<_ProductService>(
  (ref) => _ProductService(),
);

final catalogProductsProvider = FutureProvider.autoDispose<List<Product>>((
  ref,
) async {
  return ref.read(productServiceProvider).getProducts();
});

final similarProductsProvider = FutureProvider.autoDispose
    .family<List<Product>, String>((ref, param) {
      return ref.read(productServiceProvider).getSimilarProducts(param);
    });

final productProvider = FutureProvider.autoDispose.family<Product, String>((
  ref,
  param,
) {
  return ref.read(productServiceProvider).getProduct(param);
});
