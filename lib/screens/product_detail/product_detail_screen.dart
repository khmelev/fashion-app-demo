import 'package:fashion_app/services/cart_controller.dart';
import 'package:fashion_app/models/product.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows full details for a single [product].
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Column(
        children: [
          Expanded(child: _productDetails(context)),
          _addToCartButton(context),
        ],
      ),
    );
  }

  Widget _productDetails(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
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
          Text(product.description),
        ],
      ),
    );
  }

  Widget _addToCartButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: Consumer(
        builder: (context, ref, _) {
          return ElevatedButton(
            onPressed: () {
              ref
                  .read(cartControllerProvider.notifier)
                  .addItem(product: product, size: ProductSize.m, quantity: 1)
                  .then((value) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Added to cart!'),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                    }
                  });
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text('Add to Cart'),
          );
        },
      ),
    );
  }
}
