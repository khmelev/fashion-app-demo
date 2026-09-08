import 'package:fashion_app/services/cart_service.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';

/// Shows full details for a single [product].
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.product,
    required this._cartService,
  });

  final Product product;
  final CartService _cartService;

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
      child: ElevatedButton(
        onPressed: () {
          _cartService
              .addItem(product: product, size: ProductSize.m, quantity: 1)
              .then((value) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Added to cart!')));
              });
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text('Add to Cart'),
      ),
    );
  }
}
