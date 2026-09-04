import 'package:fashion_app/screens/catalog/product_tile.dart';
import 'package:fashion_app/services/product_service.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';

/// Displays the product catalog as a grid and reports taps via
/// [onProductSelected].
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key, required this.onProductSelected});

  final ValueChanged<Product> onProductSelected;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  List<Product>? _products;

  @override
  void initState() {
    super.initState();
    ProductService().getProducts().then((products) {
      setState(() {
        _products = products;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fashion App')),
      body: _products != null
          ? _gridView(_products!)
          : const Center(child: CircularProgressIndicator()),
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
          onTap: () => widget.onProductSelected(product),
        );
      },
    );
  }
}
