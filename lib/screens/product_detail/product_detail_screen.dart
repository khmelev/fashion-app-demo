import 'package:fashion_app/screens/product_detail/size_select_screen.dart';
import 'package:fashion_app/models/product.dart';
import 'package:fashion_app/services/catalog_product_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows full details for a single [product].
class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Column(
        children: [
          Expanded(child: _productDetails(context, ref)),
          _addToCartButton(context),
        ],
      ),
    );
  }

  Widget _productDetails(BuildContext context, WidgetRef ref) {
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
          const SizedBox(height: 16),
          _similarProducts(context, ref),
        ],
      ),
    );
  }

  Widget _similarProducts(BuildContext context, WidgetRef ref) {
    final providerState = ref.watch(similarProductProvider(product.id));
    return providerState.when(
      data: (similarProducts) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Similar products',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: similarProducts.length,
                itemBuilder: (context, index) {
                  final item = similarProducts[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () {
                        // TODO
                      },
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(item.swatchColorValue),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => SizedBox(height: 20),
      error: (error, stackTrace) => SizedBox(height: 20),
    );
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
              return SizeSelectScreen(product: product);
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
