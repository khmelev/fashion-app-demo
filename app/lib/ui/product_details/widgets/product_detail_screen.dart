import 'package:fashion_app/ui/core/widgets/stub.dart';
import 'package:fashion_app/ui/product_details/widgets/similar_products.dart';
import 'package:fashion_app/ui/product_details/widgets/size_select_screen.dart';
import 'package:fashion_app/domain/models/product.dart';
import 'package:fashion_app/data/repositories/product_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows full details for a single [product].
class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key, required this._productId});

  final String _productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailsProvider(_productId));
    return productAsync.when(
      data: (product) {
        return Scaffold(
          appBar: AppBar(title: Text(product.name)),
          body: Column(
            children: [
              Expanded(child: _productDetails(context, product, ref)),
              _addToCartButton(context),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => StubWidget(
        onRetryPressed: () {
          ref.invalidate(productDetailsProvider(_productId));
        },
      ),
    );
  }

  Widget _productDetails(BuildContext context, Product product, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ColoredBox(color: Color(product.swatchColorValue)),
          ),
          const SizedBox(height: 16),
          Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          _similarProducts(context),
        ],
      ),
    );
  }

  Widget _similarProducts(BuildContext context) {
    return SimilarProducts(productId: _productId);
  }

  Widget _addToCartButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SizeSelectScreen(productId: _productId);
            },
          );
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text('Add to Cart'),
      ),
    );
  }
}
