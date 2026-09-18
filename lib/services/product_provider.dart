import 'package:fashion_app/models/product.dart';
import 'package:fashion_app/services/product_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final catalogProductsProvider = FutureProvider.autoDispose<List<Product>>((
  ref,
) async {
  final service = await ref.watch(productServiceProvider.future);
  return await service.getProducts();
});

final similarProductsProvider = FutureProvider.autoDispose
    .family<List<Product>, String>((ref, param) async {
      final service = await ref.watch(productServiceProvider.future);
      return service.getSimilarProducts(param);
    });

final productProvider = FutureProvider.autoDispose.family<Product, String>((
  ref,
  param,
) async {
  final service = await ref.watch(productServiceProvider.future);
  return service.getProduct(param);
});
