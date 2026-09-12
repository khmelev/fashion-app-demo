import 'package:fashion_app/models/product.dart';
import 'package:fashion_app/utils/const.dart';
import 'package:fashion_app/utils/fake_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _ProductService {
  Future<List<Product>> getProducts() async {
    await Future.delayed(mockNetworkDelay);
    return fakeProducts;
  }
}

final productServiceProvider = Provider<_ProductService>(
  (ref) => _ProductService(),
);

final catalogProductProvider = FutureProvider.autoDispose<List<Product>>((
  ref,
) async {
  final productService = ref.watch(productServiceProvider);
  return productService.getProducts();
});
