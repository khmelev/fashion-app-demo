import 'package:fashion_app/domain/models/product.dart';
import 'package:fashion_app/data/services/shop_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final catalogProductsProvider = FutureProvider.autoDispose<List<Product>>((
  ref,
) async {
  final service = ref.watch(shopServiceProvider);
  return await service.getProducts();
});

final similarProductsProvider = FutureProvider.autoDispose
    .family<List<Product>, String>((ref, param) async {
      final service = ref.watch(shopServiceProvider);
      return service.getSimilarProducts(param);
    });

final productDetailsProvider = FutureProvider.autoDispose
    .family<Product, String>((ref, param) async {
      final service = ref.watch(shopServiceProvider);
      return service.getProduct(param);
    });
