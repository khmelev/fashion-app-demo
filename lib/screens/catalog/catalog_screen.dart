import 'package:fashion_app/screens/catalog/product_tile.dart';
import 'package:fashion_app/services/product_service.dart';
import 'package:flutter/material.dart';

import 'package:fashion_app/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerState = ref.watch(catalogProductsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Catalog')),
      body: providerState.when(
        data: (products) => _gridView(products),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _gridView(List<Product> products) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductTile(
          product: product,
          onTap: () => GoRouter.of(context).pushNamed('product_detail', pathParameters: {'id': product.id}),
        );
      },
    );
  }
}
